class Product < ApplicationRecord
  belongs_to :user
  before_destroy :save_sale

  def save_sale
    if User.current.id != self.user_id
      Purchase.create(name: self.name, price: self.price, user_id: User.current.id)
    end
  end

  def owner?(user = User.new)
    user.id == self.user_id
  end
end
