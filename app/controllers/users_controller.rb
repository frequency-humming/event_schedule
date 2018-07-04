class UsersController < ApplicationController

    def index
        
    end
    def create
        if params[:user][:password] != params[:user][:password_confirm]
            flash[:notice] = ["Passwords must match"]
            redirect_to "/"
        else
            @user = User.create( user_params )
            session[:user_id] = @user.id
            redirect_to "/events"
        end
    end
    def login
        user = User.find_by(email:params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to "/events"
        end
    end
    def logout
        session[:user_id] = nil
        redirect_to "/"
    end
    def show

    end
    def edit
        user = current_user
        user.update(first_name:params[:first_name],last_name:params[:last_name],email:params[:email],location:params[:location],
            state:params[:state])
        user.save
        redirect_to "/events"
    end

    private 
    def user_params
        params.require(:user).permit(:first_name,:last_name,:email,:location,:state,:password)
    end
end
