# frozen_string_literal: true

# :nodoc:
module ApplicationHelper

  # show/hide filter search field
  def filterable_controller(controller_name)
    return true if controller_name.in? %w[ countries kite_spots ]
    false
  end

end
