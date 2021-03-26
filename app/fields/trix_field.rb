# frozen_string_literal: true

require 'administrate/field/base'

# Trix field for Administrate (see also views/fields/trix_field)
class TrixField < Administrate::Field::Base
  def to_s
    data
  end

  # def select_field_values(form_builder)
  #   form_builder.object.class.public_send(attribute.to_s.pluralize).keys.map do |v|
  #     [v.titleize, v]
  #   end
  # end
end
