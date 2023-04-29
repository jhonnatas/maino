require 'rails_helper'

RSpec.describe Post, type: :model do
  #it { is_expected.to have_many(:comments) }

  #it { is_expected.to belong_to(:user) }

  context 'when create' do
   # let(:user) { create(:user)}
    let(:post) { create(:post)}
    
    it 'is valid' do
      expect(post).to be_valid
    end

    xit 'is invalid when title has less than 2 characters'  do
      post.title = 's'
      expect(post).not_to be_valid
    end

    xit 'is invalid when description has less than 2 characters' do
      post.description = 'p'
      expect(post).not_to be_valid
    end
    
    it 'is invalid when title has more than 200 characters'  do
      post.title = 'Donec ante risus, venenatis sit amet dolor volutpat, 
      porta dignissim mauris. Vestibulum volutpat metus libero, 
      in volutpat dolor congue vitae. Fusce ac lorem tellus. 
      Curabitur euismod rutrum posuere. '

      expect(post).not_to be_valid
    end   
  end
end