class PsController < ApplicationController
  before_action :set_p, only: [:show, :edit, :update, :destroy]

  # GET /ps
  # GET /ps.json
  def index
    @ps = P.all
  end

  # GET /ps/1
  # GET /ps/1.json
  def show
  end

  # GET /ps/new
  def new
    @p = P.new
  end

  # GET /ps/1/edit
  def edit
  end

  # POST /ps
  # POST /ps.json
  def create
    @p = P.new(p_params)

    respond_to do |format|
      if @p.save
        format.html { redirect_to @p, notice: 'P was successfully created.' }
        format.json { render :show, status: :created, location: @p }
      else
        format.html { render :new }
        format.json { render json: @p.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ps/1
  # PATCH/PUT /ps/1.json
  def update
    respond_to do |format|
      if @p.update(p_params)
        format.html { redirect_to @p, notice: 'P was successfully updated.' }
        format.json { render :show, status: :ok, location: @p }
      else
        format.html { render :edit }
        format.json { render json: @p.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ps/1
  # DELETE /ps/1.json
  def destroy
    @p.destroy
    respond_to do |format|
      format.html { redirect_to ps_url, notice: 'P was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_p
      @p = P.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def p_params
      params.require(:p).permit(:title, :description, :image_url, :price)
    end
end
