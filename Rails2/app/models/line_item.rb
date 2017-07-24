class LineItem < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :product, optional: true
  belongs_to :cart
  def total_price
    product.price * quantity
  end

  def decrement_quantity(line_item_id)
    current_item = LineItem.find_by_id(line_item_id)

    if current_item.quantity > 1
      current_item.quantity -= 1
    else
      current_item.destroy
    end

    current_item
  end

  def add_quantity(line_item_id)
    current_item = LineItem.find_by_id(line_item_id)
    current_item.quantity += 1
    return current_item
  end
end
