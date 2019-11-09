class Savecore
  def initialize(save_url)
    make_floders(save_url)
    @p=File.open(save_url,"wb")
  end
  def write_data(data)
    @p.print data
  end
  def w_data(type,data)
    @p.print [data].pack(type)
  end
  def w_size
    return @p.size
  end
  def cend
    @p.close
  end
  def make_floders(_folder_url)
    n_size=_folder_url.split("/").size
    if n_size != 1
			n_data=_folder_url.split("/")
			url_list=[]
			for i in 0...(n_size-1)
				t_list=[]
				for a in 0..i
					t_list[a]=n_data[a]
				end
				url_list[i]=t_list.join("/")
				make_floder(url_list[i])
			end
			#print url_list,"\n"
		end
  end
  def make_floder(_folder)
  	if File.directory?(_folder)
  	else
  		Dir.mkdir(_folder)
  	end
  end
end
