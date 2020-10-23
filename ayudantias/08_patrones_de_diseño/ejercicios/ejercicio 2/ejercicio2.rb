
class Banco
  attr_reader :cuenta_banco

  def initialize
    @cuenta_banco = CuentaCorriente.new(0)
  end

  def transferir(fuente, destino, monto)
    if fuente.pesos >= monto
      fuente.pesos -= monto
      destino.pesos += monto
    end
  end

  def captar_redondeo(monto)
    @cuenta_banco.pesos += monto
  end
end

class AccountAdapter
  attr_reader :exchange_rate, :account

  def initialize(account, exchange_rate)
    @exchange_rate = exchange_rate
    @listeners = []
    @account = account
  end

  def pesos
    @account.dollars * @exchange_rate
  end

  def pesos=(value)
    dollars = value / @exchange_rate
    rounded_value = dollars.floor(2)
    difference = dollars - rounded_value
    @listeners.each do |listener|
      listener.captar_redondeo(difference * @exchange_rate)
    end
    @account.dollars = rounded_value
  end

  def add_listener(listener)
    @listeners.append(listener)
  end
end

bank = Banco.new
account1 = CuentaCorriente.new(100_000)
account2 = ForeignAccount.new(1000)
adapter = AccountAdapter.new(account2, 715.53)
adapter.add_listener(bank)

bank.transferir(account1, adapter, 50000)
puts("Account 1: #{account1.pesos} - Account 2: #{account2.dollars} - Bank: #{bank.cuenta_banco.pesos}")
