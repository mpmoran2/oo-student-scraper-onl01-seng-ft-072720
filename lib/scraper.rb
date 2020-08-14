require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    student_cards = doc.css(".student-card a")
    student_cards.collect do |element|
      {:name => element.css(".student-name").text ,
        :location => element.css(".student-location").text,
        :profile_url => element.attr('href')}
    end 
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}
    links = profile_page
      social = page.css(".social-icon-container a")
      social.each do |element| #iterate through each of the social elements and assign the keys if the item exists
        if element.attr('href').include?("twitter")
          stu_hash[:twitter] = element.attr('href')
        elsif element.attr('href').include?("linkedin")
          stu_hash[:linkedin] = element.attr('href')
        elsif element.attr('href').include?("github")
          stu_hash[:github] = element.attr('href')
        elsif element.attr('href').end_with?("com/")
          stu_hash[:blog] = element.attr('href')
        end
      end
      stu_hash[:profile_quote] = page.css(".profile-quote").text
      stu_hash[:bio] = page.css("div.description-holder p").text
      stu_hash
  end
end

#student[:twiter]
#