# frozen_string_literal: true

require 'administrate/field/base'

# custom Administrate field for rails enums (see also views/fields/enum_field)
class EnumField < Administrate::Field::Base
  def to_s
    return '' unless data

    data
  end

  def select_field_values(form_builder)
    form_builder.object.class.public_send(attribute.to_s.pluralize).keys.map do |v|
      [v.titleize, v]
    end
  end
end
