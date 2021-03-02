# frozen_string_literal: true

# download seed images & attach to countries
if Rails.env.development?
  task find_images: :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    require 'csv'


    Unsplash.configure do |config|
      config.application_access_key = Rails.application.credentials.dig(:unsplash, :key)
      config.application_secret = Rails.application.credentials.dig(:unsplash, :secret)
    end

    already_img = [
        'Melbourne',
        'Western Oz',
        'Whitsunday Islands',
        'Barbados (all)',
        'Belize (all)',
        'Cumbuco',
        'British Virgin Islands (all)',
        'Banff',
        'Canada (all)',
        'Cape Verde (all)',
        'Grand Cayman',
        'Puclaro',
        'Chile (all)',
        'Bol',
        'Varadero',
        'Cabarete',
        'El Gouna',
        'Ras Sudr',
        'Safaga',
        'Fiji (all)',
        'Leucate',
        'Tahiti',
        'Germany (all)',
        'Levkada',
        'Naxos',
        'Paros',
        'Rhodes',
        'Hong Kong (all)',
        'Goa',
        'Sumbawa',
        'Iraq (all)',
        'Eilat',
        'Israel (all)',
        'Porto Pollo',
        'Buenos Aires',
        'Madagascar (all)',
        'Mauritius (all)',
        'Lebanon (all)',
        'Baja',
        # batch 2
        'Cozumel',
        'La Ventana',
        'Progreso',
        'Dakhla',
        'Essaouira',
        'Ponto de Oura',
        'Namibia',
        'Noordwijk ann Zee',
        'Bonaire',
        'New Caledonia (all)',
        'Auckland',
        'Masirah Island',
        'Mancora',
        'Boracay',
        'Esposende',
        'Guincho',
        'Yemen',
        'St. Louis',
        'Seychelles (all)',
        'Solomon Islands (all)',
        'Capetown',
        'South Africa (all)',
        'Fuerteventura',
        'Ibiza',
        'Lanzarote',
        'Tarifa',
        'Tenerife',
        'Kalpitiya',
        'Negombo',
        'Sri Lanka (all)',
        'St. Lucia (all)',
        'Taipei',
        'Zanzibar',
        'Hua Hin',
        'Monastir',
        'Watergate',
        'UK (all)',
        'Carmelo',
        'Cape Hatteras',
        'Florida',
        'Corsica',
        'Red Sea',
        'Mombasa',
        'Puerto Vallarta',
        'Maui',
        'South Padre Island',
        'The Gorge',
        'El Yaque'
    ]
    unfound = [
        'Iberaquera',
        'Tucus',
        'Raratonga',
        'Copal',
        'Paramali',
        'Esbjerg',
        'Rangiroa',
        'Rosslare',
        'Foddini',
        'Nashiro',
        'Pirlanta',
        'Adicora'
    ]

    already_searched = already_img + unfound

    # SET which collection with photos to attach images to
    collection = KiteSpot.all

    user_agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'
    successes = []
    fails = []

    begin
      collection.each do |model|
        if model.name.in? already_searched
          puts "already loaded #{model.name}"
          next
        end
        # query = model.name.gsub(' ', '%20')

        # unsplash = "https://unsplash.com/s/photos/#{query}"
        # page_url = "https://www.bing.com/images/search?q=#{query}&qft=+filterui:imagesize-large&form=IRFLTR&first=1"

        # noko_page = Nokogiri::HTML(open(page_url, 'User-Agent' => user_agent))
        #
        # puts "Searched: #{noko_page.title}"


        # BING-SPECIFIC
        # image_divs = noko_page.css('.img_cont')
        # image_divs = noko_page.css('.iusc')

        # unsplash
        image_divs = Unsplash::Photo.search(model.name)

        if image_divs.count.zero?
          puts "#{image_divs.count} image divs for #{model.name}"
          fails.push(model.name)
        end

        img_count = 1
        max_img_count = 3
        image_divs.each do |img_div|
          # image_url = if img_div.children[0].attributes['src']
          #               img_div.children[0].attributes['src'].value
          #             else
          #               img_div.children[0].attributes['data-src'].value
          #             end
          #
          # next if image_url.match?('base64')

          # m_attr = img_div.attr('m')
          # image_url = JSON.parse(m_attr)['murl']
          image_url = img_div.urls['regular']

          file_name = "#{model.name}-#{img_count}-b.jpg"
          file_path = File.join(Rails.root, '/tmp/storage', file_name)

          File.open(file_name, 'wb') do |f|
            f.write(open(image_url).read)
          end

          # puts "saved file #{file_name}"

          model.photos.attach(io: File.open(file_path),
                              filename: file_name,
                              content_type: 'application/jpg')
          puts "attached #{file_name} to #{model.name}, image #{img_count} of #{max_img_count}"
          img_count += 1
          successes.push(model.name)
          break if img_count > max_img_count
        end
      end
    rescue e
      print e
    ensure
      puts "successes: #{successes}"
      puts "fails: #{fails}"
    end
  end

  task delete_small_images: :environment do
    collection = KiteSpot.all

    count = 0
    collection.each do |model|
      next if model.photos.count < 6
      model.photos.each do |photo|
        if photo.blob[:metadata]['width'] < 600
          puts "deleting photo #{photo.blob[:filename]} from #{model.name}, with width: #{photo.blob[:metadata]['width']}"
          photo.destroy
          count += 1
        end
      end
    end

    puts "deleted #{count} photos"
  end

  task rename_images: :environment do
    collection = KiteSpot.all

    collection.each do |model|
      model.photos.each_with_index do |photo, ix|
        new_name = "#{model.slug}-#{ix+1}.jpg"
        photo.blob.update(filename: new_name)
        puts "rename photo to #{new_name}"
      end
    end
  end


end
