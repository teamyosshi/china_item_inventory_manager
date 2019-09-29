module StocksHelper
    def shoppinglist(h1,h2,h3,h4,h5,h6)
        list=""
        if h1==true
            list=list+"yahoo"
        end
        if h2==true
            list=list+",""amazon"
        end
        if h3==true
            list=+list+","+"mercari"
        end
        if h4==true
            list=list+","+"rakuma"
        end
        if h5==true
            list=list+","+"rakuten"
        end
        if h6==true
            list=list+","+"yahooshoping"
        end
        list
    end
end
