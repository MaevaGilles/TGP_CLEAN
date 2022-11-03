class SessionsController < ApplicationController
    def new
        @users = User.new
      # Méthode qui crée un potin vide et l'envoie à une view qui affiche le formulaire pour 'le remplir' (new.html.erb)
    end

    def create
        # cherche s'il existe un utilisateur en base avec l’e-mail
        user = User.find_by(email: params[:email])
        user.inspect
  
        # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe 
        if user && user.authenticate(params[:password_digest])
          session[:user_id] = user.id
          redirect_to "/"
        else
          puts "Try again"
          flash.now[:danger] = 'email ou mot de passe invalid'
          redirect_to new_session_path
        end
      end

    def destroy
      puts "**************************"
      session.inspect
      session.delete(:user_id)
      redirect_to "/"
    end
end