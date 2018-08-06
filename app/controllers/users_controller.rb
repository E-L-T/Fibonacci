class UsersController < Clearance::UsersController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.submit
    if @user.save
      sign_in @user
      redirect_to edit_user_path @user
    else
      render :new
    end
  end

  def update
    @user.complete
    if @user.update(pdl: user_params[:pdl])
      redirect_back_or url_after_create
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :pdl)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
