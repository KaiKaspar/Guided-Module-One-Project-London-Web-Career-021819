class MovieActorAddSalaryColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :movie_actors, :salary, :integer
  end
end
