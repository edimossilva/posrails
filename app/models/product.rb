class Product < ApplicationRecord
    has_one :price
    has_many :pieces

    validates :name, presence: true
	validates :quantity, presence: true

    def nil_fields?
        self.name.nil? || self.quantity.nil?
    end

end
