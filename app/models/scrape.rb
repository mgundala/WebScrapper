class Scrape
  attr_accessor :title, :hotness, :image_url, :rating, :director,
                :genre, :runtime, :synopsis, :failure

  def scrape_new_movie(url)
    begin
      doc = Nokogiri::HTML(open(url))
      puts url
      doc.css('script').remove
      self.title = doc.at("//*[@id='heroImageContainer']/a/h1").text
      self.hotness = doc.at("//*[@id='tomato_meter_link']/span[2]").text.to_i
      self.image_url = doc.at_css('#movie-image-section img')['src']
      self.rating = doc.at("//*[@id='mainColumn']/section[4]/div/div/ul/li[1]/div[2]").text
      self.director = doc.at("//*[@id='mainColumn']/section[4]/div/div/ul/li[3]/div[2]").css('a').first.text
      self.genre = doc.at("//*[@id='mainColumn']/section[4]/div/div/ul/li[2]/div[2]").text
      self.runtime = doc.at("//*[@id='mainColumn']/section[4]/div/div/ul/li[7]/div[2]/time").text
      self.synopsis = doc.at("//*[@id='movieSynopsis']").text.tidy_bytes

      return true
    rescue Exception => e
      self.failure = "What have you DONE TO ME.. wrong scrape"
    end
  end
end