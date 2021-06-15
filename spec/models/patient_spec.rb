require 'rails_helper'
RSpec.describe Patient, type: :model do
  describe 'relationships' do
    it { should have_many(:patient_doctors) }
    it { should have_many(:doctors).through(:patient_doctors) }
  end

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

  describe 'class methods' do
    describe '.all_by_age_desc' do
      it 'can return a list of all patients ordered from oldest to youngest' do
        expect(Patient.all_by_age_desc.first).to eq(@patient_3)
        expect(Patient.all_by_age_desc.second).to eq(@patient_4)
        expect(Patient.all_by_age_desc.third).to eq(@patient_2)
        expect(Patient.all_by_age_desc.fourth).to eq(@patient_1)
      end
    end
  end
end
