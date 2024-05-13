class Api::V1::WorkCatsController < ApplicationController
    skip_before_action :authenticate_request, only: [:index, :show]
    before_action :set_work_cat, only: %i[ show edit update destroy ]
    
    # GET /work_cats or /work_cats.json
    def index
      @work_cats = WorkCat.all
      render json: @work_cats
    end
    
    # GET /work_cats/1 or /work_cats/1.json
    def show
      @work_cat = WorkCat.find(params[:id])
      render json: @work_cat
    end
    
    # GET /work_cats/new
    def new
      @work_cat = WorkCat.new
    end
    
    # GET /work_cats/1/edit
    def edit
    end
    
    # POST /work_cats or /work_cats.json
    def create
      @work_cat = WorkCat.new(work_cat_params)
    
      if @work_cat.save
        redirect_to '/admin_view?which=work_cat'
        flash[:notice] = "新しい商品カテゴリーが作成されました！"
      else
        flash.now[:alert] = "作成に失敗しました"
      end
    end
    
    # DELETE /work_cats/1 or /work_cats/1.json
    def destroy
      @work_cat.destroy
    
      respond_to do |format|
        format.html { redirect_to work_cats_url, notice: "WorkCat was successfully destroyed." }
        format.json { head :no_content }
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_work_cat
        @work_cat = WorkCat.find(params[:id])
      end
    
      # Only allow a list of trusted parameters through.
      def work_cat_params
        params.require(:work_cat).permit(:name)
      end
end
  