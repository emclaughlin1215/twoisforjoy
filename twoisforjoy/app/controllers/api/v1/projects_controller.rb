class Api::V1::ProjectsController < ApplicationController
  def index
    @projects = if params[:tag]
      Project.tag_by_name(params[:tag])
    else
      Project.all
    end
  end

  def new
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: 'Created project.'
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to @project, notice: 'Updated project.'
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:project).permit(:name, :tag_list)
  end
end
