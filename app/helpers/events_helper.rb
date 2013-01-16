module EventsHelper
	def time_of_day(military_hour)
		military_hour > 12 ? "PM" : "AM"
	end

	def hour(military_hour)
		if military_hour > 12
			"#{military_hour-12}"
		elsif military_hour == 0
			"12"
		else
			"#{military_hour}"
		end
	end

	def minute(minutes)
		minutes <10 ? "0#{minutes}" : "#{minutes}"
	end

	def time(military_hour, minutes)
		"#{hour(military_hour)}:#{minute(minutes)} #{time_of_day(military_hour)}"
	end

	def date(month, day, year)
		"#{month}/#{day}/#{year.to_s[2..3]}"
	end

	def notes(note)
		note.length > 75 ? "#{note[0..74]}...": note
	end


end
