json.name = @category.name
json.id = @category.id
json.questions do |json|
	json.array!(@questions) do |ques|
	  json.extract! ques, :id, :body
	end
end
