class Api::V1::VolunteersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @volunteers = Volunteer.all
    render json: @volunteers
  end

  def show
    @volunteer = Volunteer.find(params[:id])
    render json: @volunteer
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    if @volunteer.save
      render json: @volunteer
    else
      render json: { error: 'unable to add volunteer' }, status: 400
    end
  end

  def update
    begin
      @volunteer = Volunteer.find(params[:id])
      @volunteer.update(volunteer_params)
      render json: { message: "Volunteer updates"}, status: 200
    rescue
      render json: { error: "Unable to update volunteer" }, status: 400
    end
  end

  def destroy
    begin
      @volunteer = Volunteer.find(params[:id])
      @volunteer.destroy
      render json: { message: "Volunteer removed" }, status: 200
    rescue ActiveRecord::RecordNotFound
      render json: { message: "Error, volunteer not removed" }, status: 400
    end
  end

  private

  def find_volunteer
    @volunteer = Volunteer.find(params[:id])
  end

  def volunteer_params
    params.require(:volunteer).permit(:name)
  end

end
