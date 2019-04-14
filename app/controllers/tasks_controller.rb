class TasksController < ApplicationController
    # Controller Code
    before_action :set_tasks, only: [:show, :update, :destroy]
    
    # GET /task
    def index
        @task = Task.all
        render json: @task
    end
    
    # GET /task/1
    def show
        render json: @task
    end
    
    # POST /task
    def create
        @task = Task.new(task_params)
        if @task.save
            render json: @task, status: :created, location: @task
        else
            render json: @task.errors, status: :unprocessable_entity
        end
    end
    
    # PATCH/PUT /task/1
    def update
        if @task.update(task_params)
            render json: @task
        else
            render json: @task.errors, status: :unprocessable_entity
        end
    end
    
    # DELETE /task/1
    def destroy
        @task.destroy
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_tasks
        @task = Task.find(params[:id])
    end
    
    # Only allow a trusted parameter "white list" through.
    def task_params
        params.permit(:name, :points, :active)
    end
end
