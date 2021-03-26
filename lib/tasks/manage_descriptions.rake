# frozen_string_literal: true

namespace :manage_descriptions do
  task scrape_wiki: :environment do
    require 'rubygems'
    require 'nokogiri'
    require 'open-uri'
    require 'json'
    require 'csv'

    no_descr = %w[Iberaquera Tucus Puclaro Levkada Foddini Western_Oz Ponto_de_Oura
                  Noordwijk_ann_Zee Guincho Pirlanta Mui_Ne_Bay El_Yaque Cap_Chevalier]

    # collection = Country.all
    collection = KiteSpot.all
    fails = []

    collection.all.each do |model|
      model_name = model.name.tr(' ', '_').gsub('_(all)', '')
      page_url = "https://en.wikipedia.org/wiki/#{model_name}"

      begin
        noko_page = Nokogiri::HTML(open(page_url))
        paras = noko_page.css('.mw-parser-output').css('p')

        # take first 3 (para 0 is style only)
        group_paras = paras[1, 3].to_html
        first_300_words = group_paras.gsub(/\[\D{0,5}\d*\]/, '')
                                     .gsub(/<span [^>]*>/, '')
                                     .gsub(%r{</span>}, '')
                                     .gsub(/<a href=[^>]*>/, '')
                                     .gsub(%r{</a>}, '')
                                     .gsub(/<img [^>]*>/, '')
                                     .gsub(/\(listen\)/, '')
                                     .gsub(/\(help·info\)/, '')
                                     .truncate_words(300, omission: '...')
        first_300_words += "<p>[from <a href='#{page_url}'>Wikipedia</a>]</p>"

        model.update(content: first_300_words)
        puts "#{model.name} updated"
      rescue StandardError => e
        puts "FAIL: #{model_name}: #{e}"
        fails.append(model.name)
      end
    end

    # TO Remove wikipedia notes [1]...[note 3]
    # Country.all.each do |model|
    #   content = model.content.body.to_html.gsub(/<span [^>]*>/, '').gsub(/<\/span>/, '').gsub(/<a href=[^>]*>/, '').gsub(/<\/a>/, '').gsub(/<img [^>]*>/, '').gsub(/\(listen\)/, '').gsub(/\(help·info\)/, '')
    #   model.update(content: content)
    #
    #   content = model.content.body.to_html.gsub('[from Wikipedia]', "<p>[from <a href='#{page_url}'>Wikipedia</a>]</p>")
    #   model.update(content: content)
    # end
  end
end
