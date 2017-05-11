class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  def total_price
    line_items.to_a.sum{|i| i.total_price}
  end
  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
    end
    current_item
  end

  private
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart_id
  end
end
