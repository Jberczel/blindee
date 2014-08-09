# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  def new  
    build_resource({})  
    @token = params[:invite_token] #<-- pulls the value from the url query string
    if @token
      @invite = Invite.find_by_token(@token)
      resource.email = @invite.email if @invite
    end
    respond_with self.resource

  end

  def create
    super
    @token = params[:invite_token] #<-- pulls the value from the url query string
    if @token
        @invite = Invite.find_by_token(@token)
        @invite.update_attributes(:recipient => resource)
    end
 end

end 