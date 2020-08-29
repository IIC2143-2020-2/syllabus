class Grupo
  attr_reader :id
  def initialize(id)
    @id = id.to_i
    @partial_grades = []
    @final_grade = 0
    @presentation_grade = 0
  end

  def add_grades(final_grade, presentation_grade, *partial_grades)
    @partial_grades.push(*partial_grades)
    @partial_grades = @partial_grades.map(&:to_f)
    @final_grade = final_grade.to_f
    @presentation_grade = presentation_grade.to_f
  end

  def project_grade
    partial = (@partial_grades.inject(0, :+) / @partial_grades.size)
    partial * 0.5 + @final_grade * 0.2 + @presentation_grade * 0.3
  end
end

class Persona
  attr_reader :id, :name
  def initialize(id, name)
    @id = id.to_i
    @name = name
  end
end

class Ayudante < Persona
  attr_reader :grupos
  def initialize(id, name, *grupos)
    super(id, name)
    @grupos = [*grupos]
  end
end

class Alumno < Persona
  attr_reader :grupo
  def initialize(id, name, i1, i2, examen, grupo)
    super(id, name)
    @i1 = i1.to_f
    @i2 = i2.to_f
    @examen = examen == 'P' ? examen : examen.to_f
    @grupo = grupo.to_i
  end

  def lecture_grade
    if @examen == 'P'
      nil
    else
      (@i1 + @i2 + @examen) / 3
    end
  end

  def my_team(teams)
    teams.each do |team|
      return team if @grupo == team.id
    end
  end
end
