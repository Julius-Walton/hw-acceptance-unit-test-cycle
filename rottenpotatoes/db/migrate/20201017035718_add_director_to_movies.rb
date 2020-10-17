class AddDirectorToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :director, :string
    #add_column :movies, :, :string
  end
end
