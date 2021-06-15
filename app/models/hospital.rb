class Hospital < ApplicationRecord
  has_many :doctors

  def unique_universities
    Doctor.where('hospital_id = ?', self.id).select(:university).distinct(:university)
  end
end
