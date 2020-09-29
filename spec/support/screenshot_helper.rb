# frozen_string_literal: true

require 'fileutils'

ActionDispatch::SystemTesting::TestHelpers::ScreenshotHelper.class_eval do
  def take_screenshot(_image_path = nil)
    save_image(image_path = nil)
    puts display_image
  end

  private

  def absolute_image_path(image_path = nil)
    if image_path
      FileUtils.mkdir_p image_path
      Rails.root.join(image_path, "#{image_name}.png")
    else
      Rails.root.join("tmp/screenshots/#{image_name}.png")
    end
  end

  def save_image(_image_path = nil)
    page.save_screenshot(absolute_image_path(image_path = nil))
  end
end
