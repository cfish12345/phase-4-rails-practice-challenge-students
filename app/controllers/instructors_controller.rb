class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid_response
    def show
        instructor = Instructor.find_by(id: params[:id])
        render json: instructor
    end

    def index
        render json: Instructor.all
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.update(instructor_params)
            render json: instructor, status: :accepted
        else
            render json: {error: "Couldn't find instructor"}, status: :not_found
        end
    end

    def destroy
        instructor = Instructor.find_by(id: params[:id])
        if instructor
            instructor.destroy
            render json: {}
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_not_found_response
        render json: {error: "Not Found"}, status: :not_found
    end

    def render_not_valid_response
        render json: {error: "Name can't be blank"}, status: :unprocessable_entity
    end
end
