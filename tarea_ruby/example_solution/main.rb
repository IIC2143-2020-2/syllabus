require_relative 'classes'
require_relative 'read_files'
require_relative 'functions'

if ARGV.length < 3
  puts 'wrong number of params'
  puts 'correct way is: ruby main.rb {datasets folder} {instructions file} {output file}'
  exit(1)
end
data_folder = ARGV[0].chomp('/')
instructions = ARGV[1]
output = ARGV[2]
teaching_assistants = read_teaching_assistants(data_folder + '/ayudantes.csv')
students = read_students(data_folder + '/alumnos.csv')
teams = read_teams(data_folder + '/grupos.csv')

File.open(output, 'w') do |f|
end

File.open(instructions, 'r').each do |instruction|
  case instruction.chomp
  when 'aprobados'
    aprobados(students, teams, output)
  when 'reprobados'
    reprobados(students, teams, output)
  when 'proyecto'
    project(teaching_assistants, teams, students, output)
  when 'top_grupos'
    top_teams(teams, output)
  when 'top_ayudante'
    top_teaching_assistant(teaching_assistants, teams, output)
  end
end
