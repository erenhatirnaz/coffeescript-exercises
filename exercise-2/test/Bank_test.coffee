assert = require('chai').assert

BankAccount = require('../src/BankAccount.coffee').BankAccount
SavingAccount = require('../src/SavingsAccount.coffee').SavingsAccount

describe 'basic bank system tests', ->
  testAccNumber = 12345678
  testAccName = 'Eren Hatirnaz'
  account = null

  describe 'bank account', ->
    beforeEach ->
      account = new BankAccount testAccNumber, testAccName

    it 'constructor should work correctly', ->
      assert.equal account.number, testAccNumber
      assert.equal account.name, testAccName
      assert.equal account.balance, 0
      assert.instanceOf account, BankAccount

    describe 'deposit method', ->
      it 'shouldn\'t throw an error if the amount is bigger than zero', ->
        assert.doesNotThrow (-> account.deposit(15)), Error,
          'The amount have to be bigger than zero!'
        assert.equal account.balance, 15

      it 'should throw an error if the amount is less than zero', ->
        assert.throws (-> account.deposit(-1)), Error,
          'The amount have to be bigger than zero!'

    describe 'withDraw method', ->
      it 'shouldn\'t throw an error if the amount is less than the balance', ->
        account.deposit 150
        assert.doesNotThrow (-> account.withDraw(50)), Error,
          'The amount have to be less than the balance!'
        assert.equal account.balance, 100

      it 'should throw an error if the amount is less than the balance', ->
        account.deposit 150
        assert.throws (-> account.withDraw(200)), Error,
          'The amount have to be less than the balance!'

  describe 'saving account', ->
    testInterestRate = 25

    beforeEach ->
      account = new SavingAccount testAccNumber, testAccName, testInterestRate

    it 'constructor should work correctly', ->
      assert.equal account.interestRate, testInterestRate
      assert.instanceOf account, BankAccount
      assert.instanceOf account, SavingAccount

    it 'addInterest method should work', ->
      account.deposit 150
      account.addInterest()
      assert.equal account.balance, 187.5
