namespace :classified do


  def make_key_val_hash(list_ary)
    h = {}
    list_ary.each do |f|
      field_name = f.search('.title').text.gsub(/\s*\:$/, '').gsub(/\s+/, '_').downcase
      field_value = f.search('.value').text
      h[field_name] = field_value
    end
    return h
  end  

  def get_links(link, agent, count=0)
    puts "-------<> Getting #{link}"
    page_links = agent.get(link)
    
    page_links.search('.list-items .item').each do |p|   
      #title = p.search('.item-shqort-description')
      begin
        ad_link = p.search('.post').first['href']
      rescue
        next
      end
      page_links.search('.post').map{|p| p['href']}.each do |ad_link|
        puts "Getting #{ad_link}"
        ad = agent.get(ad_link)
        items1 = make_key_val_hash( ad.search('.item-short-description .list-unstyled li'))
        items1['title'] = ad.search('.item-short-description h1').text
        items1['posted'] = Date.parse(items1['posted'])
        items2 = make_key_val_hash(ad.search('.item-fields li'))
        items1.merge!(items2)
        items1['location'] = items1['locations'] 
        items1['khmer24_ad_id'] = items1['ad_id']
        items1.delete('locations')
        items1.delete('ad_id')
        items1['description'] = ad.search('.post-description').text
        items1['size'] = items1['size(m2)'].to_i
        items1.delete('size(m2)')
        items1['price'] = items1['price'].remove(/[,\$]/, '')

        begin
          contact_link = ad.search('.user-info .btn-link').first['href'] + '/contact'
        rescue 
          contact_link = ad.search('.company .title').first['href'] + '/contact'
        #ensure
        #  contact_link = nil
        end
        
        contact_page = agent.get(contact_link)
        contact_fields = [:phone_number, :website, :location, :address]
        
        contact_data = {}
        contact_page.search('.content tr').each_with_index do |c,i|
          contact_data[contact_fields[i]] = c.search('td')[1].text.gsub(': ', '')
        end
        contact_data.delete(:location)
        lat, lng = contact_page.search('.show_map').first['href'].split('=').second.split(',') rescue nil
        if lat.present?
          contact_data[:lat] = lat
          contact_data[:lng] = lng.split('&').first
            #contact_page.search('.title').text  if contact_data[:name].blank?
            #contact_page.search('.profile-detail .name').text if contact_data[:name].blank?
        end  
        contact_data[:photo] = contact_page.search('.profile .photo a').first['href'] rescue nil
        contact_data[:photo] = ad.search('.logo .img-contain').first['src'] if contact_data[:photo].blank?
        contact_data[:name]  = contact_page.search('.name').text
        contact_data[:name]  = contact_page.search('.profile-detail .title').first.text if contact_data[:name].blank?
        binding.pry if contact_data[:name].blank?  
        email = ad.search('.email').first['data-value'] rescue nil

        #company = Company.find_or_create_by(contact_data)
        company = Company.find_or_create_by(contact_data)
        agent_data = {}
        agent_data[:email] = email if email.present?
        [:cellcard, :metfone, :smart].each do |com|
          v = contact_page.search(".#{com.to_s}").first['data-value'] rescue nil
          agent_data[com] = v if v.present? 
        end
        company.agents.find_or_create_by(agent_data) if agent_data.present? 
          
        company.update_attributes(contact_data) if company.new_record? 
        items1[:home_type] = link.split('/').last.remove('.html').gsub('-', ' ').split('?').first

        home = company.homes.create(items1)
        ad.search('.img-contain').each do |i|
          home.images.create(link: i['src'])
        end  
        #binding.pry
        puts company
        puts home

        # var url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl="
        # + sourceLang + "&tl=" + targetLang + "&dt=t&q=" + encodeURI(sourceText);
      end
    #if ad.search('.page-link'). rel='next'
    #next_link = page_links.search('.page-link')[5]['href'] rescue nil
      count += 50
      next_link = link.split('?')[0] + "?location=&per_page=#{count}"
      get_links(next_link, agent, count) if next_link.present?
    end
  end

  desc "TODO"
  task get_from_khmer24: :environment do
    #tr = Translator.new()
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    #'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36'

    page = agent.get('https://www.khmer24.com/en/property.html')
    controls = page.search('.controls a')
    controls.each do |l| 
      href = l['href']
      puts "Getting #{href}"
      get_links(href, agent, 0)   
    end
      
  end

end
