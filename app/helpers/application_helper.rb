# frozen_string_literal: true

# :nodoc:
module ApplicationHelper

  # show/hide filter search field
  def filterable_controller(controller_name)
    return true if controller_name.in? %w[ countries kite_spots ]
    false
  end

  def all_months
    %w[Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec]
  end

  def all_regions
    ['Europe', 'Caribbean', 'South America', 'Asia', 'Africa', 'North America', 'Pacific', 'ANZA', 'Middle East']
  end

  def all_amenities
    ['Parking', 'Change Rooms', 'Washrooms', 'Not Crowded', 'Easily Accessible', 'Camping', 'Waves', 'Flat Water']
  end

  def all_languages
    [:English, :French, :Spanish, :Italian, :German]
  end

end
