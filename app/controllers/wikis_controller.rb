class WikisController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @user = current_user
    @wiki = Wiki.new
  end

  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Your wiki has been saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
     else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
     end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    defaults = { private: 'false' }
    params.require(:wiki).permit(:title, :body, :private, :user_ids)
  end

  def authorize_user
    unless  current_user || current_user.admin? || current_user.vip?
      flash[:alert] = "You must be a current user to do that."
      redirect_to wikis_path
    end
  end

end
