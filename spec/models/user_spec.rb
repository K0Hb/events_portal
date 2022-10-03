require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_or_create_for_oauth' do
    let(:access_token) do
      double(
        :access_token,
        provider: 'github',
        info: double(
          email: 'test@test.com',
          name: 'test_name',
          image: nil,
          urls: { 'GitHub' => 'https://github.com/test_name' }
        )
      )
    end

    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_or_create_for_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'test@test.com'
        expect(user.name).to eq 'test_name'
        expect(user.url).to eq 'https://github.com/test_name'
      end
    end

    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: 'test@test.com') }
      let!(:some_other_user) { create(:user) }

      it 'returns this user' do
        expect(User.find_or_create_for_oauth(access_token)).to eq existing_user
      end
    end

    context 'when user is found by provider + url' do
      let!(:existing_user) do
        create(:user, provider: 'github',
                      url: 'https://github.com/test_name')
      end
      let!(:some_other_uer) { create(:user) }

      it 'returns this user' do
        expect(User.find_or_create_for_oauth(access_token)).to eq existing_user
      end
    end
  end
end
