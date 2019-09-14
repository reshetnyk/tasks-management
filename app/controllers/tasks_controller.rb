class TasksController < ApplicationController


  def index
    @tasks = current_user.tasks
    @status = params[:status]
    @sort = params[:sort]

    if @status
      if @status.downcase == 'active'
        @tasks = @tasks.where(is_completed: false)
      end

      if @status.downcase == 'completed'
        @tasks = @tasks.where(is_completed: true)
      end
    end

    if @sort
      if @sort.downcase == 'asc'
        @tasks = @tasks.order(Task.arel_table['title'])
      end

      if @sort.downcase == 'desc'
        @tasks = @tasks.order(Task.arel_table['title'].desc)
      end
    end
  end

  def create
    if params[:task]
      @task = current_user.tasks.build(task_params)
      if @task.save
        redirect_to @task
      else
        render 'tasks/create'
      end
    else
      @task = current_user.tasks.build
      render 'tasks/create'
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
end



