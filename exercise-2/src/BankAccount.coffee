Module = require('./Module.coffee').Module

class BankAccount extends Module
  constructor: (attrs) ->
    @balance = 0
    @activityLog = new Array
    if attrs? then @[key] = value for key, value of attrs when value?

  deposit: (amount) ->
    throw new Error 'The amount have to be bigger than zero!' if amount <= 0
    @balance += amount
    @activityLog.push {
      type: 'deposit'
      amount: amount
      currentBalance: @balance,
      date: new Date()
    }

  withDraw: (amount) ->
    throw new Error 'There is not enough balance!' if amount > @balance
    @balance -= amount
    @activityLog.push {
      type: 'withdraw'
      amount: amount
      currentBalance: @balance
      date: new Date()
    }

  send: (targetAcc, amount) ->
    if typeof targetAcc is 'number' then targetAcc = BankAccount.find targetAcc
    throw new Error 'Account not found!' if not targetAcc?
    throw new Error 'There is not enough balance!' if amount > @balance
    throw new Error 'The amount have to be bigger than zero!' if amount <= 0
    @balance -= amount
    @activityLog.push {
      type: 'transfer'
      amount: amount
      currentBalance: @balance
      targetAccount: targetAcc
      date: new Date()
    }
    @save()
    targetAcc.balance += amount
    targetAcc.activityLog.push {
      type: 'transfer'
      amount: amount
      currentBalance: targetAcc.balance
      sourceAccount: @
      date: new Date()
    }
    targetAcc.save()

module.exports.BankAccount =  BankAccount
