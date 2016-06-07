require "rails_helper"

RSpec.describe Task, type: :model do
  subject { build :task }

  describe 'general validations' do
    it { is_expected.to validate_presence_of :type }
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :user }
    it { is_expected.to validate_presence_of :image }
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :image }
  end

  describe 'inclusion' do
    it do
      should validate_inclusion_of(:status).
        with([:new, :pending, :done])
    end
    it do
      should validate_inclusion_of(:type).
        with([:resize, :rotate, :negate])
    end
  end

  describe "resize" do
    
    context 'with valid params' do
      it 'expected to be valid' do
        task = create :task, :resize
        expect(task).to be_valid
      end
    end

    context 'with invalid params' do
      let(:valid_dimension) { Faker::Number.number(3).to_i }
      let(:invalid_params_list) { [
          nil,
          { :height => valid_dimension },
          { :width => valid_dimension },
          { :width => -1, :height => valid_dimension },
          { :width => valid_dimension, :height => -1 },
          { :width => '100', :height => valid_dimension },
          { :width => valid_dimension, :height => '100' }
        ] }
      it 'expected to be invalid' do
        invalid_params_list.each do |invalid_params|
          task = build :task, :resize, params: invalid_params
          expect(task).to_not be_valid
        end
      end
    end
  end

  describe "rotate" do
    
    context 'with valid params' do
      it 'expected to be valid' do
        task = create :task, :rotate
        expect(task).to be_valid
      end
    end

    context 'with invalid params' do
      let(:invalid_params_list) { [
          nil,
          { :angle => -1 },
          { :angle => 361 },
          { :angle => '90' }
        ] }
      it 'expected to be invalid' do
        invalid_params_list.each do |invalid_params|
          task = build :task, :rotate, params: invalid_params
          expect(task).to_not be_valid
        end
      end
    end
  end

end
