#encoding: utf-8  
class UserMailer < ActionMailer::Base
  default from: "support@sravnim-ka.ru"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = "http://sravnim-ka.ru/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email, :subject => "Ваш пароль на сайте sravnim-ka.ru успешно сброшен")
  end

  def activation_needed_email(user)
    @user = user
    @url  = "http://sravnim-ka.ru/users/#{user.activation_token}/activate"
    mail(:to => user.email,
         :subject => "Добро пожаловать на сайт сравнения цен sravnim-ka.ru")
  end
      
  def activation_success_email(user)
    @user = user
    @url  = "http://sravnim-ka.ru/login"
    mail(:to => user.email,
         :subject => "Ваш аккаунт успешно активирован на сайте sravnim-ka.ru")
  end
end
