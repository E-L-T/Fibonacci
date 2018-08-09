class DashboardController < ApplicationController
  def show
    if user.present? && user.state != 'completed'
      redirect_to edit_user_path user.id
      flash[:info] = 'You can continue to fill the form where you stopped'
    end
  end

  def user
    User.where(remember_token: request.headers['cookie'].split('remember_token=')[1])[0]
  end
end
