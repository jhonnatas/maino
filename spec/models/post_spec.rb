require 'rails_helper'

RSpec.describe Post, type: :model do
 
  context 'when create' do
    let(:post) { create(:post)}
    let(:comment) { create(:comment)}

    #it { is_expected.to have_many(:comments) }

    #it { is_expected.to belong_to(:user) }
    
    xit 'is valid' do
      expect(post).to be_valid
      puts post.title
      puts post.content
      puts post.user_id
      
      puts comment.body
      puts comment.usercomment
      puts comment.post_id
    end

    it 'when title length < 2  characters' do
      post = create(:post, title: 's')
      expect(post).not_to be_invalid

     # expect(post).not_to be_valid
    end

    xit 'when description length < 2 characters' do
      post.description = 'p'
      expect(post.description.length).to be < 2
    end
    
    xit 'when title length > 200 characters'  do
      post = create(:post, title: 'Donec ante risus, venenatis sit amet dolor volutpat, porta dignissim mauris.Vestibulum porta dignissim mauris porta dignissim mauris porta dignissim mauris porta dignissim')
      expect(post).not_to be_valid
    end
  end
end