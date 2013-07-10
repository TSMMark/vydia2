module NetworksHelper
  def link_to_network obj
    link_to obj.name, network_url(obj)
  end
end
