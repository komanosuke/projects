class Api::V1::ContactsController < ApplicationController
    skip_before_action :authenticate_request, only: [:subject, :create]

    def subject
        render json: Contact.subjects.keys
    end

    def create
        @contact = Contact.new(contact_params)
        ActiveRecord::Base.transaction do
            if @contact.save
                if ContactMailer.send_mail(@contact).deliver_now
                    render json: { status: 'success', message: 'メールが正常に送信されました。' }, status: :ok
                else
                    raise ActiveRecord::Rollback, 'メールの送信に失敗しました。'
                end
            else
                render json: { status: 'error', message: '保存に失敗しました。', errors: @contact.errors.full_messages }, status: :unprocessable_entity
            end
        end
    rescue ActiveRecord::Rollback => e
        render json: { status: 'error', message: e.message }, status: :internal_server_error
    end

    private
    def contact_params
        params.require(:contact).permit(:name, :email, :phone_number, :subject, :message)
    end
end
