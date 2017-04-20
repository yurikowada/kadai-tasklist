class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @messages = Task.all
  end
  
  def show
    #@message = Task.find(params[:id])
    #set_task
  end

  def new
    @message = Task.new
  end

  def edit
    #@message = Task.find(params[:id])
    #set_task
  end
  
  def create
    @message = Task.new(task_params)
    
    if @message.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @message
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end
    
  def update
    #@message = Task.find(params[:id])
    #set_task
    
      if @message.update(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @message
      else
        flash.now[:danger] = 'Task は更新されませんでした'
        render :edit
      end
  end
  
  def destroy
    #@message = Task.find(params[:id])
    #set_task
    @message.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  private
    
    def set_task
      @message = Task.find(params[:id])
    end
    
    def task_params
      params.require(:task).permit(:content, :status)
    end
    
    
end
