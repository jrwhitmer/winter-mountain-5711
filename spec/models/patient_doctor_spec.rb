require 'rails_helper'
RSpec.describe PatientDoctor, type: :model do
  describe 'relationships' do
    it { should belong_to(:doctor) }
    it { should belong_to(:patient) }
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
    describe '.find_id_by_ids' do
      it 'can return the id of a patient_doctor with matching doctor and patient ids' do
        expect(PatientDoctor.find_id_by_ids(@doctor_1.id, @patient_1.id)).to eq([@patient_doc_1.id])
      end
    end
  end
end
