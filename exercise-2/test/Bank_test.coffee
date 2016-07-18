assert = require('chai').assert

Bank = require('../src/Bank.coffee').Bank
BankAccount = require('../src/BankAccount.coffee').BankAccount

Bank.init 'Bank Test'

describe 'basic bank system tests', ->
  testAccountInfo = {
    name: 'Eren Hatirnaz'
    number: 12345678
  }
  account = null

  beforeEach ->
    account = new BankAccount testAccountInfo

  describe 'bank account class', ->
    it 'constructor should work smoothly', ->
      assert.property account, 'activityLog'

      assert.equal account.number, testAccountInfo.number
      assert.equal account.name, testAccountInfo.name
      assert.equal account.balance, 0

      assert.isArray account.activityLog
      assert.instanceOf account, BankAccount

    describe 'deposit method', ->
      it 'should work smoothly if the amount is a positive number', ->
        assert.doesNotThrow (-> account.deposit(150)), Error,
          'The amount have to be bigger than zero!'
        assert.equal account.balance, 150
        assert.lengthOf account.activityLog, 1

        log = account.activityLog[0]
        assert.equal log.type, 'deposit'
        assert.equal log.amount, 150
        assert.equal log.currentBalance, 150

      it 'should throw an error if the amount is a negative number', ->
        assert.throws (-> account.deposit(-1)), Error,
          'The amount have to be bigger than zero!'

    describe 'withDraw method', ->
      it 'should work smoothly if have enough balance', ->
        account.deposit 150
        assert.doesNotThrow (-> account.withDraw(50)), Error,
          'There is not enough balance!'
        assert.equal account.balance, 100
        assert.lengthOf account.activityLog, 2

        log = account.activityLog[1]
        assert.equal log.type, 'withdraw'
        assert.equal log.amount, 50
        assert.equal log.currentBalance, 100


      it 'should throw an error if have not enough balance', ->
        account.deposit 150
        assert.throws (-> account.withDraw(200)), Error,
          'There is not enough balance!'

    describe 'send method', ->
      account2 = null

      beforeEach ->
        account.deposit 25
        account.save()
        account2 = new BankAccount {
          number: 87654321
          name: 'Person'
        }
        account2.save()

      afterEach ->
        account.remove()
        account2.remove()

      it 'should work smoothly', ->
        account.send account2, 15

        assert.equal account.balance, 10
        assert.lengthOf account.activityLog, 2
        log = account.activityLog[1]
        assert.equal log.type, 'transfer'
        assert.equal log.amount, 15
        assert.equal log.currentBalance, 10
        assert.equal log.targetAccount, account2
        assert.property log, 'date'

        assert.equal account2.balance, 15
        assert.lengthOf account2.activityLog, 1
        log2 = account2.activityLog[0]
        assert.equal log2.type, 'transfer'
        assert.equal log2.amount, 15
        assert.equal log2.currentBalance, 15
        assert.equal log2.sourceAccount, account
        assert.property log2, 'date'

      it 'should throw an error if account is not found', ->
        assert.throws (-> account.send(11111, 15)), Error, 'Account not found!'

      it 'should throw an error if have not enough balance', ->
        assert.throws (-> account.send(account2, 50)), Error,
          'There is not enough balance!'

      it 'should throw an error if the amount is a negative number', ->
        assert.throws (-> account.send(account2, -10)), Error,
          'The amount have to be bigger than zero!'

    describe 'ORM tests', ->
      it 'remove method should work smoothly', ->
        account.save()
        account.remove()
        assert.isNull BankAccount.find(account.number)

      describe 'save method', ->
        it 'should work smoothly', ->
          account.save()
          assert.equal account.number, testAccountInfo.number
          assert.equal account.name, testAccountInfo.name
          assert.equal account.balance, 0

          assert.property account, 'meta'
          assert.deepProperty account, 'meta.created'
          assert.deepProperty account, 'meta.revision'

        it 'should update the bank account if account is already exist', ->
          acc = BankAccount.find account.number
          acc.name = 'someone'
          acc.save()
          assert.equal acc.name, 'someone'
          assert.notEqual acc.name, account.name
          assert.deepProperty acc, 'meta.updated'

      describe 'find method', ->
        it 'should return a bank account if number is correct', ->
          acc = BankAccount.find account.number
          assert.isNotNull acc
          assert.property acc, 'name'
          assert.property acc, 'number'
          assert.property acc, 'meta'
          assert.deepProperty acc, 'meta.created'
          assert.instanceOf acc, BankAccount

        it 'should throw an error if number is wrong', ->
          assert.isNull BankAccount.find(111111)
