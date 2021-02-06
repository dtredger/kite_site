# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  class_methods do
    ## partial match for 'name' attribute
    #
    def name_search(name_str)
      return none if name_str.blank?
      where('slug like?', "%#{name_str}%")
    end

    ## return all records with matching Months
    #
    # relies on model's #find_months method
    def month_search(months_arr)
      camel_arr = months_arr.map(&:camelcase)
      find_months(camel_arr)
    end

    def region_search(region_arr)
      camel_arr = region_arr.map(&:camelcase)
      find_region(camel_arr)
    end

    # def amenity_search(amenities)
    # end

  end
end
