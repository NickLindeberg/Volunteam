class CreateVolunteerInstruments < ActiveRecord::Migration[7.0]
  def change
    create_table :volunteer_instruments do |t|
      t.references :volunteer
      t.references :instrument

      t.timestamps
    end
  end
end
