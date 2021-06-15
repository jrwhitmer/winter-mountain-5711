class CreatePatientDoctors < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_doctors do |t|
      t.references :doctors, foreign_key: true
      t.references :patients, foreign_key: true

      t.timestamps
    end
  end
end
