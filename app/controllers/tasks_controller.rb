class TasksController < ApplicationController
  
  def index
      @tasks = Task.all.page(params[:page]).order(id: :desc).per(10)
  end

  def show
     set_task
     
  end

  def new
      @task=Task.new
  end

  def create
      @task=Task.new(task_params)
      if @task.save
      flash[:success] = 'タスクが正常に作成されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが作成されませんでした'
      render :new
    end
  end

  def edit
    set_task
  end

  def update
     set_task
    if @task.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  #Strong Parameter
  def set_task
    @task=Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content,:status)
  end
end