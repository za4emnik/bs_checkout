class CheckoutMailer < ApplicationMailer
  def success_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Checkout success!')
  end
end
