require 'rails_helper'
RSpec.describe 'Muscleモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let(:part) { create(:part) }
    let!(:muscle) { build(:muscle, user_id: user.id, part_id: part.id) }

    context 'weightカラム' do
      it '空欄でないこと' do
        muscle.weight = ''
        expect(muscle.valid?).to eq false
      end
      it '整数である' do
        muscle.weight = '1.1'
        expect(muscle.valid?).to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Muscle.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Partモデルとの関係' do
      it 'N:1となっている' do
        expect(Muscle.reflect_on_association(:part).macro).to eq :belongs_to
      end
    end
  end
end
