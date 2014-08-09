# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  def new
    @token = params[:invite_token] #<-- pulls the value from the url query string
    super 
  end

  def create
    super
    @token = params[:invite_token] #<-- pulls the value from the url query string
    if @token != nil
        @invite = Invite.find_by_token(@token)
        @invite.update_attributes(:recipient => resource)
    end
 end

end 