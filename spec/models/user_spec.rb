require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }
    context 'nameカラム' do
      let(:user) { create(:user) }
      it '空欄ではないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '20文字以下であること' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      let(:user) { create(:user) }
      it '空欄ではないこと' do
        user.email = ''
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Muscleモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:muscles).macro).to eq :has_many
      end
    end
  end
  describe 'ユーザー登録' do
    it "name、email、passwordとpassword_confirmationが存在すれば登録できること" do
       user = build(:user)
       expect(user).to be_valid  # user.valid? が true になればパスする
    end
  end
end
