class User < ActiveRecord::Base
  has_secure_password
  has_many :secrets
  has_many :likes,dependent: :destroy
  has_many :like_secrets,through: :likes,source: :secret
  before_save :lower_email
  validates :name, presence:true
  validates :email, presence:true, format:{with:/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i},uniqueness:true
  validates :password,presence:true, length:{maximum:72}, confirmation:true, on: :create


  private

  def lower_email
  	self.email.downcase!
  end
end
