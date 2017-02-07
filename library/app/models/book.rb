class Book < ApplicationRecord
	validates :name, presence: true,
                    length: { minimum: 5, maximum: 250 }

  	validates :year, presence: true,
                    numericality: { greater_than: 0 }

    belongs_to :category
    belongs_to :user
end
