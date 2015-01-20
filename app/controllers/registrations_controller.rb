# override Devise Registration to include invite tokens
class RegistrationsController < Devise::RegistrationsController

  def new
    build_resource({})
    # inspired by railscats--adds invite email to form based on token
    @token = params[:invite_token]
    if @token
      @invite = Invite.find_by_token(@token)
      resource.email = @invite.email if @invite
    end
    respond_with self.resource
  end

  def create
    super
    @token = params[:invite_token]
    if @token
      @invite = Invite.find_by_token(@token)
      @invite.update_attributes(:recipient => resource) if @invite
    end
    Mailer.new_user(resource).deliver
  end

end
