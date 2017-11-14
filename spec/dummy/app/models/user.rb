class User < ApplicationRecord
  has_one :shipping_address, as: :addressable, dependent: :destroy, class_name: BsCheckout::Address
  has_one :billing_address, as: :addressable, dependent: :destroy, class_name: BsCheckout::Address
  has_many :reviews
  has_many :orders, class_name: BsCheckout::Order
  has_many :order_items, through: :orders, class_name: BsCheckout::OrderItem

  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :registerable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, format: { with: /(?=^.{8,}$)(?=.*[\d])(?=.*[a-z])(?=.*[A-Z])/ }

  def self.new_with_session(params, session)
    super.tap do |user|
      data = session['devise.facebook_data']['extra']['raw_info'] if session['devise.facebook_data']
      user.email = data['email'] if user.email.blank? && data
    end
  end

  def update_email(value)
    self.email = value
    valid?
    if errors[:email].blank?
      update_column(:email, value)
      true
    else
      errors.delete(:password)
      false
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
