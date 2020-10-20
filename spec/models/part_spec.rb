require 'rails_helper'
RSpec.describe 'Partモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:part) { build(:part, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        part.name = ''
        expect(part.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Part.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Bigモデルとの関係' do
      it 'N:1となっている' do
        expect(Part.reflect_on_association(:big).macro).to eq :belongs_to
      end
    end
  end
end