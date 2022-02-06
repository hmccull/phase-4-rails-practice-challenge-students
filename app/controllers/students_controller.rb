class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # GET /students
    def index
        render json: Student.all, status: 200
    end

    # GET /students/:id
    def show
        student_to_display = find_student
        render json: student_to_display, status: 200
    end

    # POST /students
    def create
        new_student = Student.create!(student_params)
        render json: new_student, status: 201
    end

    # PATCH /students/:id
    def update
        student_to_update = find_student
        student_to_update.update!(student_params)
        render json: student_to_update, status: 200
    end

    # DESTROY /students/:id
    def destroy
        student_to_destroy = find_student
        student_to_destroy.destroy
        head :no_content
    end

    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

    def render_not_found_response(invalid)
        render json: { errors: invalid }, status: 404
    end
end
