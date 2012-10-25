class HomeController < ApplicationController
  #skip_before_filter :require_login, :only => :wellcom

  def wellcom
    render 'wellcom', layout: false
  end

end
