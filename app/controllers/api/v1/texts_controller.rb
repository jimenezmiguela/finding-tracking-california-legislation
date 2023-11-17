
class Api::V1::TextsController < ApplicationController

    def index
      require 'nokogiri'
      require 'uri'
      require 'net/http'

      uri = URI("https://leginfo.legislature.ca.gov/faces/billTextClient.xhtml?bill_id=" + params['bill_id'].to_s)
     
      response = Net::HTTP.get_response(uri)
  
      document = Nokogiri::HTML4(response.body)
      text = []
      digest = ""
      vote = ""
      appropriation = ""
      fiscalcommittee = ""
      localprogram = ""
      summary = "Summary: "

      digest_text = document.search('span#digesttext//text()')
      vote = document.search('span#vote//text()')
      appropriation = document.search('span#appropriation//text()')
      fiscalcommittee = document.search('span#fiscalcommittee//text()')
      localprogram = document.search('span#localprogram//text()')

      digest.to_s.insert(0, summary)
      digest << digest_text.to_s

      text << digest.to_s
      text << vote.to_s
      text << appropriation.to_s
      text << fiscalcommittee.to_s
      text << localprogram.to_s
      
      text.each do |i|
        i.gsub!("\n", "")
        i.gsub!("\t", "")
      end

      render json: text
    end
  
  end