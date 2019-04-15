class CreateRequestfeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :requestfeeds do |t|
      t.string :title

      t.timestamps
    end
  end
end
