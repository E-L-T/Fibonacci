class UsersController < Clearance::UsersController
  before_action :set_user, only: [:edit, :update, :go_back]

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

  def go_back
    @user.undefine
    @user.save
    redirect_to edit_user_path @user
  end

  def update
    if @user.state == 'submitted'
      @user.complete
      if @user.update(pdl: user_params[:pdl])
        redirect_back_or url_after_create
        return
      else
        render :edit
      end
    end

    if @user.state == 'undefined'
      @user.submit
      if @user.update(user_params)
        redirect_to edit_user_path @user
        return
      else
        render :edit
      end
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
