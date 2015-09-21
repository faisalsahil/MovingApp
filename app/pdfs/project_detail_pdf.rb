class ProjectDetailPdf < Prawn::Document
  def initialize(project, view,report)
    super(top_margin: 20)
    @project = project
    @report = report
    project_heading
    project_answers
    
  end

  def project_heading
    text  "<u>Detailed View of project #{@project.name}</u>", size: 25, style: :bold, align: :center, inline_format: true

    data = [ ["Address:", @project.address ],[  "Contact Information:", @project.contact_info ]]
  
    move_down 20
    table(data, cell_style: {border_width: 0}) do
      columns(0).font_style = :bold
    end
  end
  
  def project_answers
    move_down 30
    @answers = @report.answers
    Category.all.includes(:questions).all.each do |c|
      text "<u>#{c.name}<u>", style: :bold, size: 22, inline_format: true 
      c.questions.each do |q|
        move_down 10
        text "Q: #{q.body}", size: 16, style: :bold
        answer = @answers.find_by(question_id: q.id)
        text "Ans: #{GlobalConstants::Answers::STATUSES[answer.status][0]}", color: "321414"
        text "Notes: #{answer.notes}", color: "321414"
      end
      move_down 30
    end 
  end
end