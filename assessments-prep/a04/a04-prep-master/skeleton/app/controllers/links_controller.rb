class LinksController < ApplicationController
  before_action :redirect_to_sign_in, only: [:new, :create, :index, :show]
  before_action :set_link, only: [:edit, :update, :show]

  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    link = Link.new(link_params)
    link.user_id = current_user.id

    if link.save
      redirect_to link_url(link)
    else
      flash.now[:errors] = link.errors.full_messages
      @link = link
      render :new
    end
  end

  def update
    if @link.user == current_user
      flash[:errors] = @link.errors.full_messages unless @link.update(link_params)
    end
    
    redirect_to link_url(@link)
  end


  def link_params
    params.require(:link).permit(:title,:url)
  end

  def set_link
    @link = Link.find(params[:id])
  end
end
