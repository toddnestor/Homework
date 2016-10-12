class LinksController < ApplicationController
  before_action :redirect_to_login, only: [:create, :edit, :new, :update, :destroy, :index, :show]
  before_action :set_link, only: [:edit, :update, :destroy, :show]

  def index
    @links = Link.all
  end

  def create
    link = Link.new(required_params)
    link.user_id = current_user.id

    if link.save
      redirect_to link_url(link)
    else
      flash[:errors] = link.errors.full_messages
      @link = link
      render :new
    end
  end

  def new
    @link = Link.new
  end

  def update
    @link.update(required_params) if @link.user == current_user
    redirect_to link_url(@link)
  end

  private
  def set_link
    @link = Link.find(params[:id])
  end

  def required_params
    params.require(:link).permit(:title,:url)
  end
end
