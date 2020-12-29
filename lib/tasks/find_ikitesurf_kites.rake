# frozen_string_literal: true

# download seed images & attach to countries
# if Rails.env.development?
#   task find_used_kites: :environment do
    # require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    require 'csv'

    user_agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'
    date = Time.new.strftime('%Y-%m-%d')
    filename = "ikitesurf_kites-fly-#{date}.csv"
    brand = 'F-One' #'FlySurfer'
    page_root = "http://c.ikitesurf.com/classifieds?search=search&type=4&location=all&price=all&brand=#{brand}&year=all&sortby=date&expires=0&c_states=all&size=all&views=all&orderby=dsc&favourite=0&wanted=0&terms=all&deleted=0&reported=0&page="

    CSV.open(filename, 'wb') do |csv|
      csv << %w[kite_model, size, price, condition]

      page_counter = 1
      while true
        noko_page = Nokogiri::HTML(open(page_root + page_counter.to_s, 'User-Agent' => user_agent))
        rows = noko_page.css('div.classified.cfix')
        if rows.count == 0
          break
        end

        rows.each do |row|
          kite_model = row.css('span.class_brief')[0].content.strip
          size = row.css('span.size_align')[0].content
          price = row.css('span.cl-price-bigger')[0].content
          condition = row.css('span.product_condition')[0].content

          csv << [kite_model, size, price, condition]
        end

        page_counter += 1
      end
    end

    # rescue Exception => e
    #   puts e
    #   break
    # end

  # end
# end
