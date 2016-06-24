class SavingAccount extends BankAccount
  constructor: (accNumber, accName, @interestRate) ->
    super accNumber, accName

  addInterest: ->
    interest = @balance * (@interestRate / 100)
    @deposit(interest)
