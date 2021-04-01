class CreateWidgets < ActiveRecord::Migration[6.0]
  def change
    create_table :widgets do |t|
      t.string :widget_name
      t.string :widget_maker
      t.integer :widget_id

      t.timestamps
    end
  end
end
