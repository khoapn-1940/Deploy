module SessionsHelper
  def is_admin?
    return true if user_signed_in? && current_user.admin?
  end

  def is_user?
    return true if user_signed_in? && current_user.user?
  end
end
