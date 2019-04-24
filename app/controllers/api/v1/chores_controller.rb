module Api::V1
class ChoresController < ApplicationController
    swagger_controller :chores, "Chores Management"
    swagger_api :index do
        summary "Fetches all Chores"
        param :query, :done, :boolean, :optional, "Filter on whether or not the chore is done" 
        param :query, :upcoming, :boolean, :optional, "Filter on whether or not the chore is done"
        param :query, :chronological, :boolean, :optional, "Order tasks by chronological" 
        param :query, :by_task, :boolean, :optional, "Order tasks by task"
        notes "This lists all the Chores"
    end
    swagger_api :show do
         summary "Shows one Task"
         param :path, :id, :integer, :required, "Chore ID"
         notes "This lists details of one Chore"
         response :not_found
    end
    swagger_api :create do
         summary "Creates a new Chore"
         param :form, :child_id, :integer, :required, "Child_ID"
         param :form, :task_id, :integer, :required, "Task_ID"
         param :form, :due_on, :date, :required, "Due_On"
         param :form, :completed, :boolean, :required, "Completed"
         response :not_acceptable
    end
    swagger_api :update do
         summary "Updates an existing Chore"
         param :form, :child_id, :integer, :required, "Child_ID"
         param :form, :task_id, :integer, :optional, "Task_ID"
         param :form, :due_on, :date, :optional, "Due_On"
         param :form, :completed, :boolean, :optional, "Completed"
         response :not_found
         response :not_acceptable
    end
    swagger_api :destroy do
         summary "Deletes an existing Chore"
         param :path, :id, :integer, :required, "Chore Id"
         response :not_found
    end
    # Controller Code
    before_action :set_chores, only: [:show, :update, :destroy]
    
    # GET /chore
    def index
        @chore = Chore.all
        
        if(params[:done].present?)    
             @chore = params[:done] == "true" ? @chore.done : @chore.pending  
        end
        
        if(params[:upcoming].present?)    
             @chore = params[:upcoming] == "true" ? @chore.upcoming : @chore.past  
        end
         
        if params[:chronological].present? && params[:chronological] == "true"   
             @chore = @chore.chronological
        end 
        
        if params[:by_task].present? && params[:by_task] == "true"   
             @chore = @chore.by_task
        end 
         
        render json: @chore
    end
    
    # GET /chore/1
    def show
        render json: @chore
    end
    
    # POST /chore
    def create
        @chore = Chore.new(chore_params)
        if @chore.save
            render json: @chore, status: :created, location: [:v1, @chore]
        else
            render json: @chore.errors, status: :unprocessable_entity
        end
    end
    
    # PATCH/PUT /chore/1
    def update
        if @chore.update(chore_params)
            render json: @chore
        else
            render json: @chore.errors, status: :unprocessable_entity
        end
    end
    
    # DELETE /chore/1
    def destroy
        @chore.destroy
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_chores
        @chore = Chore.find(params[:id])
    end
    
    # Only allow a trusted parameter "white list" through.
    def chore_params
        params.permit(:child_id, :task_id, :due_on, :completed)
    end
end
end
