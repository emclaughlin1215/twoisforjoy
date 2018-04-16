class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @projects = Project.all.order_by('created_at desc').paginate(page: params[:page, per_page: 10])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params

    if @project.save
      redirect_to @project, notice: "Project created."
    else
      render 'new', notice: "Something went wrong."
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update project_params
      redirect_to @project, notice: "Successful update."
    else
      render 'edit', notice: "something went wrong."
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

    def project_params
      params.require(:project).permit(:title, :description, :link)
    end

    def find_project
      @project = Project.find(params[:id])
    end
end
