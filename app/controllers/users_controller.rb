class UsersController < Clearance::UsersController
  def create
    @user = user_from_params
    @user.submit
    if @user.save
      sign_in @user
      redirect_to edit_user_path @user
      # redirect_back_or url_after_create
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.complete
    if @user.update(pdl: permitted_params[:pdl])
      flash[:success] = 'User was successfully created.'
      redirect_back_or url_after_create
    else
      render :edit
    end
  end

  private

    def permitted_params
      params.require(:user).permit(:email, :password, :pdl)
    end
end
