require 'rails_helper'

RSpec.describe 'Usersコントローラのテスト', type: :request do
  let(:user) { create(:user) }
  let(:params) { { user: attributes_for(:user) } }
  subject { response }
  describe 'GET #show' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/users/' + user.id.to_s
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/users/' + user.id.to_s
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'GET #follows' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/users/' + user.id.to_s + '/follows'
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/users/' + user.id.to_s + '/follows'
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'GET #followers' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/users/' + user.id.to_s + '/followers'
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/users/' + user.id.to_s + '/followers'
        is_expected.to have_http_status "302"
      end
    end
  end

  describe 'GET #edit' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        get '/users/' + user.id.to_s + '/edit'
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        get '/users/' + user.id.to_s + '/edit'
        is_expected.to have_http_status "302"
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインユーザーである場合' do
      it '更新できるか' do
        user_params = FactoryBot.attributes_for(:user, name: "遠藤")
        sign_in user
        patch '/users/' + user.id.to_s, params: { id: user.id, user: user_params }
        expect(user.reload.name).to eq "遠藤"
      end
    end
    context "ログインユーザーでない場合" do
      it "302レスポンスが返ってくる" do
        patch '/users/' + user.id.to_s
        is_expected.to have_http_status "302"
      end
    end
  end
  describe 'PATCH #withdraw' do
    context '退会が成功した場合' do
      it '302レスポンスが返ってくる' do
        sign_in user
        patch '/users/' + user.id.to_s + '/withdraw'
        is_expected.to have_http_status "302"
      end
    end
  end
end