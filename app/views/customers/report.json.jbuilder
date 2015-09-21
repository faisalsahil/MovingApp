json.project_name = @project.name
json.user_name = @uname
json.reports do |json|
  json.days_30 @days_30
  json.days_60 @days_60
  json.days_90 @days_90
end
