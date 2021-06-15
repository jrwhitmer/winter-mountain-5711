class PatientsController < ApplicationController

  def index
    @patients = Patient.all_by_age_desc 
  end

end
