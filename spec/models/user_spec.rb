require "rails_helper"

RSpec.describe User do
  subject { FactoryGirl.build(:user) }
  it { is_expected.to validate_presence_of(:name) }
end