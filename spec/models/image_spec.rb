require "rails_helper"

RSpec.describe Image, type: :model do
  subject { build :image }

  describe 'validations' do
    it { is_expected.to validate_presence_of :image }
    it { is_expected.to validate_presence_of :imageable }
  end

  describe 'associations' do
    it { is_expected.to belong_to :imageable }
  end

end