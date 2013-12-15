xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  site_url = "http://www.normandierb.fr/"
  xml.title "Normandie.rb"
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"
  xml.updated((blog(:articles).articles[0..5] + blog(:events).articles[0..5]).sort_by(&:date).first.date.to_time.iso8601)
  xml.author { xml.name "Normandie.rb" }
  (blog(:articles).articles[0..5] + blog(:events).articles[0..5]).sort_by(&:date).each do |article|
    xml.entry do
      if article.title
        xml.title article.title
      else
        xml.title article.data.name
      end
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      if article.data.author
        xml.author { xml.name article.data.author }
      else
        xml.author { xml.name "Normandie.rb" }
      end
      xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
