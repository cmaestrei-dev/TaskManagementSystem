class TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def index
    # Usamos el nombre de la tabla real 'participants' que vimos en tu log de error
    @tasks = Task.includes(:category, :owner, participations: :user)
                 .left_joins(:participations)
                 .where(
                   'tasks.owner_id = ? OR participants.user_id = ?',
                   current_user.id,
                   current_user.id
                 ).distinct
  end

  def show
    # @task ya está cargado por load_and_authorize_resource
  end

  def new
    # @task ya está inicializado por load_and_authorize_resource
    @task.participations.build
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task, notice: t('tasks.create.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('tasks.update.updated'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: t('tasks.destroy.destroyed'), status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(
      :name, 
      :description, 
      :due_date, 
      :category_id, 
      participations_attributes: [:id, :user_id, :role, :_destroy]
    )
  end

  # GET /tasks/add_participation
  def add_participation
    @task = Task.new
    @participation = @task.participations.build
    
    respond_to do |format|
      format.turbo_stream
    end
  end
end