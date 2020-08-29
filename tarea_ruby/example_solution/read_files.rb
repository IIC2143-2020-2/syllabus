require 'csv'

def read_students(file_name)
  students = []
  CSV.foreach(file_name, headers: true) do |row|
    students << Alumno.new(*row.fields)
  end
  students
end

def read_teaching_assistants(file_name)
  teaching_assistants = []
  CSV.foreach(file_name, headers: true) do |row|
    teaching_assistants << Ayudante.new(
      row['id'], row['nombre'],
      *row['grupos'].split(':').map(&:to_i)
    )
  end
  teaching_assistants
end

def read_teams(file_name)
  groups = []
  CSV.foreach(file_name, headers: true) do |row|
    current_group = Grupo.new(row['id'])
    current_group.add_grades(
      row['nota_ef'], row['nota_presentacion'],
      *row.fields(1, 2, 3, 4)
    )
    groups << current_group
  end
  groups
end
