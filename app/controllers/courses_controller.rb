class CoursesController < ApplicationController
  def index
    @courses = Course.all.as_json(include: [:tutors])
    render json: @courses
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def course_params
    params.require(:course).permit(:id,:name,:description, :price, tutors_attributes: [:id, :name,:age,:experience,:_destroy])
  end
end
