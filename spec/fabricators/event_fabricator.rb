Fabricator(:event) do
	contact {Faker::Name.name}
	contact_info {Faker::Address.street_address(include_secondary = false)}
	conversation_date { Date.today}
	notes {Faker::Lorem.paragraph}
	conversation_time {Time.now}
	conversation_type {"Interview"}
	job_prospect_id {Fabricate(:job_prospect).id}
end