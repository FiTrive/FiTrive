class SpotsController < ApplicationController
    def index
    end

    def new
        @spot = Spot.new
    end

    def show
        @spot = Spot.find_by(id: params[:id])
    end

    def create
        if params[:spot].blank?
            flash[:alert] = "選択肢を選んでから診断してください"
            redirect_to action: "new" and return
        end
        
        spot = Spot.new(spot_params)
        if spot.save
            flash[:notice] = "診断が完了しました"
            redirect_to spot_path(spot.id)
        else
            redirect_to :action => "new"
        end
    end
  
  private
    def spot_params
        params.require(:spot).permit(:question1, :question2, :question3, :question4)
    end
end
