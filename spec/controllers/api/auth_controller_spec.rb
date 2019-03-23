RSpec.describe Api::AuthController, type: :controller do
  let(:user) { create(:user) }

  describe 'show' do
    before(:each) do
      authorize user
      get :show
    end

    it { expect(response).to have_http_status(:success) }
    it { expect(json['data']['id'].to_i).to eq(user.id) }
  end

  describe 'create' do
    before(:each) { post :create, params: auth_params }

    context 'valid credentials' do
      let(:auth_params) { { auth: { nickname: user.nickname, password: 'password' } } }

      it { expect(response).to have_http_status(:success) }
      it { expect(json['data']['id'].to_i).to eq(user.id) }
    end

    context 'invalid credentials' do
      context 'nickname' do
        let(:auth_params) { { auth: { nickname: 'invalid', password: 'password' } } }

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(json['error']).to eq('Invalid nickname or password') }
      end

      context 'password' do
        let(:auth_params) { { auth: { nickname: user.nickname, password: 'invalid' } } }

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(json['error']).to eq('Invalid nickname or password') }
      end
    end
  end
end
