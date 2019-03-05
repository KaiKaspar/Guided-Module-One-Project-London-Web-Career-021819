class ChangeRewiewToPlot < ActiveRecord::Migration[5.0]
  # def change
  #   change_column :movies, :review, :plot
  # end
  def up
    add_column :movies, :plot, :string
    # User.update_all(location: 'Minsk')
  end

  def down
    remove_column :movies, :review
  end
end
