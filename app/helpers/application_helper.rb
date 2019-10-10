module ApplicationHelper
  # https://freesworder.net/rails-link-a/ 　参照
  require "uri"
  def text_url_to_link text
    URI.extract(text, ['http','https'] ).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      text.gsub!(url, sub_text)
    end
    return text
  end
  def exhibition(yahoo,amazon,mercari,rakuma,rakuten,yahooshoping)
    ex="yahoo " if yahoo
    ex=ex+"amazon " if amazon
    ex=ex+"mercari " if mercari
    ex=ex+"rakuma " if rakuma
    ex=ex+"rakuten " if rakuten
    ex=ex+"yahooshoping" if yahooshoping
    ex="なし" if ex.blank?
    ex
  end
end
