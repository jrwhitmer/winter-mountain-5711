require 'rails_helper'
RSpec.describe 'Hospital show page' do
  before :each do
    @hospital = Hospital.create!(name: "Grady")

    @doctor_1 = Doctor.create!(name: "Dr. Miller", specialty: "Pediatrics", university: "John Hopkins", hospital_id: @hospital.id)
    @doctor_2 = Doctor.create!(name: "Dr. Amahdi", specialty: "Neurology", university: "Emory", hospital_id: @hospital.id)

    @patient_1 = Patient.create!(name: "Allie Meadows", age: 13)
    @patient_2 = Patient.create!(name: "Remy Larson", age: 22)
    @patient_3 = Patient.create!(name: "Kira Norris", age: 42)
    @patient_4 = Patient.create!(name: "Davis Smith", age: 36)

    @patient_doc_1 = PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_1.id)
    @patient_doc_2 = PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_1.id)
    @patient_doc_3 = PatientDoctor.create!(patient_id: @patient_3.id, doctor_id: @doctor_1.id)
    @patient_doc_4 = PatientDoctor.create!(patient_id: @patient_1.id, doctor_id: @doctor_2.id)
    @patient_doc_5 = PatientDoctor.create!(patient_id: @patient_2.id, doctor_id: @doctor_2.id)
    @patient_doc_6 = PatientDoctor.create!(patient_id: @patient_4.id, doctor_id: @doctor_2.id)
    visit "/hospitals/#{@hospital.id}"
  end
  it 'displays the hospitals name and the number of doctors working' do
    expect(page).to have_content(@hospital.name)
    expect(page).to have_content(@hospital.doctors.count)
  end

  it 'displays a unique list of universities their doctors have studied at' do
    @doctor_3 = Doctor.create!(name: "Dr. Geary", specialty: "General Medicine", university: "Emory", hospital_id: @hospital.id)

    expect(page).to have_content("Emory", count: 1)
    expect(page).to have_content("John Hopkins")
  end
end
