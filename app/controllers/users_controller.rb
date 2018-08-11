class UsersController < Clearance::UsersController
  before_action :set_user, only: [:edit, :update, :go_back]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.half_complete
    if @user.save
      sign_in @user
      redirect_to edit_user_path @user
    else
      @user.back_to_uncompleted
      render :new
    end
  end

  def go_back
    @user.back_to_uncompleted
    if @user.save
      redirect_to edit_user_path @user
    else
      @user.half_complete
      render :edit
    end
  end

  def update
    complete_and_update if @user.half_completed?
    half_complete_and_update if @user.uncompleted?
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :street_number, :street_name, :zip_code, :city, :email, :password, :pdl, :situation)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def complete_and_update
      @user.complete
      if @user.update(pdl: user_params[:pdl], situation: user_params[:situation])
        UserMailer.welcome_email.deliver_later
        redirect_back_or url_after_create
        return
      else
        @user.back_to_half_completed
        render :edit
      end
    end

    def half_complete_and_update
      @user.half_complete
      if @user.update(user_params)
        redirect_to edit_user_path @user
        return
      else
        @user.back_to_uncompleted
        render :edit
      end
    end
end
