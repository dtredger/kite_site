# frozen_string_literal: true

# :nodoc:
module ApplicationHelper
  # show/hide filter search field
  def filterable_controller(controller_name)
    return true if controller_name.in? %w[countries kite_spots]

    false
  end

  def background_img_name
    'kite-south-africa-md.jpg'
  end

  # TODO: - name of resource in page title
  def page_title
    if controller_name && controller_name != 'pages'
      return "#{params[:id].titleize} - #{I18n.t('site_name')}" if params[:id].is_a? String

      "#{controller_name.titleize} - #{I18n.t('site_name')}"
    else
      I18n.t('site_name')
    end
  end

  def variant_550(photo)
    photo.variant(resize_to_fill: [550, 450]) if photo
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
    %i[English French Spanish Italian German]
  end

  def result_sort_options
    ['Best Match', 'Alphabetical', 'Alphabetical by Country']
  end
end
