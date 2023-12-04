# frozen_string_literal: true

# :nodoc:
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def site_url
    site_host = ENV['HTTP_HOST'] || 'localhost:3000'
    Rails.application.routes.url_helpers.root_url(host: site_host)
  end

  def self.to_csv(filename=nil)
    require 'csv'
    attributes = self.attribute_names

    # TODO include associations
    # self.reflect_on_all_associations.map(&:name)
    csv = CSV.generate(headers: true) do |csv|
      csv << attributes
      all.find_each do |model|
        csv << attributes.map{ |attr| model.send(attr) }
      end
    end
    if filename
      File.open(filename, 'w') do |file|
        file.write(csv)
      end
      return filename
    end
  end


  def all_months
    %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  end

  def self.all_months
    %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  end
end
