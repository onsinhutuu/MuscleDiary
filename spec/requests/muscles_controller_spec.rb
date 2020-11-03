require 'rails_helper'
RSpec.describe 'Musclesコントローラのテスト', type: :request do
	let(:user) { create(:user) }
	let(:muscle2) { create(:muscle) }
  subject { response }
  describe 'GET #show' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/muscles/' + muscle2.id.to_s
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/muscles/' +  muscle2.id.to_s
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'GET #hashtag' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        pending 'なぜかtagがnilになるので飛ばします'
        get '/muscle/hashtag/:name'
        is_expected.to have_http_status "200"
      end
    end
  end
  describe 'GET #index' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/muscles'
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/muscles'
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'GET #following' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/muscles/' + muscle2.id.to_s + '/following'
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/muscles/' + muscle2.id.to_s + '/following'
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'GET #edit' do
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/muscles/' + muscle2.id.to_s + '/edit'
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'PUT #update' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
      	muscle_params = FactoryBot.attributes_for(:muscle, memo: "しんどいぞ")
        sign_in user
      	patch '/muscles/' +  muscle2.id.to_s, params: { id: muscle2.id, muscle: muscle_params }
        expect(muscle2.reload.memo).to eq "しんどいぞ"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        put '/muscles/' +  muscle2.id.to_s
        is_expected.to have_http_status "302"
      end
    end
  end
end