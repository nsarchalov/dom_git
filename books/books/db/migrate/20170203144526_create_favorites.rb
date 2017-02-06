class CreateFavorites < ActiveRecord::Migration[5.0]
  def change 
  	drop_table :favorites
    create_table :favorites do |t|
      t.string :user_id
      t.string :book_id

      t.timestamps
    end
  end
end
