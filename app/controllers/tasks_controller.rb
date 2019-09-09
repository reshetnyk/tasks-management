class TasksController < ApplicationController


  def index
    @tasks = Task.where(user_id: current_user.id)
    sort_tasks
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to @task
    else
      puts @task.errors.inspect
      render 'new'
    end
  end

  def show
    @task = Task.find(params[:id])
    if_someones_elses_task(@task)
  end

  def destroy_multiple
    if params.include? :tasks_to_delete
      Task.destroy(params[:tasks_to_delete])
    end

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end

  def edit
    @task = Task.find(params[:id])
    if_someones_elses_task(@task)
  end

  def update
    @task = Task.find(params[:id])
    if_someones_elses_task(@task)

    if @task.update(task_params)
      redirect_to @task, alert: "The task was successfully updated."
    else
      render 'edit'
    end

  end

  def destroy
    @task = Task.find(params[:id])
    if_someones_elses_task(@task)
    @task.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.json { head :no_content }
    end
  end

  def complete
    @task = Task.find(params[:id])
    if_someones_elses_task(@task)
    @task.update_attribute(:is_completed, !@task.is_completed)
    respond_to do |format|
      format.js
    end
  end

  def completed
    @tasks = Task.where(user_id: current_user.id, is_completed: true)
    sort_tasks
  end

  def active
    @tasks = Task.where(user_id: current_user.id, is_completed: false)
    sort_tasks
  end

  def access_denied
  end

  private def if_someones_elses_task(task)
    if task.user_id != current_user.id
      render 'access_denied'
    end
  end
  private def task_params
    params.require(:task).permit(:title, :description, :priority, :due_date)
  end
  private def sort_tasks
    @sort = params[:sort]
    puts params
    if @sort == 'title'
      @tasks = @tasks.order(Task.arel_table['title'])
    end
  end
end



