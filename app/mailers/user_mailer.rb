class UserMailer < ApplicationMailer
  default from: 'ericleroyterquem@gmail.com'
  helper :application

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Enercoop')
  end
end
