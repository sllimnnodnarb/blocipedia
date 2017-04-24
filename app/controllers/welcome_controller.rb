class WelcomeController < ApplicationController

  #before_action :authenticate_user!
  #skip before_action :authenticate_user! <--this skips the before_action

  def index
  end

  def about
  end

  def support
  end
end
