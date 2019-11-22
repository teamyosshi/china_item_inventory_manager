module ResearchesHelper

  def research_update_invaflid?
    research_update = true
    research_update_params.each do |id, item|
      if item[:jpn_reseach_check] == "1" || item[:chn_reseach_check] == "1" || item[:jpn_reseach_check] == "0" || item[:chn_reseach_check] == "0"
        next
      else
        research_update = false
        break
      end
    end
    return research_update
  end
end
