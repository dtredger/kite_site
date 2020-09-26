# frozen_string_literal: true

# download seed images & attach to countries
if Rails.env.development?
  task find_images: :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    require 'csv'

    # SET which collection with photos to attach images to
    collection = KiteSpot.all
    user_agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'
    successes = []
    fails = []

    collection.each do |model|
      query = model.name.gsub(' ', '%20')

      unsplash = "https://unsplash.com/s/photos/#{query}"
      page_url = "https://www.bing.com/images/search?q=#{query}&qft=+filterui:imagesize-large&form=IRFLTR&first=1"

      noko_page = Nokogiri::HTML(open(page_url, 'User-Agent' => user_agent))

      puts "Searched: #{noko_page.title}"

      image_divs = noko_page.css('.img_cont')

      if image_divs.count.zero?
        puts "#{image_divs.count} image divs for #{model.name}"
        fails.push(model.name)
      end

      img_count = 1
      max_img_count = 3
      image_divs.each do |img_div|
        image_url = if img_div.children[0].attributes['src']
                      img_div.children[0].attributes['src'].value
                    else
                      img_div.children[0].attributes['data-src'].value
                    end

        next if image_url.match?('base64')

        file_name = File.join(Rails.root, '/tmp/storage', "#{model.name}-#{img_count}.jpg")

        File.open(file_name, 'wb') do |f|
          f.write(open(image_url).read)
        end

        # puts "saved file #{file_name}"

        model.photos.attach(io: File.open(file_name),
                            filename: file_name,
                            content_type: 'application/jpg')
        puts "attached #{file_name} to #{model.name}, image #{img_count} of #{max_img_count}"
        img_count += 1
        break if img_count > max_img_count
      end
    end

    puts 'fails: '
    puts fails
  end
end
