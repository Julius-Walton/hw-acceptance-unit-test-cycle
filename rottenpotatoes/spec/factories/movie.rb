FactoryBot.define do
    factory :movie do
       title {'Test Title'}
       rating {'PG'}
       release_date {5.years.ago}
       director {'Some Director'}
    end
end