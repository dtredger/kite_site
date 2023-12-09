# frozen_string_literal: true

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'

STORAGE_PATH = '/public/model_images'

namespace :manage_images do
  desc 'manage images, load, remove, or rename'

  task load_from_unsplash: :environment do
    Unsplash.configure do |config|
      config.application_access_key = Rails.application.credentials.dig(:unsplash, :key)
      config.application_secret = Rails.application.credentials.dig(:unsplash, :secret)
    end

    # SET which collection with photos to attach images to
    # collection = KiteSpot.all
    collection = Country.all.sample(10) + KiteSpot.all.sample(10)
    successes = []
    skips = []
    fails = []

    def skip_model(model, min_width = 500, photos_count = 3)
      # Check downloaded photos
      img_count = 1 # prioritize models with no photos at all
      file_name = "#{model.slug}-#{img_count}.jpg"
      file_path = File.join(Rails.root, STORAGE_PATH, file_name)
      return true if File.file?(file_path)

      # Check Attached Photos
      big_photos_count = model.photos.count do |p|
        return true if p.blob.metadata[:width].nil?

        p.blob.metadata[:width] > min_width
      end
      if big_photos_count >= photos_count
        puts "already #{photos_count} images for #{model.name}"
        true
      end
    end

    begin
      collection.each do |model|
        if skip_model(model)
          skips.push(model.name)
          next
        end

        image_divs = Unsplash::Photo.search(model.name)

        if image_divs.count.zero?
          puts "#{image_divs.count} image divs for #{model.name}"
          fails.push(model.name)
        end

        img_count = 1
        max_img_count = 3
        image_divs.each do |img_div|
          image_url = img_div.urls['regular']

          file_name = "#{model.slug}-#{img_count}.jpg"
          file_path = File.join(Rails.root, STORAGE_PATH, file_name)

          File.open(file_path, 'wb') do |f|
            f.write(URI.open(image_url).read)
          end

          model.photos.attach(io: File.open(file_path),
                              filename: file_name,
                              content_type: 'application/jpg')
          puts "attached #{file_name} to #{model.name}, image #{img_count} of #{max_img_count}"
          img_count += 1
          successes.push(model.name)
          puts "success count #{successes.uniq.count}"
          break if img_count > max_img_count
        end
      end
    ensure
      puts "successes: #{successes.count} - #{successes}"
      puts "skips: #{skips.count} - #{skips}"
      puts "fails: #{fails.count} - #{fails}"
      puts "#{successes.uniq.count + skips.count + fails.count} out of #{collection.count} records processed"
    end
  end

  task load_from_bing: :environment do
    # user_agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'
    # query = model.name.gsub(' ', '%20')

    # unsplash = "https://unsplash.com/s/photos/#{query}"
    # page_url = "https://www.bing.com/images/search?q=#{query}&qft=+filterui:imagesize-large&form=IRFLTR&first=1"

    # noko_page = Nokogiri::HTML(open(page_url, 'User-Agent' => user_agent))
    #
    # puts "Searched: #{noko_page.title}"

    # BING-SPECIFIC
    # image_divs = noko_page.css('.img_cont')
    # image_divs = noko_page.css('.iusc')

    # image_url = if img_div.children[0].attributes['src']
    #               img_div.children[0].attributes['src'].value
    #             else
    #               img_div.children[0].attributes['data-src'].value
    #             end
    #
    # next if image_url.match?('base64')

    # m_attr = img_div.attr('m')
    # image_url = JSON.parse(m_attr)['murl']
  end

  task delete_small_images: :environment do
    collection = KiteSpot.all
    # collection = Country.all
    count = 0
    collection.each do |model|
      next if model.photos.count < 6

      model.photos.each do |photo|
        next if photo.blob[:metadata]['width'].blank?

        next unless photo.blob[:metadata]['width'] < 600

        puts "deleting photo #{photo.blob[:filename]} from #{model.name}, with width: #{photo.blob[:metadata]['width']}"
        photo.destroy
        count += 1
      end
    end

    puts "deleted #{count} photos"
  end

  task rename_images: :environment do
    collection = KiteSpot.all

    collection.each do |model|
      model.photos.each_with_index do |photo, ix|
        new_name = "#{model.slug}-#{ix + 1}.jpg"
        photo.blob.update(filename: new_name)
        puts "rename photo to #{new_name}"
      end
    end
  end

  task attach_local_images: :environment do
    collection = Country.all + KiteSpot.all
    successes = []
    skips = []
    fails = []

    def attach_image(model, file_name, file_path)
      model.photos.attach(io: File.open(file_path),
                          filename: file_name,
                          content_type: 'application/jpg')
    end

    collection.each do |model|
      max_img_count = 3

      if model.photos.count >= max_img_count
        skips.push(model.name)
        puts "skipping #{model.name}"
        next
      end

      max_img_count.times do |count|
        file_name = "#{model.slug}-#{count}.jpg"
        file_path = File.join(Rails.root, '/public/model_images', file_name)
        next unless File.file?(file_path)

        attach_image(model, file_name, file_path)

        puts "attached #{file_name} to #{model.name}, image #{count} of #{max_img_count}"
        successes.push(model.name)
        puts "success count #{successes.uniq.count}"
      end
    end

    puts "#{successes.count} successes: #{successes}"
  end
end
