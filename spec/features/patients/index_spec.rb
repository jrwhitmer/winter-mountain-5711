require 'rails_helper'
RSpec.describe 'Patient index page' do
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
    visit "/patients"
  end
  it 'displays all names of the patients, listed oldest to youngest' do
    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to have_content(@patient_3.name)
    expect(page).to have_content(@patient_4.name)
    
    expect(@patient_3.name).to appear_before(@patient_4.name)
    expect(@patient_4.name).to appear_before(@patient_2.name)
    expect(@patient_2.name).to appear_before(@patient_1.name)
  end
end
