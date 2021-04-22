# Load the Rails application.
require_relative 'application'

# DEPRECATION WARNING: Initialization autoloaded the constants ActionText::ContentHelper, ActionText::TagHelper, Administrate::ApplicationHelper, and Administrate::ApplicationController.
#
#   Being able to do this is deprecated. Autoloading during initialization is going
# to be an error condition in future versions of Rails.
#
#     Reloading does not reboot the application, and therefore code executed during
# initialization does not run again. So, if you reload ActionText::ContentHelper, for example,
#   the expected changes won't be reflected in that stale Module object.
#
# These autoloaded constants have been unloaded.
#
# In order to autoload safely at boot time, please wrap your code in a reloader
# callback this way:
#
#     Rails.application.reloader.to_prepare do
#       # Autoload classes and modules needed at boot time here.
#     end
#
# That block runs when the application boots, and every time there is a reload.
# For historical reasons, it may run twice, so it has to be idempotent.
#
# Check the "Autoloading and Reloading Constants" guide to learn more about how
# Rails autoloads and reloads.
# Rails.application.reloader.to_prepare do
#   [ActionText::ContentHelper,
#    ActionText::TagHelper,
#    Administrate::ApplicationHelper,
#    Administrate::ApplicationController]
# end



# Initialize the Rails application.
Rails.application.initialize!
