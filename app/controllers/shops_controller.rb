require "barby/barcode/qr_code"
require 'barby/outputter/svg_outputter'

class ShopsController < ApplicationController
  before_action :set_shop, only: %i[ show edit update destroy ]

  # GET /shops or /shops.json
  def index
    @shops = Shop.all
  end

  # GET /shops/1 or /shops/1.json
  def show
    @barcode = Barby::QrCode.new("https://riverye.com/").to_svg(xdim: 12).html_safe
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  # GET /shops/1/edit
  def edit
  end

  # POST /shops or /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: "Shop was successfully created." }
        format.json { render :show, status: :created, location: @shop }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1 or /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: "Shop was successfully updated." }
        format.json { render :show, status: :ok, location: @shop }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1 or /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url, notice: "Shop was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def download_pdf
    pdf_path = Rails.root.join('data/river_demo_pdf.pdf')

    send_file pdf_path
  end

  def export_shops_xlsx
    xlsx = ShopsExcel::Generator.new.execute

    send_data(xlsx.to_stream.read, type: 'application/xlsx', filename: '商家總表.xlsx')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shop_params
      params.require(:shop).permit(:name, :email, :note)
    end
end
