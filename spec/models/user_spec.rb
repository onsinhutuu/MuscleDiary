require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }
    let(:user) { create(:user) }
    context 'nameカラム' do
      it '空欄ではないこと' do
        user.name = ''
        is_expected.to eq false
        expect(user.errors[:name]).to include('を入力してください')
      end
      it '2文字以上であること' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
        expect(user.errors[:name]).to include('は2文字以上で入力してください')
      end
      it '20文字以下であること' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
        expect(user.errors[:name]).to include('は20文字以内で入力してください')
      end
    end
    context 'emailカラム' do
      before do
        User.create(
          name: "John",
          email: "test@example.com",
          password: "i-am-john",
          password_confirmation: "i-am-john"
        )

        @user = User.new( 
          name: "John",
          email:      "test@example.com",
          password:   "i-am-peter",
          password_confirmation: "i-am-peter"
        )
      end 
      it '空欄ではないこと' do
        user.email = ''
        is_expected.to eq false
        expect(user.errors[:email]).to include('を入力してください')
      end
      it '重複していないこと' do
        @user.valid?
        expect(@user.valid?).to eq(false)
      end
    end
    context 'passwordカラム' do
      it '空欄ではないこと' do
        user.password = ''
        is_expected.to eq false
        expect(user.errors[:password]).to include('を入力してください')
      end
    end
    context 'password_confirmationカラム' do
      it '空欄ではないこと' do
        user.password_confirmation = ''
        is_expected.to eq false
        expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
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
  describe 'モデルのメソッド' do
    let(:user) { create(:user) }
    it "active_for_authentication?" do
      expect(user.active_for_authentication?).to eq(true)
    end
  end
end
