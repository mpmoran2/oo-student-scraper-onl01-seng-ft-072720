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
    links = profile_page.css(".social-icon-container").children.css("a").map ( |el| el.attribute('hrf').value)
    
    links.each do |link|
      if link.include?("linkedin")
        student[:linkedin] = link
        elsif link.include?("github")
        student[:github] = link
    
  end 
end

#student[:twiter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
#student[:github] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value