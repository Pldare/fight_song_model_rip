require_relative "savecore.rb"
class Xps_mesh
  def initialize(file_name)
    #make file
    @xps_mesh=Savecore.new(file_name)
  end
  def mesh_data(vex,norm,uv,face)
    #head
    pp=0
    @xps_mesh.write_data("0\n1\nsm_#{0}\n1\n0\n#{vex.size}\n")

    for i in 0...vex.size
      #vertex
      @xps_mesh.write_data(vex[i][0].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(vex[i][1].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(vex[i][2].round(6))
      @xps_mesh.write_data("\n")
      #norm
      @xps_mesh.write_data(norm[i][0].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(norm[i][1].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(norm[i][2].round(6))
      @xps_mesh.write_data("\n")
      #color
      @xps_mesh.write_data("1 0 0 0\n")
      #uv
      @xps_mesh.write_data(uv[i][0].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(uv[i][1].round(6))
      @xps_mesh.write_data("\n")
      #index
      @xps_mesh.write_data(0)#index[i][0])
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(0)#index[i][1])
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(0)#index[i][2])
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(0)#index[i][3])
      @xps_mesh.write_data("\n")
      #weight
      #weight=weig[i]
      #weight[3]=1-weight[0]-weight[1]-weight[2]
      #if weight[3] < 0.00001
      #  weight[3]=0.0
      #end
      @xps_mesh.write_data(0)#weig[i][0].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(0)#weig[i][1].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(0)#weig[i][2].round(6))
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(0)#weig[i][3].round(6))
      @xps_mesh.write_data("\n")
    end
    @xps_mesh.write_data("#{face.size}\n")
    for i in 0...face.size
      @xps_mesh.write_data(face[i][0])
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(face[i][1])
      @xps_mesh.write_data(" ")
      @xps_mesh.write_data(face[i][2])
      @xps_mesh.write_data("\n")
    end
  end
  def fend
    @xps_mesh.cend
  end
end
