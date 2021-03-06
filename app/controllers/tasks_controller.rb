class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :select_user, only: [:edit, :update, :show]

  def index
     @tasks = current_user.tasks.page(params[:page])
  end
  
  def show
    #@task = Task.find(params[:id])
    #set_task
  end

  def new
    @task = Task.new
  end

  def edit
    #@task = Task.find(params[:id])
    #set_task
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @task
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end
    
  def update
    #@task = Task.find(params[:id])
    #set_task
    
      if @task.update(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'Task は更新されませんでした'
        render :edit
      end
  end
  
  def destroy
    #@task= Task.find(params[:id])
    #set_task
    @task.destroy
      flash[:success] = 'Task は正常に削除されました'
      redirect_to root_path
  end
  
  private
    
    def require_user_logged_in
      unless logged_in?
        redirect_to login_url
      end
    end
    
    def counts(user)
    @count_tasks = user.tasks.count
    end
  
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:content, :status)
    end
    
    def correct_user
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
      flash[:danger] = '他のユーザのTask は削除できません'
      redirect_to root_path
      end
    end
    
    def select_user
      @task = Task.find(params[:id])
      redirect_to root_path if @task.user != current_user
    end
  
end
