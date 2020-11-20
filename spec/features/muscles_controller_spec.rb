require 'rails_helper'
RSpec.describe 'Userscontrollerのテスト', type: :feature do
	include Devise::Test::IntegrationHelpers
	let(:user) { create(:user) }
	let(:muscle) { create(:muscle, user_id: user.id) }
	let(:big) { create(:big) }
	before do
		sign_in user
	end
	describe '表示の確認' do
		let!(:muscle) { create(:muscle) }
		let!(:part) { build(:part, user_id: user.id, big_id: big.id) }
		context '一覧ベージ' do
			before do
				visit muscles_path
			end
			it '投稿があるか' do
				expect(page).to have_content muscle.part.name
				expect(page).to have_content muscle.weight
				expect(page).to have_content muscle.rep
				expect(page).to have_content muscle.set_count
			end
			it 'TODAY WORKOUTへ遷移できるか' do
				click_on 'TODAY WORKOUT', match: :first
				expect(current_path).to eq('/parts/new')
				expect(page).to have_content 'トレーニングメニュー'
			end
			it 'FRIEND WORKOUTへ遷移できる' do
				click_on 'FRIEND WORKOUT', match: :first
				expect(current_path).to eq('/muscles/' + muscle.id.to_s + '/following')
	    	expect(page).to have_content 'FRIEND WORKOUT'
		  end
			it 'MY PAGEへ遷移できる' do
				click_on 'MY PAGE', match: :first
				expect(current_path).to eq('/users/' + user.id.to_s)
	    	expect(page).to have_content 'マイページ'
		  end
		  it 'CONTACTへ遷移できる' do
				click_on 'CONTACT', match: :first
				expect(current_path).to eq ('/contacts/new')
	    	expect(page).to have_content 'お問い合わせフォーム'
		  end
		end
		context '詳細ベージ' do
			let!(:muscle) { create(:muscle, user_id: user.id) }
			before do
				visit muscle_path(muscle)
			end
			it '詳細投稿があるか' do
				expect(page).to have_content muscle.part.name
				expect(page).to have_content muscle.part.big.name
				expect(page).to have_content muscle.created_at.strftime('%Y/%m/%d %H:%M')
				expect(page).to have_content muscle.weight
				expect(page).to have_content muscle.rep
				expect(page).to have_content muscle.set_count
				expect(page).to have_content muscle.memo
				expect(page).to have_content 'いいね'
				expect(page).to have_content 'コメント数'
				expect(page).to have_content muscle.work_tag
			end
			it 'TODAY WORKOUTへ遷移できるか' do
				click_on 'TODAY WORKOUT', match: :first
				expect(current_path).to eq('/parts/new')
				expect(page).to have_content 'トレーニングメニュー'
			end
			it 'FRIEND WORKOUTへ遷移できる' do
				click_on 'FRIEND WORKOUT', match: :first
				expect(current_path).to eq('/muscles/' + muscle.id.to_s + '/following')
	    	expect(page).to have_content 'FRIEND WORKOUT'
		  end
			it 'MY PAGEへ遷移できる' do
				click_on 'MY PAGE', match: :first
				expect(current_path).to eq('/users/' + user.id.to_s)
	    	expect(page).to have_content 'マイページ'
		  end
		  it 'CONTACTへ遷移できる' do
				click_on 'CONTACT', match: :first
				expect(current_path).to eq ('/contacts/new')
				expect(page).to have_content 'お問い合わせフォーム'
			end
			it '編集へ遷移できる' do
				click_on '編集する', match: :first
				expect(current_path).to eq ('/muscles/' + muscle.id.to_s + '/edit')
				expect(page).to have_content '編集'
			end
			it '削除できる' do
				click_on '削除する', match: :first
				expect(current_path).to eq ('/muscles')
				expect(page).to have_content 'ALL WORKOUT'
		  end
		end
	end
	describe '投稿のテスト' do
		it '投稿に成功する' do
			visit workout_muscle_path(muscle)
			fill_in 'muscle[rep]', with: muscle.rep
			fill_in 'muscle[set_count]', with: muscle.set_count
			fill_in 'muscle[memo]', with: muscle.memo
			fill_in 'muscle[weight]', with: muscle.weight
			fill_in 'muscle[work_tag]', with: muscle.work_tag
			fill_in 'muscle[start_time]', with: muscle.start_time
			click_button '投稿'
			expect(page).to have_content '筋トレよく頑張った'
		end
		it '投稿に失敗する' do
			visit workout_muscle_path(muscle)
			click_button '投稿'
			expect(page).to have_content '全て記入してから投稿して下さい'
		end
		context '編集のテスト' do
			let!(:muscle) { create(:muscle, user_id: user.id) }
			it '編集に成功する' do
				visit edit_muscle_path(muscle)
				click_button '編集内容を保存する'
				expect(page).to have_content '投稿を編集しました'
				expect(current_path).to eq('/muscles/' + muscle.id.to_s)
			end
			it '編集に失敗する' do
				visit edit_muscle_path(muscle)
				fill_in 'muscle[rep]', with: ''
				click_button '編集内容を保存する'
				expect(page).to have_content '全て記入してから投稿して下さい'
				expect(current_path).to eq('/muscles/' + muscle.id.to_s + '/edit')
			end
		end
	end
end
