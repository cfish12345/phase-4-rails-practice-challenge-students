class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_not_valid_response

    def index
        if params[:instructor_id]
            instructor = Instructor.find(params[:instructor_id])
            students = instructor.students
        else
            students = Student.all
        end
        render json: students, include: :instructor
    end

    def show
        if params[:instructor_id]
            instructor = Instructor.find(params[:instructor_id])
            students = instructor.students.find_by(id: params[:id])
        else
            students = Student.find_by(id: params[:id])
        end
        render json: students, include: :instructor
    end

    def create
        if params[:instructor_id]
            instructor = Instructor.find(params[:instructor_id])
            student = Student.create(student_params)
            
        else
            render json: {error: "instructor not found"}, status: :not_found
        end
        render json: student, include: :instructor
    end

    def update
        if params[:instructor_id]
            instructor = Instructor.find(params[:instructor_id])
            student = Student.find_by(id: params[:id])
            student.update(student_params)
        else
            render json: {error: "Couldn't find student"}, status: :not_found
        end
        render json: student, include: :instructor
    end

    def destroy
        student = Student.find_by(id: params[:id])
        if student
            student.destroy
            render json: {}
        else
            render json: {error: "Student not found"}, status: :not_found
        end
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_not_found_response
        render json: {error: "Not Found"}, status: :not_found
    end

    def render_not_valid_response
        render json: {error: "Name can't be blank"}, status: :unprocessable_entity
    end
    
end

