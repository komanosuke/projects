class Api::V1::WorksController < ApplicationController
    skip_before_action :authenticate_request, only: [:index, :show]
    before_action :set_work, only: %i[ show edit update destroy ]

    def index
        @works = Work.all
        p @works.length
        render json: @works
    end

    # GET /works/1 or /works/1.json
    def show
        @work = Work.find(params[:id])
        render json: @work
    end
    
    # GET /works/new
    def new
        @work = Work.new
        @work_cat = WorkCat.all

        @work_cat_id_list = []
        @work_cat.each do |wc|
        l = []
        l.push(wc.name)
        l.push(wc.id)
        @work_cat_id_list.push(l)
        end
    end

    # GET /works/1/edit
    def edit
        @work_cat_id_list = []
        @work_cats = WorkCat.all
        @work_cats.each do |wc|
        l = []
        l.push(wc.name)
        l.push(wc.id)
        @work_cat_id_list.push(l)
        end
    end

    # POST /works or /works.json
    def create
        @work = Work.new(work_params)

        # respond_to do |format|
        if @work.save
            redirect_to '/admin_view?which=work'
            flash[:notice] = "新しい商品が作成されました！"
            # format.html { redirect_to work_url(@work), notice: "Work was successfully created." }
            # format.json { render :show, status: :created, location: @work }
        else
            flash.now[:alert] = "作成に失敗しました"
            # format.html { render :new, status: :unprocessable_entity }
            # format.json { render json: @work.errors, status: :unprocessable_entity }
        end
        # end
    end

    # PATCH/PUT /works/1 or /works/1.json
    def update
        if @work.update(work_params)
        redirect_to "/works/" + params[:id] + "/edit"
        flash[:notice] = "商品が更新されました！"
        else
        flash.now[:alert] = "作成に失敗しました"
        end
    end

    # DELETE /works/1 or /works/1.json
    def destroy
        @work.destroy

        respond_to do |format|
        format.html { redirect_to works_url, notice: "Work was successfully destroyed." }
        format.json { head :no_content }
        end
    end

    private
    def set_work
        @work = Work.find(params[:id])
    end

    def work_params
        params.require(:work).permit(:work_cat_id, :title, :image, :price, :text, :onlyone, :status)
    end
end
