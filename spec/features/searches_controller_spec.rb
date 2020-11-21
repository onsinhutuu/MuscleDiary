require 'rails_helper'
RSpec.describe 'Searchescontrollerのテスト', type: :feature do
	include Devise::Test::IntegrationHelpers
	let(:user) { create(:user) }
	let(:muscle) { create(:muscle, user_id: user.id) }
	before do
		sign_in user
  end
  describe `検索機能` do
    let!(:muscle) { create(:muscle, user_id: user.id) }
    before do
      visit muscles_path
    end
    context 'タグの検索結果' do
      it '部分一致' do
        fill_in 'search_content', with: 'まじか'
        select 'タグ', from: 'search_model'
        select '部分一致', from: 'search_how'
        click_on '検索', match: :first
        expect(page).to have_content muscle.work_tag
      end
    end
    context 'ユーザーの検索結果があるか' do
      before do
        User.create!(name: '範馬刃牙', email: 'foo@example.com', password: '123456')
      end
      it '前方一致' do
        fill_in 'search_content', with: '範馬'
        select 'ユーザー', from: 'search_model'
        select '前方一致', from: 'search_how'
        click_on '検索', match: :first
        expect(page).to have_content '範馬刃牙'
      end
      it '部分一致' do
        fill_in 'search_content', with: '範'
        select 'ユーザー', from: 'search_model'
        select '部分一致', from: 'search_how'
        click_on '検索', match: :first
        expect(page).to have_content '範馬刃牙'
      end
    end
  end
end