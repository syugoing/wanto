class NoticeMailer < ApplicationMailer

  def sendmail_topic(topic)
    @topic = topic

    mail to: "shugo.sawada.18@gmail.com",
          subject: '【FriendPark】投稿がありました'
  end
end
