BankAccount = require('./BankAccount.coffee').BankAccount

class SavingsAccount extends BankAccount
  constructor: (accNumber, accName, @interestRate) ->
    super accNumber, accName

  addInterest: ->
    interest = @balance * (@interestRate / 100)
    @deposit(interest)

module.exports.SavingsAccount = SavingsAccount
