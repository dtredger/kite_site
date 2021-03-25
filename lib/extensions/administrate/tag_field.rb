module Administrate
  module Field
    class Tag

      # options = {:class_name=>"ActsAsTaggableOn::Tag", :resource_class=>KiteSpot(id: integer, name: ..... )}
      # the administrate-field-tag gem seems to not accept two args for permitted_attribute (not up-to-date)
      # the below is the standard for administrate's own HasMany field
      def self.permitted_attribute(attr, _options = {})
        # This may seem arbitrary, and improvable by using reflection.
        # Worry not: here we do exactly what Rails does. Regardless of the name
        # of the foreign key, has_many associations use the suffix `_ids`
        # for this.
        #
        # Eg: if the associated table and primary key are `countries.code`,
        # you may expect `country_codes` as attribute here, but it will
        # be `country_ids` instead.
        #
        # See https://github.com/rails/rails/blob/b30a23f53b52e59d31358f7b80385ee5c2ba3afe/activerecord/lib/active_record/associations/builder/collection_association.rb#L48
        { "#{attr.to_s.singularize}_ids".to_sym => [] }
      end

    end
  end
end