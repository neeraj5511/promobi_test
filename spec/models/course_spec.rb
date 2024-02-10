require 'rails_helper'

RSpec.describe Course, type: :model do
  it 'valid with valid attributes' do
    course = build(:course)
    expect(course).to be_valid
  end

  it 'not valid without a name' do
    course = build(:course, name: nil)
    expect(course).not_to be_valid
    expect(course.errors[:name]).to include("can't be blank")
  end

  it 'not valid without a description' do
    course = build(:course, description: nil)
    expect(course).not_to be_valid
    expect(course.errors[:description]).to include("can't be blank")
  end

  it 'not valid with a duplicate name' do
    create(:course, name: 'Example Course')
    course = build(:course, name: 'example course')
    expect(course).not_to be_valid
    expect(course.errors[:name]).to include('has already been taken')
  end

  it 'destroys associated tutors when destroyed' do
    course = create(:course)
    tutor = create(:tutor, course: course)
    expect {course.destroy}.to change(Tutor, :count).by(-1)
  end

  it 'accepts nested attributes for tutors' do
    course_params = {name: 'Nested Course',description: 'This a nested course',tutors_attributes: [{ name: 'Tutor 1', experience: '5 years' },
        { name: 'Tutor 2', experience: '3 years' }]}
    course = build(:course, course_params)
    expect(course).to be_valid
    expect(course.tutors.length).to eq(2)
  end

  it 'rejects nested attributes for tutors with invalid data' do
    course_params = {name: 'Invalid Nested Course',description: 'This is an invalid nested course',
      tutors_attributes: [{ name: nil, experience: '5 years' }]}
    course = build(:course, course_params)
    expect(course).not_to be_valid
    expect(course.errors[:tutors]).to include()
  end
end
