class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def create
    # render plain: params[:task].inspect
    @task = Task.new(task_params)

    @task.save
    redirect_to tasks_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :completed, :due)
  end
end
