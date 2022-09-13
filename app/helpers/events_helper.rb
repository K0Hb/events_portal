module EventsHelper
  def event_photo(event)
    if event.photos.first
      event.photos.first.photo.url
    else
      asset_url('event_thumb.jpg')
    end
  end

  def event_background_img_url(event, new_photo)
    if event.photos.except(new_photo).first
      event.photos.except(new_photo).first.photo.url
    else
      asset_url('event_thumb.jpg')
    end
  end

  def event_photo_thumb(photo)
    if photo.photo
      image_tag photo.photo.variant(resize_to_fit: [100, 100]), class: "img-fluid mt-2"
    else
      image_tag asset_url('event_thumb.jpg'), class: "img-fluid mt-2"
    end
  end
end
