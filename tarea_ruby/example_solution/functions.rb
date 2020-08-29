def who_passed(students, teams)
  passed = []
  students.each do |student|
    lecture_grade = student.lecture_grade
    project_grade = student.my_team(teams).project_grade
    if !lecture_grade.nil? && lecture_grade >= 4 && project_grade >= 4
      passed << [student.id, student.name, (lecture_grade + project_grade) / 2]
    end
  end
  passed.sort
end

def who_failed(students, teams)
  failed = []
  students.each do |student|
    lecture_grade = student.lecture_grade
    project_grade = student.my_team(teams).project_grade
    if !lecture_grade.nil? && (lecture_grade < 4 || project_grade < 4)
      final_grade = [(lecture_grade + project_grade) / 2, 3.9].min
      failed << [student.id, student.name, final_grade]
    end
  end
  failed.sort
end

def get_teams_by_teaching_assistant(teaching_assistant, teams)
  teams.select { |t| teaching_assistant.grupos.include? t.id }
end

def get_students_by_team(team, students)
  students.select { |student| student.grupo == team.id }
end

def aprobados(students, teams, output)
  passed = who_passed(students, teams)
  File.open(output, 'a') do |f|
    f.puts 'COMIENZA APROBADOS'
    passed.each do |p|
      f.puts "#{p[0]} #{p[1]} #{p[2]}"
    end
    f.puts 'TERMINA APROBADOS'
  end
end

def reprobados(students, teams, output)
  failed = who_failed(students, teams)
  File.open(output, 'a') do |f|
    f.puts 'COMIENZA REPROBADOS'
    failed.each do |p|
      f.puts "#{p[0]} #{p[1]} #{p[2]}"
    end
    f.puts 'TERMINA REPROBADOS'
  end
end

def project(teaching_assistants, teams, students, output)
  File.open(output, 'a') do |f|
    f.puts 'COMIENZA PROYECTO'
    teaching_assistants.sort_by(&:id).each do |ta|
      f.puts 'ayudante:'
      f.puts "#{ta.id} #{ta.name}"
      get_teams_by_teaching_assistant(ta, teams).sort_by(&:id).each do |team|
        f.puts 'grupo:'
        f.puts team.id
        f.puts 'integrantes:'
        participants = ''
        get_students_by_team(team, students).sort_by(&:id).each do |student|
          participants += "#{student.id} #{student.name} "
        end
        f.puts participants.chop
      end
    end
    f.puts 'TERMINA PROYECTO'
  end
end

def top_teams(teams, output)
  sorted_teams = teams.sort_by { |team| -team.project_grade }
  File.open(output, 'a') do |f|
    f.puts 'COMIENZA TOP GRUPOS'
    sorted_teams[0..2].each do |top|
      f.puts "#{top.id} #{top.project_grade}"
    end
    f.puts 'TERMINA TOP GRUPOS'
  end
end

def get_grade_by_teaching_assistant(teaching_assistant, teams)
  grades_sum = 0
  get_teams_by_teaching_assistant(teaching_assistant, teams).each do |team|
    grades_sum += team.project_grade
  end
  grades_sum / get_teams_by_teaching_assistant(teaching_assistant, teams).size
end

def top_teaching_assistant(teaching_assistants, teams, output)
  sorted_teaching_assistants = teaching_assistants.sort_by do |ta|
    -get_grade_by_teaching_assistant(ta, teams)
  end
  top_ta = sorted_teaching_assistants[0]
  File.open(output, 'a') do |f|
    f.puts 'COMIENZA TOP AYUDANTE'
    f.puts "#{top_ta.id} #{top_ta.name} #{get_grade_by_teaching_assistant(top_ta, teams)}"
    f.puts 'TERMINA TOP AYUDANTE'
  end
end
