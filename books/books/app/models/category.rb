class Category < ApplicationRecord
	validates :name, presence: true, length: {maximum: 250}

	has_many :books
end
