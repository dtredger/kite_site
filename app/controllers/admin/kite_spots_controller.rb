module Admin
  class KiteSpotsController < Admin::ApplicationController
    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    # end

    def destroy_photo
      kite_spot = KiteSpot.find_by(slug: params['resource'])
      if kite_spot
        photo = kite_spot.photos.find_by(id: params['photo_id'])
        photo.purge if photo
      end
      redirect_back(fallback_location: admin_kite_spots_path)
    end

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end
    def scoped_resource
      resource_class.with_attached_photos
    end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    def resource_params
      params.require(resource_class.model_name.param_key)
          .permit(dashboard.permitted_attributes)
          .transform_keys { |key| key == 'month_tags' ? 'month_tag_list' : key }
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
