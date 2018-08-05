class UsersController < Clearance::UsersController
  def create
    @user = user_from_params
    @user.submit
    if @user.save
      sign_in @user
      render :edit
      # redirect_back_or url_after_create
    else
      render :new
    end
  end
end
