require 'rails_helper'
RSpec.describe 'Userscontrollerのテスト', type: :feature do
	include Devise::Test::IntegrationHelpers
	let(:user) { create(:user) }
	let(:muscle) { create(:muscle) }
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
		end
	end
end