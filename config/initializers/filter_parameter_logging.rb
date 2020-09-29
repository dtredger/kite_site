# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [ :password,
                                                :encoded_key,
                                                :signed_blob_id,
                                                :variation_key ]


# # Filter ActiveStorage blob keys so that the logs aren't full of as much stuff.
# :encoded_key,
#     :signed_blob_id,
#     :variation_key
# TODO: to remove urls entirely - https://github.com/igorkasyanchuk/active_storage_silent_logs/