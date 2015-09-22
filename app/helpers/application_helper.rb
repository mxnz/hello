module ApplicationHelper
  def current_page_is_new_registration_one?
    case
    when current_page?(new_guest_registration_path)
    when current_page?(new_owner_registration_path)
    when current_page?(new_admin_registration_path)
    else
      false
    end
  end
end
