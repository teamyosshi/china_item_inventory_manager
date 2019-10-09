module StocksHelper
  def exhibition(yahoo,amazon,mercari,rakuma,rakuten,yahooshoping)
    if yahoo==true
      ex="yahoo "
    end
    if amazon==true
      ex=ex+"amazon "
    end
    if mercari==true
      ex=ex+"mercari "
    end
    if rakuma==true
      ex=ex+"rakuma "
    end
    if rakuten==true
      ex=ex+"rakuten "
    end
    if yahooshoping==true
      ex=ex+"yahooshoping"
    end
    if ex.blank?
      ex="なし"
    end
    ex
  end
end
