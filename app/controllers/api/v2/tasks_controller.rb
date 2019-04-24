module Api::V2
class TasksController < ApplicationController
    swagger_controller :tasks, "Tasks Management"
    swagger_api :index do
        summary "Fetches all Tasks"
        param :query, :active, :boolean, :optional, "Filter on whether or not the task is active" 
        param :query, :alphabetical, :boolean, :optional, "Order tasks by alphabetical"
        notes "This lists all the Tasks"
    end
    swagger_api :show do
         summary "Shows one Task"
         param :path, :id, :integer, :required, "Task ID"
         notes "This lists details of one Task"
         response :not_found
    end
    swagger_api :create do
         summary "Creates a new Task"
         param :form, :name, :string, :required, "Name"
         param :form, :points, :integer, :required, "Point"
         param :form, :active, :boolean, :required, "Active"
         response :not_acceptable
    end
    swagger_api :update do
         summary "Updates an existing Task"
         param :path, :id, :integer, :required, "Task Id"
         param :form, :name, :string, :optional, "Name"
         param :form, :points, :integer, :optional, "Points"
         param :form, :active, :boolean, :optional, "Active"
         response :not_found
         response :not_acceptable
    end
    swagger_api :destroy do
         summary "Deletes an existing Task"
         param :path, :id, :integer, :required, "Task Id"
         response :not_found
    end
    # Controller Code
    before_action :set_tasks, only: [:show, :update, :destroy]
    
    # GET /task
    def index
        @task = Task.all
        
        if(params[:active].present?)    
             @task = params[:active] == "true" ? @task.active : @task.inactive  
         end
         
        if params[:alphabetical].present? && params[:alphabetical] == "true"   
             @task = @task.alphabetical
         end 
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
            render json: @task, status: :created, location: [:v2, @task]
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
end
