class BaseModel < ActiveRecord::Base
  
  self.abstract_class = true

  def self.include_helpers
    include Sprockets::Helpers::RailsHelper
    include Sprockets::Helpers::IsolatedHelper
    include ActionView::Helpers
    include ApplicationHelper
    include Rails.application.routes.url_helpers
  end
end