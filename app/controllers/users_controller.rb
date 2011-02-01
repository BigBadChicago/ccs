class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end
end
