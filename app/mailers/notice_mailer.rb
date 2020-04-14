class NoticeMailer < ApplicationMailer
  def notice_mailer(blog)
    @blog = blog
    mail to: @blog.user.email, subject: '新規ブログ'
  end
end
