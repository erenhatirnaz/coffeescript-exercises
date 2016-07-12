class BankAccount
  constructor: (@number, @name) ->
    @balance = 0

  deposit: (amount) ->
    if amount <= 0
      throw new Error 'The amount have to be bigger than zero!'
    @balance += amount if amount > 0

  withDraw: (amount) ->
    if amount > @balance
      throw new Error 'The amount have to be less than the balance!'
    @balance -= amount if amount < @balance

module.exports.BankAccount =  BankAccount
