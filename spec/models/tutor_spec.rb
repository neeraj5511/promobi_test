require 'rails_helper'

RSpec.describe Tutor, type: :model do
  it 'is valid with valid attributes' do
    tutor = build(:tutor)
    expect(tutor).to be_valid
  end

  it 'is not valid without a name' do
    tutor = build(:tutor, name: nil)
    expect(tutor).not_to be_valid
    expect(tutor.errors[:name]).to include("can't be blank")
  end

  it 'is not valid without experience' do
    tutor = build(:tutor, experience: nil)
    expect(tutor).not_to be_valid
    expect(tutor.errors[:experience]).to include("can't be blank")
  end

  it 'belongs to a course' do
    course = create(:course)
    tutor = create(:tutor, course: course)
    expect(tutor.course).to eq(course)
  end
end
