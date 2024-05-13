class Api::V1::NewsCatsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
  before_action :set_news_cat, only: %i[ show edit update destroy ]
    
    # GET /news_cats or /news_cats.json
    def index
      @news_cats = NewsCat.all
      render json: @news_cats
    end
    
    # GET /news_cats/1 or /news_cats/1.json
    def show
      @news_cat = NewsCat.find(params[:id])
      render json: @news_cat
    end
    
    # GET /news_cats/new
    def new
      @news_cat = NewsCat.new
    end
    
    # GET /news_cats/1/edit
    def edit
    end
    
    # POST /news_cats or /news_cats.json
    def create
      @news_cat = NewsCat.new(news_cat_params)
    
      if @news_cat.save
        redirect_to '/admin_view?which=news_cat'
        flash[:notice] = "新しいニュースカテゴリーが作成されました！"
      else
        flash.now[:alert] = "作成に失敗しました"
      end
    end
    
    # DELETE /news_cats/1 or /news_cats/1.json
    def destroy
      @news_cat.destroy
    
      respond_to do |format|
        format.html { redirect_to news_cats_url, notice: "NewsCat was successfully destroyed." }
        format.json { head :no_content }
      end
    end
    
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_news_cat
        @news_cat = NewsCat.find(params[:id])
      end
    
      # Only allow a list of trusted parameters through.
      def news_cat_params
        params.require(:news_cat).permit(:name)
      end
end
  