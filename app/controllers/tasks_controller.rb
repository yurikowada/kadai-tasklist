class TasksController < ApplicationController
  def index
    @messages = Task.all
  end
  
  def show
    @message = Task.find(params[:id])
  end

  def new
    @message = Task.new
  end

  def edit
    @message = Task.find(params[:id])
  end
  
  def create
    @message = Task.new(task_params)
    
    if @message.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to @message
    else
      flash.new[:danger] = 'Task が投稿されませんでした'
    end
  end
    
  def update
    @message = Task.find(params[:id])
      
      if @message.update(task_params)
        flash[:success] = 'Task は正常に更新されました'
        redirect_to @message
      else
        flash.now[:danger] = 'Task は更新されませんでした'
        render :edit
      end
  end
  
  def destroy
    @message = Task.find(params[:id])
    @message.destroy
    
    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  private
    
    def task_params
      params.require(:task).permit(:content)
    end
    
end
