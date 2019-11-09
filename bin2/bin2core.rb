class Bin2
  def initialize(file_name,st_wz=0)
    @bs=File.open(file_name,"rb")
    if st_wz != 0
      @bs.seek(st_wz)
    end
  end
  def cend
    @bs.close
  end
  def rel_goto(py_off=0)
    @bs.seek(@bs.pos+py_off)
    return @bs.pos
  end
  def gotoo(wz=@bs.pos)
    @bs.seek(wz)
    return @bs.pos
  end
  def r_data(typee,r_size=0)
    if typee == "V" or typee == "F"
      r_size = 4
    elsif typee == "v"
      r_size = 2
    elsif typee == "C"
      r_size = 1
    elsif typee == "size"
      return @bs.size
    else
      return @bs.read(r_size)
    end
    return @bs.read(r_size).unpack(typee)[0]
  end
  def padding
  	rem=@bs.pos % 16
  	if rem != 0
  		@bs.seek(@bs.pos+16-rem)
  	end
  end
end
