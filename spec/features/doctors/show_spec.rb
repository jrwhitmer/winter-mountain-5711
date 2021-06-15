require 'rails_helper'
RSpec.describe 'Doctor show page' do
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
  end
  it 'displays all doctor information: name, specialty, and education' do
    visit "/doctors/#{@doctor_1.id}"

    expect(page).to have_content(@doctor_1.name)
    expect(page).to have_content(@doctor_1.specialty)
    expect(page).to have_content(@doctor_1.university)

    visit "/doctors/#{@doctor_2.id}"


    expect(page).to have_content(@doctor_2.name)
    expect(page).to have_content(@doctor_2.specialty)
    expect(page).to have_content(@doctor_2.university)
  end

  it 'displays the name of the hospital the doctor works for' do
    visit "/doctors/#{@doctor_1.id}"

    expect(page).to have_content(@hospital.name)

    visit "/doctors/#{@doctor_2.id}"

    expect(page).to have_content(@hospital.name)
  end

  it 'displays the patients names under this doctors care' do
    visit "/doctors/#{@doctor_1.id}"

    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to have_content(@patient_3.name)

    visit "/doctors/#{@doctor_2.id}"

    expect(page).to have_content(@patient_1.name)
    expect(page).to have_content(@patient_2.name)
    expect(page).to have_content(@patient_4.name)
  end

  it 'has a button by each patient name to delete the patient' do
    visit "/doctors/#{@doctor_1.id}"

    within("#patient-#{@patient_1.id}") do
      expect(page).to have_button("Remove Patient")
    end
    within("#patient-#{@patient_2.id}") do
      expect(page).to have_button("Remove Patient")
    end
    within("#patient-#{@patient_3.id}") do
      expect(page).to have_button("Remove Patient")
    end
  end

  it 'refreshes the page without the patient removed when the button is pressed' do
    visit "/doctors/#{@doctor_1.id}"

    within("#patient-#{@patient_1.id}") do
      click_button("Remove Patient")
    end

    expect(current_path).to eq("/doctors/#{@doctor_1.id}")
    expect(page).to have_no_content(@patient_1.name)
  end
end
