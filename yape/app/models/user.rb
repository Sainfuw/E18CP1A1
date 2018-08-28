class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products
  has_many :purchases

  def self.current=(user)
    Thread.current['user'] = user.try(:id)
  end

  def self.current
    @@current ||= User.find_by_id(Thread.current['user'])
  end
end
