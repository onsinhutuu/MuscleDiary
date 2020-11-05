require 'rails_helper'
RSpec.describe 'Userscontrollerのテスト', type: :feature do
	include Devise::Test::IntegrationHelpers
	let(:user) { create(:user) }
	describe 'ログインとログアウト' do
			before do
   			User.create!(name: 'aaa', email: 'foo@example.com', password: '123456')
  		end
		it 'ログインする' do
	    # トップページを開く
	    visit new_user_session_path
	    # ログインフォームにEmailとパスワードを入力する
	    fill_in 'Eメール', with: 'foo@example.com'
	    fill_in 'パスワード', with: '123456'
	    # ログインボタンをクリックする
	    click_on 'ログイン'
	    # ログインに成功したことを検証する
	    expect(page).to have_content 'ログインしました'
	  end
	  it 'ログアウトする' do
	  	sign_in user
	  	visit muscles_path
	  	click_link 'LOG OUT', match: :first
	  	expect(page).to have_content 'ログアウトしました'
	  end
	end
	describe 'PUT #update' do
	  it "更新できるか" do
	      sign_in user
	      visit edit_user_path(user)
	      click_on "編集内容を保存する"
	      expect(current_path).to eq '/users/' + user.id.to_s
	  end
	end
end