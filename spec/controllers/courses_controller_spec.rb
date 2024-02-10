require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns courses with all courses and their tutors' do
      course = create(:course)
      tutor = create(:tutor, course: course)
      get :index
      expect(assigns(:courses)).to eq([course.as_json(include: [:tutors])])
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new course' do
        expect {post :create, params: { course: attributes_for(:course, tutors_attributes: [attributes_for(:tutor)]) }}.to change(Course, :count).by(1)
      end

      it 'renders the course as JSON' do
        post :create, params: { course: attributes_for(:course, tutors_attributes: [attributes_for(:tutor)]) }
        expect(response).to have_http_status(:created)
        expect(response.body).to eq(Course.last.to_json)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new course' do
        expect {post :create, params: { course: attributes_for(:course, name: nil) }}.not_to change(Course, :count)
      end
      it 'renders error messages as JSON' do
        post :create, params: { course: attributes_for(:course, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Name can't be blank")
      end
    end
  end
end
