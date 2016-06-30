class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
