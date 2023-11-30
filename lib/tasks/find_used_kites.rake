# frozen_string_literal: true

# download seed images & attach to countries
if Rails.env.development?
  task find_used_kites: :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    require 'csv'

    user_agent = 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36'

    date = Time.new.strftime('%Y-%m-%d')
    filename = "find_used_kites-#{date}.csv"

    sites = {
      kiteforum: 'https://kiteforum.com/viewforum.php?f=4'
    }

    sites.each do |_site_name, site_url|
      noko_page = Nokogiri::HTML(open(site_url, 'User-Agent' => user_agent))

      rows = noko_page.css('li.row')
      non_sticky_rows = rows[1..]
      puts "#{non_sticky_rows.count} non-sticky rows"

      CSV.open(filename, 'wb') do |csv|
        csv << %w[date name link_page description]

        non_sticky_rows.each do |row|
          list_inner = row.css('.list-inner')
          links = list_inner.css('a') # 4 per row
          name = links[0].content
          path = links[0].attributes['href'].value[2..]
          link_page = site_url.gsub('viewforum.php?f=4', path)

          puts "row: #{name}"

          row_page = Nokogiri::HTML(open(link_page, 'User-Agent' => user_agent))

          date = row_page.css('p.author')[0].text.match('» (.*)')
          description = row_page.css('.postbody .content')[0].text.strip

          csv << [date, name, link_page, description]
        end
      end
    rescue Exception => e
      puts e
    end
  end
end
