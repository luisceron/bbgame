#---------------------------------------------------------------------------
# HELPER ApplicationHelper
#---------------------------------------------------------------------------
module ApplicationHelper
  def error_tag(model, attribute)
    if model.errors.has_key? attribute
      content_tag(
        :div,
        model.errors[attribute].first,
        class: 'error_message'
      )
    end
  end

  def display_picture(user, width, height, classe)  
    if user.picture.to_s == ''
      image_tag 'user/user_default.jpg', width: width, height: height, class: classe
    else
      image_tag user.picture_url, width: width, height: height, class: classe 
    end    
  end

  def display_picture_from_user(user_id, width, height, classe)
    user = User::User.find(user_id)
    display_picture(user, width, height, classe)
  end

  def display_flag(team, width, height, classe)  
    if team.flag.to_s == ''
      image_tag 'team/default-flag.png', width: width, height: height, class: classe
    else
      image_tag team.flag_url, width: width, height: height, class: classe 
    end    
  end

end
