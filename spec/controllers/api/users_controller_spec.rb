RSpec.describe Api::UsersController, type: :controller do
  describe 'create' do
    before(:each) { post :create, params: user_params }

    context 'valid params' do
      let(:user_params) do
        {
          user: {
            nickname: 'user',
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it { expect(response).to have_http_status(:success) }
    end

    context 'invalid params' do
      let(:user_params) do
        {
          user: {
            nickname: 'user',
            password: 'password',
            password_confirmation: 'invalid'
          }
        }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end
  end
end
