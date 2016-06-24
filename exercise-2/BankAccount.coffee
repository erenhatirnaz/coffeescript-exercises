class BankAccount
  constructor: (@accountNumber, @accountName) ->
    @balance = 0

  deposit: (amount) ->
    @balance += amount if amount > 0

  withDraw: (amount) ->
    @balance -= amount if amount < @balance
