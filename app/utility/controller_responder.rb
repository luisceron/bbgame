#---------------------------------------------------------------------------
# HELPER ControllerResponder
#---------------------------------------------------------------------------
module ControllerResponder

  def save_and_respond(object, success_path, notice, unsucess_path, alert)
    if object.save
      redirect_to success_path, notice: notice
    else
      redirect_to unsucess_path, alert: alert
    end
  end

  def redirects(success, success_path, notice, unsucess_path, alert)
    if success == 1
      redirect_to success_path, notice: notice
    else
      redirect_to unsucess_path, alert: alert
    end
  end

  def destroy_and_respond(object, path, notice)
    object.destroy
    redirect_to path, notice: notice
  end
end
