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
	describe '編集機能' do
	  it "更新できるか" do
			sign_in user
			visit edit_user_path(user)
			click_on "編集内容を保存する"
			expect(current_path).to eq '/users/' + user.id.to_s
	  end
	end
	describe '退会機能' do
		before do
			sign_in user
		end
		context '画面の遷移' do
  	  it '編集画面から確認画面へ遷移できる' do
  	  	visit edit_user_path(user)
	  		click_on '退会する'
	  		expect(current_path).to eq('/users/' + user.id.to_s + '/unsubscribe')
	  	end
	  	it '確認画面から退会' do
	  		visit unsubscribe_user_path(user)
				click_on '退会する'
				expect {  user.update(is_deleted: true) }.to change{ user.is_deleted == true }
				expect(current_path).to eq '/'
				expect(page).to have_content 'ありがとうございました'
			end
			it '確認画面から退会しない' do
				visit unsubscribe_user_path(user)
				click_on '退会しない'
				expect(current_path).to eq('/users/' + user.id.to_s)
				expect(page).to have_content '編集'
			end
	  end
	end
end