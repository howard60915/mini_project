module TopicsHelper

	def tagname(tag)
      tag.split(" ")
    end
    
    def tag_links(tags)
	  tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ") 
	end
end
