class CreateEntities < ActiveRecord::Migration[6.0]
  def change
    create_table :entities do |t|
      t.string :url
      t.json :tags

      t.timestamps
    end
  end
end
