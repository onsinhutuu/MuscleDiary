require 'rails_helper'
RSpec.describe 'Userscontrollerのテスト', type: :feature do
	include Devise::Test::IntegrationHelpers
	let(:user) { create(:user) }
	describe 'PUT #update' do
	  it "更新できるか" do
	      sign_in user
	      visit edit_user_path(user)
	      click_on "編集内容を保存する"
	      expect(current_path).to eq '/users/' + user.id.to_s
	  end
	end
end