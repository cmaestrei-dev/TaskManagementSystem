class Tasks::NotesController < ApplicationController
  before_action :set_task
  def  create
    @note = @task.notes.new(note_params)
    @note.user = current_user

    if @note.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @task, notice: "Nota creada con éxito" }
      end
    else
      redirect_to @task, alert: "No se pudo crear la nota"
    end
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end

  def set_task
    @task = Task.find(params[:task_id])
  end
end
