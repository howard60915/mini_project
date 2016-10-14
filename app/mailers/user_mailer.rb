class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.notify_comment.subject
  #
  def notify_new_topic(user, topics)
    @topics = topics
    @user = user
    mail(:to => "howard60915@gmail.com", :subject => "New Topic Created")
  end
end
