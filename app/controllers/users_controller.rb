class UsersController < ApplicationController
    before_action :authorize, only: [:show]
    def create
        user = User.create(username: params[:username], password: params[:password], password_confirmation: params[:password_confirmation])
        if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
        else
            render json: {error: "Invalid Entry"}, status: :unprocessable_entity
        end
    end
    def show
        user = User.find_by(id: session[:user_id])
            render json: user
    end
    private 

    def authorize
        return render json: {error: "Not authorized"}, status: :unauthorized unless session.include? :user_id
    end
end