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

end