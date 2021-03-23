class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  # before_action :correct_user
  
  def index
      # @tasks = Task.order(id: :desc).page(params[:page])
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end

  def show
    # @task = Task.find(params[:id])
    # @task = current_user.tasks.find(params[:id])
  end

  def new
    # @task = Task.new
    # @task = current_user.task.new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    # @task = Task.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to @task
    else
      # @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      # @tasks = Tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
    # @task = current_user.tasks.find(params[:id])
    # @task = Task.find(params[:id])
  end

  def update
    # @task = Task.find(params[:id])
    # @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    # @task = Task.find(params[:id])
    # @task = current_user.tasks.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  # private

  # # Strong Parameter
  # def task_params
  #   params.require(:task).permit(:content, :status, :user)
  # end
  
  
private
  
  def set_task
    # @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
