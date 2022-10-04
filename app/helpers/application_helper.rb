module ApplicationHelper
  def fa_icon(icon_class)
    content_tag 'span', '', class: "bi bi-#{icon_class}"
  end

  def user_avatar(user)
    return user.avatar.variant(resize_to_fit: [400, 400]) if user.avatar.attached?
    asset_path('avatar.png')
  end

  def user_avatar_thumb(user)
    return user.avatar.variant(resize_to_fit: [400, 400]) if user.avatar.attached?
    asset_path('avatar.png')
  end

  def photo_thumb(object)
    if object.photo.attached?
      object.photo.variant(resize_to_fit: [50, 50])
    else
      asset_path('event_thumb.jpg')
    end
  end

  def bootstrap_flash(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissible fade show", role: 'alert') do
        concat content_tag(:button, '', class: 'btn-close', data: { 'bs-dismiss': 'alert' })
        concat message
      end)
    end
    nil
  end

  private

  def bootstrap_class_for(flash_type)
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-success'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end
end
