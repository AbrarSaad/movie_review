class AddImageToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :image, :string
  end
end
