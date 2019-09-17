class TasksController < ApplicationController


  def index
    @tasks = current_user.tasks

    if params.include? :status
      if params[:status].downcase == 'active'
        @tasks = @tasks.where(is_completed: false)
      end

      if params[:status].downcase == 'completed'
        @tasks = @tasks.where(is_completed: true)
      end
    end

    if params.include? :sort
      if params[:sort].downcase == 'asc'
        @tasks = @tasks.order(Task.arel_table['title'])
      end

      if params[:sort].downcase == 'desc'
        @tasks = @tasks.order(Task.arel_table['title'].desc)
      end
    end
  end

  def create
    if params.include? :task
      @task = current_user.tasks.build(task_params)
      if @task.save
        redirect_to @task, notice: "Task was created."
      else
        render 'tasks/create'
      end
    else
      @task = current_user.tasks.build
      render 'tasks/create'
    end
  end

  def show
    begin
      @task = current_user.tasks.find(params[:id])
      if params.include? :act
        if params[:act] == 'update'
          render 'tasks/update'
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      @error = 'There is no such a task with \'id\'=\'' + params[:id] + '\'.'
      render '/tasks/error'
    end
  end

  def update
    if params.include? :act
      if params[:act] == 'complete'
        @task = current_user.tasks.find(params[:id])
        @task.update_attribute(:is_completed, !@task.is_completed)
        @act = params[:act]
        if params.include? :animate
          @animate = params[:animate]
        end
        respond_to do |format|
          format.js
        end
      end
    else
      @task = current_user.tasks.find(params[:id])
      if @task.update(task_params)
        redirect_to @task, notice: "The task was successfully updated."
      else
        render 'tasks/update'
      end
    end
  end

  def destroy
    if params.include? :tasks_to_delete
      Task.destroy(params[:tasks_to_delete])
      flash[:error] = 'Tasks were deleted.'
      redirect_back fallback_location: root_path
    else
      @task = current_user.tasks.find(params[:id])
      @task.destroy
      flash[:error] = 'Task was deleted.'
      redirect_to '/tasks'
    end
  end

  private def task_params
    params.require(:task).permit(:title, :description, :priority, :due_date)
  end
end



