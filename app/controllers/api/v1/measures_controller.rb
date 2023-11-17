
class Api::V1::MeasuresController < ApplicationController

    def index
      require 'nokogiri'
      require 'uri'
      require 'net/http'
      require 'csv'
  
      uri = URI("https://leginfo.legislature.ca.gov/faces//billSearchClient.xhtml?session_year=20232024&house=Both&author=All&lawCode=" + params['lawCode'].to_s)
  
      res = Net::HTTP.get_response(uri)
  
      document = Nokogiri::HTML4(res.body)
  
      table = document.at('table')
  
      all_data = []
  
      table.search('tr').each do |tr|
        cells = tr.search('th, td')
        all_data << CSV.generate_line(cells)
      end
  
      all_data.each do |i|
        i.gsub!("\n", "")
        i.gsub!('"', "")
        i.gsub!(/\s{10}/, "")
        i.gsub!(/\s{8}/, "" )
        i.gsub!(",", ", ")
        i.gsub!("-", "")
      end
  
      @all_data = all_data
  
      render json: @all_data
    end
  
  end