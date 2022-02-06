class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # GET /instructors
    def index
        render json: Instructor.all, status: 200
    end

    # GET /instructors/:id
    def show
        instructor_to_display = find_instructor
        render json: instructor_to_display, status: 200
    end

    # POST /instructors
    def create
        new_instructor = Instructor.create!(instructor_params)
        render json: new_instructor, status: 201
    end

    # PATCH /instructors/:id
    def update
        instructor_to_update = find_instructor
        instructor_to_update.update!(instructor_params)
        render json: instructor_to_update, status: 200
    end

    # DESTROY /instructors/:id
    def destroy
        instructor_to_destroy = find_instructor
        instructor_to_destroy.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def find_instructor
        Instructor.find(params[:id])
    end

    def render_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

    def render_not_found_response(invalid)
        render json: { errors: invalid }, status: 404
    end

end
