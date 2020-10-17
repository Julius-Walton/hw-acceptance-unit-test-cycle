require 'rails_helper'

describe Movie do
   it '.find_movies_with_same_director' do
       expect(described_class).to respond_to(:find_movies_with_same_director).with(1)
   end
    
   it 'should find movies with the same director' do
       m1 = Movie.create! :director => 'test'
       m2 = Movie.create! :director => 'test'
       expect(Movie.find_movies_with_same_director(m1.id)).to include(m2)
       expect(Movie.find_movies_with_same_director(m2.id)).to include(m1)
   end

   it 'should not find movies with differect directors' do
       m1 = Movie.create! :director => 'test'
       m2 = Movie.create! :director => 'test2'
       expect(Movie.find_movies_with_same_director(m1.id)).not_to include(m2)
       expect(Movie.find_movies_with_same_director(m2.id)).not_to include(m1)
   end
end