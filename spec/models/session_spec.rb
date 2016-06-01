require "rails_helper"

RSpec.describe Session, type: :model do
  subject { build :session }

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of :token }
    it { is_expected.to validate_presence_of :token }
    it { is_expected.to validate_presence_of :user }
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'authorize user with credentials' do
    subject(:session) do
      Session.authorize_user_with_credentials(
        auth_email, auth_password
      )
    end

    let!(:user) do
      create :user, password: password, email: email
    end
    let (:password)      { 'password' }
    let (:email)         { 'email@test.com' }
    let (:auth_password) { password }
    let (:auth_email)    { email }
    let (:token)         { session.token }

    context 'with valid credentials' do
      it 'is epect to authorize a user' do
        expect(session.persisted?).to be_truthy
        is_expected.to be_a Session
        expect(session.user).to eql user
      end
    end

    context 'with wrong password' do
      let(:auth_password) { 'wrong_password' }

      it 'is epect to raise an eception' do
        expect { session }.to raise_exception(AuthError)
      end
    end

    context 'with wrong email' do
      let(:auth_email) { 'wrong_password' }

      it 'is epect to raise an eception' do
        expect { session }.to raise_exception(AuthError)
      end
    end
  end

  describe 'authorize user with token' do
    subject(:session) do
      Session.authorize_user_with_token(token)
    end

    let(:auth_session)  { create :session }
    let(:token)         { auth_session.token }

    context 'with valid token' do
      it 'is epect to authorize a user' do
        expect(session.persisted?).to be_truthy
        is_expected.to be_a Session
        expect(session).to eql auth_session
      end
    end

    context 'with invalid token' do
      let(:token) { SecureRandom.base64 }

      it 'is epect to raise an eception' do
        expect { session }.to raise_exception(AuthError)
      end
    end

  end

end