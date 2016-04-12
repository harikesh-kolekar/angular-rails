class Api::DeviceController < ApplicationController
  def resend_authentication_email
	unless params[:email]
      return render json: {
        success: false,
        errors: ['You must provide an email address.']
      }, status: 400
    end
    errors = nil
	@resource = User.find_by(email: params[:email])
    if @resource
      @resource.send_confirmation_instructions
    else
      errors = ["Unable to find user with email '#{params[:email]}'."]
    end

    if errors
      render json: {
        success: false,
        errors: errors
      }, status: 400
    else
      render json: {
        status: 'success',
        message: "A confirmation email was sent to your account at '#{params[:email]}'."
      }
    end
  end
end
