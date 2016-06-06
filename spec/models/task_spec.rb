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
    it { is_expected.to have_one :image }
  end

  describe 'params validation' do
    context 'resize' do
      it 'is epect to be valid' do
        valid_task = build(:task_with_valid_resize_params)
        expect(valid_task).to be_valid
      end

      it 'is epect to be invalid' do
        invalid_tasks = build(:tasks_with_ivalid_resize_params)
        invalid_tasks.each { |t| expect(t).not_to be_valid }
      end
    end

    context 'rotate' do
      it 'is epect to be valid' do
        valid_task = build(:task_with_valid_rotate_params)
        expect(valid_task).to be_valid
      end

      it 'is epect to be invalid' do
        invalid_tasks = build(:tasks_with_ivalid_rotate_params)
        invalid_tasks.each { |t| expect(t).not_to be_valid }
      end
    end
  end

end