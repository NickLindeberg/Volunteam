class CreateVolunteer < ActiveRecord::Migration[7.0]
  def change
    create_table :volunteers do |t|
      t.string :name
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
