module ApplicationHelper
  # https://freesworder.net/rails-link-a/ 　参照
  require "uri"
  require 'nokogiri'
  require 'open-uri'
  
  def text_url_to_link text
    URI.extract(text, ['http','https'] ).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    return text
  end
  def exhibition(yahoo,amazon,mercari,rakuma,rakuten,yahooshoping)
    ex=""
    ex="yahoo " if yahoo
    ex=ex+"amazon " if amazon
    ex=ex+"mercari " if mercari
    ex=ex+"rakuma " if rakuma
    ex=ex+"rakuten " if rakuten
    ex=ex+"yahooshoping" if yahooshoping
    ex="なし" if ex.blank?
    ex
  end
  def chanarate(k)
    url = 'https://info.finance.yahoo.co.jp/fx/detail/?code=CNHJPY=FX'
    doc = Nokogiri::HTML(open(url))
    bid = doc.xpath("//*[@id='CNHJPY_detail_bid']").text
    bid.to_i*k
  end
end
