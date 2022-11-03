class PagesController < ApplicationController

    def index
        @gossips = Gossip.all
    
    end

    def show
         @gossip = Gossip.find([:gossip_id])
    end


    def team
    
    end

    def contact
    
    end

    def bienvenue
       @first_name = params[:first_name]
    end



end