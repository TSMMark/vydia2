module ApplicationHelper
  
  # icons
  def icon icon
    "<i class=\"icon-#{icon}\"></i>".html_safe
  end

  def icon_show
    icon('zoom-in')
  end

  def icon_update
    icon('edit')
  end

  def icon_destroy
    icon('remove')
  end

  def icon_youtube
    icon('youtube')
  end

end
