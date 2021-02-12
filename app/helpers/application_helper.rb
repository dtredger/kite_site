# frozen_string_literal: true

# :nodoc:
module ApplicationHelper

  # show/hide filter search field
  def filterable_controller(controller_name)
    return true if controller_name.in? %w[ countries kite_spots ]
    false
  end

  def background_img_name
    'kite-south-africa-md'
  end

  def all_months
    %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  end

  def all_regions
    ['Asia', 'Africa', 'Middle East', 'Europe', 'North America', 'South America', 'Caribbean', 'ANZA/Pacific']
  end

  def all_amenities
    ['Parking', 'Change Rooms', 'Washrooms', 'Not Crowded', 'Easily Accessible', 'Camping', 'Waves', 'Flat Water']
  end

  def all_languages
    [:English, :French, :Spanish, :Italian, :German]
  end

  def result_sort_options
    ['Best Match', 'Alphabetical', 'Alphabetical by Country']
  end

end
