class ReserchesController < ApplicationController
  before_action :set_reserch, only: [:show, :edit, :update, :destroy]

  # GET /reserches
  # GET /reserches.json
  def index
    @reserches = Reserch.all
  end

  # GET /reserches/1
  # GET /reserches/1.json
  def show
  end

  # GET /reserches/new
  def new
    @reserch = Reserch.new
  end

  # GET /reserches/1/edit
  def edit
  end

  # POST /reserches
  # POST /reserches.json
  def create
    @reserch = Reserch.new(reserch_params)

    respond_to do |format|
      if @reserch.save
        format.html { redirect_to @reserch, notice: 'Reserch was successfully created.' }
        format.json { render :show, status: :created, location: @reserch }
      else
        format.html { render :new }
        format.json { render json: @reserch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reserches/1
  # PATCH/PUT /reserches/1.json
  def update
    respond_to do |format|
      if @reserch.update(reserch_params)
        format.html { redirect_to @reserch, notice: 'Reserch was successfully updated.' }
        format.json { render :show, status: :ok, location: @reserch }
      else
        format.html { render :edit }
        format.json { render json: @reserch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reserches/1
  # DELETE /reserches/1.json
  def destroy
    @reserch.destroy
    respond_to do |format|
      format.html { redirect_to reserches_url, notice: 'Reserch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reserch
      @reserch = Reserch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reserch_params
      params.require(:reserch).permit(:japan_image_url, :japan_title, :japan_url, :japan_description, :japan_price, :china_image_url, :china_title, :china_url, :china_price, :item_id, :user_id)
    end
end
