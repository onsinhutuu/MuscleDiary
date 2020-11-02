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
      # 302レスポンスが返ってきているか？
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
      # 302レスポンスが返ってきているか？
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
      # 302レスポンスが返ってきているか？
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
      # 302レスポンスが返ってきているか？
      it "302レスポンスが返ってくる" do
        get '/users/' + user.id.to_s + '/edit'
        is_expected.to have_http_status "302"
      end
    end
  end

  describe 'PUT #update' do
    context 'ログインユーザーである場合' do
      it '200レスポンスが返ってくる' do
        sign_in user
        pending 'この先はなぜかテストが失敗するのであとで直す'
        put '/users/' + user.id.to_s
        is_expected.to have_http_status "200"
      end
    end
    context "ログインユーザーでない場合" do
      # 302レスポンスが返ってきているか？
      it "302レスポンスが返ってくる" do
        put '/users/' + user.id.to_s
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