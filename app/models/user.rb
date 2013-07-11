class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
         #, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  # attr_accessible :title, :body

  has_many :videos, inverse_of: :user


  validate :is_trendsetter


  private
  def is_trendsetter
    errors.add(:email, "No access.") unless
      (self.email =~ /.+@trendsettermarketing\.net/)
  end

end
