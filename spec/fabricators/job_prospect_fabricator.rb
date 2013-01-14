Fabricator(:job_prospect) do
	company {Faker::Lorem.word}
	position {Faker::Lorem.words(num = 2, supplemental = false)}
	user_id {Fabricate(:user).id}
end