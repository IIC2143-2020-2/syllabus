module Exercise1
  class NotificationCenter
    @@instance = nil

    def self.instance
      @@instance ||= new #condicional: si ya la cree no hace nada.
    end

    def initialize
      @listeners = {}
    end

    def register_listener(event_id, listener)
      if @listeners.key? event_id #si lo encontré lo agrego a la lista
        @listeners[event_id] << listener
      else
        @listeners[event_id] = [listener] #si no está lo agrego
      end
    end

    def delete_listener(event_id, listener)
      @listeners[event_id].delete(listener) if @listeners.key? (event_id)
    end

    def notify(event_id, *arguments)
      @listeners[event_id].each do |listener|
        listener.update(event_id, *arguments)
      end
    end

    private_class_method :new
  end

  class Employee
    attr_accessor :salary, :taxes

    def initialize(salary, taxes)
      @salary = salary
      @taxes = taxes
    end

    def update_salary_and_taxes(salary, taxes)
      @salary = salary
      @taxes = taxes

      notification_center = NotificationCenter.instance
      notification_center.notify(:my_event, salary, taxes)

    end
  end

  class Payroll
    def initialize
      notification_center = NotificationCenter.instance
      notification_center.register_listener(:my_event, self)
    end

    def update(event_id, salary, taxes)
      puts "new salary is #{salary}"
      puts "new taxes are #{taxes}"
    end
  end

  subject = Employee.new(1_000_000, 100_000)
  observer = Payroll.new
  subject.update_salary_and_taxes(1_100_000, 120_000)
end
