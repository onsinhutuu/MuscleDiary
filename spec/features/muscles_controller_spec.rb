require 'rails_helper'
RSpec.describe 'Userscontrollerのテスト', type: :feature do
	include Devise::Test::IntegrationHelpers
	let(:user) { create(:user) }
	let(:muscle) { create(:muscle) }
	before do
		sign_in user
	end
	describe '投稿のテスト' do
		describe '表示の確認' do
			let!(:muscle) { create(:muscle) }
			context '一覧ベージ' do
				before do
					visit muscles_path
				end
				it '検索ボタンがあるか' do
					expect(page).to have_content '検索'
				end
				it '投稿があるか' do
					expect(page).to have_content muscle.parts.name
					expect(page).to have_content muscle.weight
				end
				it 'newページへ遷移できるか' do
					visit muscles_path
					find('.fc-left').click
					expect(current_path).to eq('/muscles/new')
				end
				it 'カレンダーに戻ると表示される' do
			  	visit new_muscle_path
		    	expect(page).to have_content 'カレンダーに戻る'
			  end
				it '投稿に成功する' do
					visit new_muscle_path
					fill_in "muscle[title]", with: Faker::Lorem.characters(number: 10)
		      fill_in 'muscle[body]', with: Faker::Lorem.characters(number: 20)
		      click_button '追加'
		      expect(page).to have_content 'イベントが追加されました'
		    end
		    it '投稿に失敗する' do
		    	visit new_muscle_path
			  	click_button '追加'
			  	expect(page).to have_content 'を入力してください'
			  	expect(current_path).to eq('/muscles')
				end
			end
		end
			context '表示の確認' do
				before do
					visit edit_muscle_path(muscle)
				end
				it 'title編集フォームが表示される' do
					expect(page).to have_field 'muscle[title]', with: muscle.title
				end
				it 'body編集フォームが表示される' do
					expect(page).to have_field 'muscle[body]', with: muscle.body
				end
				it '詳細に戻るリンクが表示される' do
					expect(page).to have_link '詳細に戻る', href: muscle_path(muscle)
				end
				it 'カレンダーに戻るリンクが表示される' do
					expect(page).to have_link 'カレンダーに戻る', href: muscles_path
				end
			end
			context 'フォームの確認' do
				it '編集に成功する' do
					visit edit_muscle_path(muscle)
					click_button '追加'
					expect(page).to have_content 'イベントが更新されました'
					expect(current_path).to eq '/muscles/' + muscle.id.to_s
				end
				it '編集に失敗する' do
					visit edit_muscle_path(muscle)
					fill_in 'muscle[title]', with: ''
					click_button '追加'
					expect(page).to have_content 'を入力してください'
					expect(current_path).to eq '/muscles/' + muscle.id.to_s
				end
			end
		end
		describe '詳細画面のテスト' do
			before do
				visit muscle_path(muscle)
			end
			context '画面の遷移' do
	  	  it '編集画面へ遷移できる' do
		  		click_on '編集する'
		  		expect(current_path).to eq('/muscles/' + muscle.id.to_s + '/edit')
		  	end
		  	it '投稿を削除できる' do
					click_on '削除する'
					expect { muscle.destroy }.to change{ muscle.count }.by(-1)
				end
		  end
	  	context '投稿詳細画面の表示を確認' do
	  		it '投稿のtitleが表示される' do
	  			visit muscle_path(muscle)
	  			expect(page).to have_content muscle.title
	  		end
	  		it '投稿のbodyが表示される' do
	  			expect(page).to have_content muscle.body
	  		end
	  	end
	  	context '自分の投稿詳細画面の表示を確認' do
	  		it '投稿の編集リンクが表示される' do
	  			expect(page).to have_link '編集する', href: edit_muscle_path(muscle)
	  		end
	  		it '投稿の削除リンクが表示される' do
	  			expect(page).to have_link '削除する', href: muscle_path(muscle)
	  		end
	  		it 'カレンダーに戻るリンクが表示される' do
					expect(page).to have_link 'カレンダーに戻る', href: muscles_path
				end
	  	end
  	end
  	describe '一覧画面のテスト' do
  		let!(:muscle) { create(:muscle) }
	  	before do
	  		visit muscles_path
	  	end
	  	context '表示の確認' do
	  		it 'イベントを追加と表示される' do
	  			expect(page).to have_content 'イベントを追加'
	  		end
	  		it 'イベントが表示される' do
	  			expect(page).to have_content muscle.title
	  			expect(page).to have_content '08:13'
	  		end
	  	end
  	end
	end
end