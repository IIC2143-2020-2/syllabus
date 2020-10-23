##########################   PARTE B  ###############################

class Rey
  def create_rey(name)
    puts "You should implement this method in the concrete product\n"
  end
end

class ElfosRey < Rey
  def initialize(name)
    @name = name
  end
  def print
    puts "I am #{@name}, king of the Elfs\n"
  end
end

class OrcosRey < Rey
  def initialize(name)
    @name = name
  end
  def print
    puts "I am #{@name}, king of the Orcs\n"
  end
end

class HumanosRey < Rey
  def initialize(name)
    @name = name
  end
  def print
    puts "I am #{@name}, king of the Humans\n"
  end
end

class Castillo
  def create_castillo(name)
    puts "You should implement this method in the concrete product\n"
  end
end

class ElfosCastillo < Castillo
  def initialize(name)
      @name = name
  end
  def print
    puts "This is #{@name}, home of the Elfs\n"
  end
end

class OrcosCastillo < Castillo
  def initialize(name)
      @name = name
  end
  def print
    puts "This is #{@name}, home of the Orcs\n"
  end
end

class HumanosCastillo < Castillo
  def initialize(name)
      @name = name
  end
  def print
    puts "This is #{@name}, home of the Humans\n"
  end
end

class Ejercito
  def create_ejercito(description, number)
    puts "You should implement this method in the concrete product\n"
  end
end

class ElfosEjercito < Ejercito
  def initialize(description, number)
    @description = description
    @number = number
  end
  def print
    puts "This is the #{@description} composed of #{@number} Elfs\n"
  end
end

class OrcosEjercito < Ejercito
  def initialize(description, number)
    @description = description
    @number = number
  end
  def print
    puts "This is the #{@description} composed of #{@number} Orcs\n"
  end
end

class HumanosEjercito < Ejercito
  def initialize(description, number)
    @description = description
    @number = number
  end
  def print
    puts puts "This is the #{@description} composed of #{@number} Humans\n"
  end
end

class AbstractFactory
  def create_rey(name_rey)
    puts "You should implement this method in the concrete factory"
  end
  def create_castillo(name_castillo)
    puts "You should implement this method in the concrete factory"
  end
  def create_ejercito(description_ejercito, number_soldiers)
    puts "You should implement this method in the concrete factory"
  end
end

class ElfosFactory < AbstractFactory
  def create_rey(name_rey)
    ElfosRey.new(name_rey)
  end
  def create_castillo(name_castillo)
    ElfosCastillo.new(name_castillo)
  end
  def create_ejercito(description_ejercito, number_soldiers)
    ElfosEjercito.new(description_ejercito, number_soldiers)
  end
end

class OrcosFactory < AbstractFactory
  def create_rey(name_rey)
    OrcosRey.new(name_rey)
  end
  def create_castillo(name_castillo)
    OrcosCastillo.new(name_castillo)
  end
  def create_ejercito(description_ejercito, number_soldiers)
    OrcosEjercito.new(description_ejercito, number_soldiers)
  end
end

class HumanosFactory < AbstractFactory
  def create_rey(name_rey)
    HumanosRey.new(name_rey)
  end
  def create_castillo(name_castillo)
    HumanosCastillo.new(name_castillo)
  end
  def create_ejercito(description_ejercito, number_soldiers)
    HumanosEjercito.new(description_ejercito, number_soldiers)
  end
end

########################    PARTE C ############################

class Realm
  attr_accessor :reino_factory
  def initialize(a_factory, name_rey, name_castillo, description_ejercito, number_soldiers)
    @reino_factory = a_factory
    @rey = @reino_factory.create_rey(name_rey)
    @castillo = @reino_factory.create_castillo(name_castillo)
    @ejercito = @reino_factory.create_ejercito(description_ejercito, number_soldiers)
  end

  def describe
    @rey.print
    @castillo.print
    @ejercito.print
    puts "-------------------------------------------\n"
  end
end

reino_orc = Realm.new(OrcosFactory.new, "Melkor", "Isengard", "powerful Goblins army", 20000).describe
reino_elf = Realm.new(ElfosFactory.new, "Thranduil", "Woodlands", "powerful Elves army", 2500).describe
reino_orc = Realm.new(HumanosFactory.new, "Aragorn", "Silmarillion", "powerful Soldiers army", 4500).describe
