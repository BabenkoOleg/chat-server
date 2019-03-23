RSpec.describe Api::BaseController, type: :controller do
  controller do
    def index
      head :ok
    end
  end

  describe 'authenticate' do
    before(:each) { Timecop.freeze(Time.now) }

    after(:each) { Timecop.return }

    let(:user) { create(:user) }
    let(:credentials) { user.authorize! }

    context 'valid credentials' do
      it 'access token' do
        authorize user, credentials
        get :index
        expect(response).to have_http_status(:success)
      end

      it 'last token' do
        client = credentials['client']
        user.authorize!(client)

        authorize user, credentials
        get :index

        expect(response).to have_http_status(:success)
      end
    end

    context 'invalid credentials' do
      context 'access token' do
        it 'valid, but is not alive' do
          client = credentials['client']
          token = user.tokens[client]

          token['exp'] -= Rails.application.credentials[Rails.env.to_sym][:access_token_exp]
          token['exp'] = token['exp'].to_i

          user.update(tokens: { client => token })

          authorize user, credentials
          get :index

          expect(response).to have_http_status(:unauthorized)
        end

        it 'alive, but is not valid' do
          authorize user, credentials.merge(access: 'invalid')
          get :index

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'last token' do
        it 'valid, but is not alive' do
          client = credentials['client']
          user.authorize!(client)

          token = user.tokens[client]

          token['updated_at'] -= Rails.application.credentials[Rails.env.to_sym][:last_token_exp]
          token['updated_at'] = token['updated_at'].to_i

          user.update(tokens: { client => token })

          authorize user, credentials
          get :index

          expect(response).to have_http_status(:unauthorized)
        end

        it 'alive, but is not valid' do
          client = credentials['client']
          user.authorize!(client)

          authorize user, credentials.merge(access: 'invalid')
          get :index

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
