require_relative "bin2/bin2core.rb"
require_relative "bin2/ascii_model.rb"
require "pp"
class Gmoba
  def initialize(model_file)
    @model_name=model_file
    @model_data=Bin2.new(@model_name)
    @model_info={}
  end
  def offset_info
    magic=fstr
    unk0=long
    zeroo=long
    loop do
      if @model_data.r_data("size")==@model_data.gotoo
        break
      end
      st_wz=@model_data.gotoo
      #type0=fstr
      #zero=long
      type1=fstr
      type1_size=long
      pp "#{type1}::size::#{type1_size.to_s(16)}::#{st_wz.to_s(16)}"
      #goto info
      @model_info[type1]=st_wz
      @model_data.rel_goto(type1_size+12)
    end
    def main
      type_use={
        "HSMV"=>hsmv,#vertex
        "LEKS"=>leks#bone
      }
      for i in @model_info.keys
        type_use[i]
      end
    end
    def leks
      @model_data.gotoo(@model_info["LEKS"]+8)
      @model_data.rel_goto(2)#next zero
      bone_count=short
      @bone_data=[]
      for i in 0...bone_count
        name_size=long
        name=@model_data.r_data("",name_size).to_s
        parant=short
        print name,"::",parant,"::",i,"\n"
        x,y,z=float,float,float#"::pos\n"
        print x,":",y,":",z,":pos\n"
        @bone_data[i]=[name,parant,x,y,z]
        #print [float,float],"\n"
        #print [float,float],"\n"
        #print [float,float,float,float,float],"\n"
        #print [float,float],"\n"
        @model_data.rel_goto(44)
      end
    end
    def hsmv
      @model_data.gotoo(@model_info["HSMV"]+80)
      unk0=long
      vertex_count=long
      pp vertex_count
      #next zero
      @model_data.rel_goto(9)
      unk1=long
      unk2=long
      face_count=long
      unk3=long
      pp "#{[unk0,unk1,unk3]}"
      byteeee
      #28
      @vex=[]
      @norm=[]
      @uv=[]
      @face=[]
      for i in 0...vertex_count
        print "====vert::#{i}====\n"
        #print [float,float],"\n"
        print [byteeee,byteeee,byteeee,byteeee],"\n"
        print [byteeee,byteeee,byteeee,byteeee],"\n"
        #print [float,float,float],"::pos\n"#pos
        @vex[i]=[float,float,float]
        #print [float,float,float],"::norm\n"
        @norm[i]=[float,float,float]
        #print [float,float],"::uv\n"
        @uv[i]=[float,float]
        print [float,float],"\n"
        #print [float,float,float],"\n"
        print [byteeee,byteeee,byteeee,byteeee],"\n"
        print [byteeee,byteeee,byteeee,byteeee],"\n"
        print [byteeee,byteeee,byteeee,byteeee],"\n"
      end
      @model_data.rel_goto(8)
      for i in 0...face_count
        @face[i]=[short,short,short]
      end
    end
  end
  def xpss#(pos,norm,uv)
    pp=Xps_mesh.new("test.ascii")
    pp.mesh_data(@vex,@norm,@uv,@face)
  end
  def fstr
    return @model_data.r_data("",4).to_s
  end
  def long
    return @model_data.r_data("V")
  end
  def short
    return @model_data.r_data("v")
  end
  def float
    return @model_data.r_data("F")
  end
  def byteeee
    return @model_data.r_data("C")
  end
end
lls=Gmoba.new("lilisi-body.model")
lls.offset_info
#p=0x2c9e8
#for i in 0...20
#  pp=p % 3046
#  if pp==0
#    print (p/3046).to_s(16),"\n"
  #else

#  end
#  p-=1
#end
lls.main
lls.xpss
#hsmv 3c
