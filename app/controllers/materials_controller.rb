class MaterialsController < ApplicationController
    def index
        @materials = Material.all
    end
      
    def new
        @material = Material.new
    end
  
    def create
        @material = Material.new(material_params)
        if @material.save
        flash[:success] = "Material Created."
        render 'new'
        else
            flash[:success] = "Material Created."
            render 'new'
        end
    end

  private

    def material_params
    params.require(:material).permit(:title, :author)
    end
  
end
