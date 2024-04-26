class Api::V1::InstrumentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :

  def index
    @instruments = Instrument.all
    render json: @instruments
  end

  def show
    @instrument = Instrument.find(params[:id])
    render json: @instrument
  end

  def create
    @instrument = Instrument.new(instrument_params)
    if @instrument.save
      render json: @instrument
    else
      render json: { error: 'unable to add instrument' }, status: 400
    end
  end

  def update
    begin
      @instrument = Instrument.find(params[:id])
      @instrument.update(instrument_params)
      render json: { message: "Instrument updates"}, status: 200
    rescue
      render json: { error: "Unable to update instrument" }, status: 400
    end
  end

  def destroy
    begin
      @instrument = Instrument.find(params[:id])
      @instrument.destroy
      render json: { message: "Instrument removed" }, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Error, instrument not removed" }, status: 400
    end
  end

  private

  def instrument_params
    params.require(:instrument).permit(:name)
  end

end
