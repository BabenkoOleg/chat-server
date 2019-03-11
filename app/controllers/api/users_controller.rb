module Api
  class UsersController < BaseController
    include Authenticatable

    skip_before_action :authenticate, only: [:create]

    # POST /api/users
    def create
      user = User.new(user_params)

      if user.save
        render_user_credentials(user)
      else
        render json: { errors: user.errors }
      end
    end

    private

    def user_params
      params.require(:user).permit(:nickname, :password, :password_confirmation)
    end
  end
end
