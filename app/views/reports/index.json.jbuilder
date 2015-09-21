json.reports do |json|
	json.array!(@reports) do |json,report|
	  json.id report.id
	  json.name report.name
	  @answers = report.answers.where(status: 2).count
	  json.user_id @answers
	end
end

json.goodreports do |json|
	json.array!(@good_report) do |json,report|
	  json.id report.id
	  json.name report.name
	end
end
