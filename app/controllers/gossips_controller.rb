class GossipsController < ApplicationController
 # before_action :authenticate_user, only: [:index]
  #before_action :user_is_op, only: [:edit, :update, :destroy]

    def index
        @gossips = Gossip.all
    end

    def show
      @gossips = Gossip.find(params[:id])
      @comment = @gossips.comments
    end

    def new
      @gossips = Gossip.new
  end

  def create
    user = User.find_by(id: session[:user_id])
    @gossips = Gossip.new(title: params[:title], content: params[:content], user_id: user.id)   
    if @gossips.save 
        redirect_to gossips_path 
    else
        render inline: @gossips.errors.full_messages 
    end
end

    def edit
      @gossips = Gossip.find(params[:id])
    end

    def update
        @gossips = Gossip.find(params[:id])
        if @gossips.update(title: params[:title], content: params[:content])
         redirect_to "/"
        else
           render :edit
        end
    end


       def destroy
        @gossips = Gossip.find(params[:id])
        @gossips.destroy
        redirect_to gossips_path
    end

    private

    def authenticate_user
      unless session[:user_id]
        flash[:danger] = "Merci de te connecter"
        redirect_to new_session_path
      end
    end

    def user_is_op
        puts "****"
        puts session[:user_id]
        puts "****"
        unless session[:user_id] == Gossip.find(params[:id]).user.id
          flash[:danger] = "Interdiction de faire cela"
          redirect_to new_session_path
        end
      end


  end