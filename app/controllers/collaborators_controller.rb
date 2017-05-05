class CollaboratorsController < ApplicationController
  before_action :set_wiki

  def index
    @users = User.all
  end

  def create
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "You have added #{@collaborator.user.email} to participate on this wiki."
    else
      flash[:error] = "The collaborator could not be added. Try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "#{@collaborator} was removed and can no longer particiate on this wiki."
    else
      flash[:error] = "Error removing #{@collaborator}, try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end

end
