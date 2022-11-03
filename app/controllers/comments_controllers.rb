class CommentsController < ApplicationController
    before_action :authenticate_user, only: [:create, :edit]
      def new
          @comment = Comment.new
        end
      
        def create
          @comment = Comment.new('gossip_id' => params[:gossip_id], 'content' => params[:content], user: User.find_by(id: session[:user_id]))
          if @comment.save
            flash[:success] = "Commentaire créé!"
            redirect_to '/'
          else
            flash[:notice] = "Comment non ajouté"
            render '/gossips'
          end
        end
      
        def update
          @comment = Comment.find(params[:id])
          @comment_params = params.permit(:content)
          if @comment.update(@comment_params)
            flash[:success] = "Commentaire publié"
            redirect_to '/'
          else
            render :edit
          end
        end
      
        def edit
          @comment = Comment.find(params[:id])
        end
      
        def destroy
          @comment = Comment.find(params[:id])
          @comment.destroy
          flash[:notice] = "Commentaire supprimé"
          redirect_to gossips_path
        end
      
        def index
          @comment = Comment.all
        end
      
        def show
          @comment = Comment.find(params[:id])
        end
  
        private
  
        def authenticate_user
          unless session[:user_id]
            flash[:danger] = "merci de te connecter"
            redirect_to new_session_path
          end
        end
  end