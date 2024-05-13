class CartWork < ApplicationRecord
    belongs_to :cart
    belongs_to :work
    validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
