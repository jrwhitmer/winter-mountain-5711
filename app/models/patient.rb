class Patient < ApplicationRecord
  has_many :patient_doctors
  has_many :doctors, through: :patient_doctors

  def self.all_by_age_desc
    order(age: :desc)
  end
end
