class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.string :actor, null: false
      t.text :description
      t.integer :television_show_id
    end
  end
end
