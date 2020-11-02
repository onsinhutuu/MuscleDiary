require 'rails_helper'
RSpec.describe 'Musclesコントローラのテスト', type: :request do
	let(:user) { create(:user) }
	let(:muscle) { create(:muscle) }
	let(:tag) { build(:tag, muscles: muscle) }
  subject { response }
  describe 'GET #show' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/muscles/' + muscle.id.to_s
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      # 302レスポンスが返ってきているか？
      it "302レスポンスが返ってくる" do
        get '/muscles/' +  muscle.id.to_s
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'GET #hashtag' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        @tag = tag.muscles.first
        get '/muscle/hashtag/:name', params: { tag_id: @tag.id }
        tags = tag.muscles
      	expect(assigns(:tags)).to eq tags
      end
    end
  end
end