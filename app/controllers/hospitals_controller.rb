class HospitalsController < ApplicationController
  def show
    @hospital = Hospital.find(params[:id])
    @number_docs = @hospital.doctors.count
    @unique_universities = @hospital.unique_universities
  end
end
