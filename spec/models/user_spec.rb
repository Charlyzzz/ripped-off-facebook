describe User do
  describe '#age' do
    it 'returns the years difference' do
      user = FactoryGirl.build(:user)
      expect(user.age).to eq 17
    end

    it 'rounds down the years difference' do
      user = FactoryGirl.build(:user, birth_date: Date.today - 364.days)
      expect(user.age).to be_zero
    end
  end

  describe 'validations' do
    context 'factory' do
      it 'has a valid factory' do
        user = FactoryGirl.build(:user)
        expect(user).to be_valid
      end
    end

    context 'name' do
      it 'is invalid without name' do
        user = FactoryGirl.build(:user, name: nil)
        expect(user).to be_invalid
      end
    end

    context 'username' do
      it 'is invalid without username' do
        user = FactoryGirl.build(:user, name: nil)
        expect(user).to be_invalid
      end

      it 'is invalid if the username is not unique' do
        FactoryGirl.create(:user).save
        user = FactoryGirl.build(:user)
        expect(user).to be_invalid
      end

      it 'is invalid if username is short' do
        user = FactoryGirl.build(:user, username: 'Fooba')
        expect(user).to be_invalid
      end
    end

    context 'birth_date' do
      it 'is invalid if birth is today' do
        user = FactoryGirl.build(:user, birth_date: Date.today)
        expect(user).to be_invalid
      end

      it 'is invalid if birth is in the future' do
        user = FactoryGirl.build(:user, birth_date: Date.today + 1.days)
        expect(user).to be_invalid
      end
    end
  end

  describe '#add_friend' do
    let(:friend) { FactoryGirl.create(:user) }
    let(:user) { FactoryGirl.create(:user, username: 'EAbbot') }

    it 'adds a new friend' do
      user.add_friend(friend)
      expect(user.friends.length).to eq 1
    end


    it 'does not add an existing friend' do
      2.times { user.add_friend(friend) }
      expect(user.friends.length).to eq 1
    end
  end
end
