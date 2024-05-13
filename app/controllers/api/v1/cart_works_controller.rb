class Api::V1::CartWorksController < ApplicationController
    before_action :set_cart_work, only: %i[ update destroy ]
    # skip_before_action :authenticate_request, only: [:index, :show]
    
    # GET /cart_works or /cart_works.json
    def index
      begin
        # ユーザーのカートを確認
        cart = @current_user.cart
        if cart.nil?
          # カートが存在しない場合
          render json: { error: 'カートが見つかりません。' }, status: :not_found
          return
        end
    
        # カート作品の取得とレンダリング
        @cart_works = CartWork.includes(:work).where(cart_id: cart.id)
        render json: @cart_works.map { |cart_work|
          {
            id: cart_work.work.id,
            work_cat_id: cart_work.work.work_cat_id,
            title: cart_work.work.title,
            image: cart_work.work.image,
            price: cart_work.work.price,
            text: cart_work.work.text,
            onlyone: cart_work.work.onlyone,
            status: cart_work.work.status,
            created_at: cart_work.work.created_at,
            updated_at: cart_work.work.updated_at,

            cart_work_id: cart_work.id,
            quantity: cart_work.quantity
          }
        }
      rescue StandardError => e
        # 予期せぬエラーのキャッチとハンドリング
        render json: { error: '内部サーバーエラー', details: e.message }, status: :internal_server_error
      end
    end
    
    # POST /cart_works or /cart_works.json
    def create
      @cart_work = CartWork.new(cart_work_params)
    
      if @cart_work.save
        @work = Work.find(cart_work_params[:work_id])
        status = @work.onlyone == true ? 'checked' : 'now_on_sale'
        @cart_work.update(status: status)
        
        render json: { message: 'カートに追加されました。', cart_work: @cart_work }, status: :created
      else
        render json: { error: 'カートの作成に失敗しました。' }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /cart_works/:id or /cart_works/:id.json
    def update
      if @cart_work.update(cart_work_params)
        @work = Work.find(@cart_work.work_id)
        status = @work.onlyone == true ? 'checked' : 'now_on_sale'
        @cart_work.update(status: status)
        
        render json: { message: 'カートが更新されました。', cart_work: @cart_work }, status: :ok
      else
        render json: { error: 'カートの更新に失敗しました。' }, status: :unprocessable_entity
      end
    end
    
    # DELETE /cart_works/1 or /cart_works/1.json
    def destroy
      if @cart_work.destroy
        render json: { message: 'カートのアイテムが削除されました。' }, status: :ok
      else
        render json: { error: 'カートのアイテム削除に失敗しました。' }, status: :unprocessable_entity
      end
    end

    # ログイン時にローカルストレージのカート情報を同期
    def sync
      ActiveRecord::Base.transaction do
        # フロントエンドから送られたカートデータを処理
        params[:cart].each do |work|
          cart_work = @current_user.cart.cart_works.find_by(work_id: work[:id])
          if cart_work
            # 既存のアイテムがあれば数量を更新
            cart_work.update(quantity: cart_work.quantity + work[:quantity].to_i)
          else
            # 新しいアイテムをカートに追加
            @cart_work = CartWork.new(
              cart_id: @current_user.cart.id,
              work_id: work[:id],
              quantity: work[:quantity]
            )

            if @cart_work.save
              @work = Work.find(work[:id])
              status = @work.onlyone == true ? 'checked' : 'now_on_sale'
              @cart_work.update(status: status)
            else
              p "Failed to save cart work: #{@cart_work.errors.full_messages}"
            end
          end
        end
      end
      render json: { status: 'success', message: 'Cart synced successfully' }, status: :ok
    rescue StandardError => e
      render json: { status: 'error', message: 'Failed to sync cart', error: e.message }, status: :unprocessable_entity
    end

    def pay
      begin
        @current_user.cart.cart_works.destroy_all
        render json: { status: 'success', message: 'Cart emptied successfully' }, status: :ok
      rescue StandardError => e
        render json: { status: 'error', message: 'Failed to empty cart', error: e.message }, status: :unprocessable_entity
      end
    end
    
    private
      def set_cart_work
        @cart_work = CartWork.find(params[:id])
      end
    
      def cart_work_params
        params.require(:cart_work).permit(:work_id, :quantity).merge(cart_id: @current_user.cart.id)
      end
end
