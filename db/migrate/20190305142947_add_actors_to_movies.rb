class AddActorsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :all_actors_names, :string
  end
end
