# frozen_string_literal: true

# :nodoc:
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def site_url
	  site_host = ENV['HTTP_HOST'] || 'localhost:3000'
	  Rails.application.routes.url_helpers.root_url(host: site_host)
  end

end


