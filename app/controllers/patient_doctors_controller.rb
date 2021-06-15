class PatientDoctorsController < ApplicationController
  def destroy
    @patient_doctor_id = PatientDoctor.find_id_by_ids(params[:doctor_id],params[:patient_id])

    PatientDoctor.destroy(@patient_doctor_id)

    redirect_to "/doctors/#{params[:doctor_id]}"
  end
end
