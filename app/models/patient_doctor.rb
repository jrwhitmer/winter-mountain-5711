class PatientDoctor < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  def self.find_id_by_ids(doc_id, pat_id)
    where(doctor_id: doc_id, patient_id: pat_id).pluck(:id)
  end
end
