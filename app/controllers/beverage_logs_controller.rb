class BeverageLogsController < ApplicationController
  before_action :set_beverage, only: %i[show edit update destroy]
  def index
    @beverage_logs = BeverageLog.all
  end

  def show;  end

  def new
    @beverage_log = BeverageLog.new
  end

  def create
    @beverage_log = BeverageLog.new(beverage_log_params)
    if @beverage_log.save
      redirect_to root_path, notice: "Beverage logged successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit;  end

  def update
    if @beverage_log.update(beverage_log_params)
      redirect_to root_path, notice: "Beverage log updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @beverage_log.destroy
    redirect_to root_path, notice: "Beverage log deleted!"
  end

  private
  def set_beverage
    @beverage_log = BeverageLog.find(params[:id])
  end

  def beverage_log_params
    params.require(:beverage_log).permit(:date, :time, :quantity, :unit, :temperature, :notes, :image, :other_addition, :other_category, :category_id, :subcategory_id, :other_symptom, :symptom_severity, :symptom_timing, :symptom_occurred, additions: [], symptoms: [])
  end
end