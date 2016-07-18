BankAccount = require('./BankAccount.coffee').BankAccount

loki = require 'lokijs'

init = (bankName) ->
  bankName.toLowerCase().replace ' ', '-'

  db = new loki bankName
  accounts = db.addCollection 'accounts', { unique: [ 'number' ] }

  ORM =
    find: (accNumber) ->
      accounts.findOne({ number: accNumber }) || null

    extended: ->
      @include
        remove: ->
          accounts.remove @

        save: ->
          if BankAccount.find(@number)
            accounts.update @
          else
            accounts.insert @

  BankAccount.extend ORM

module.exports.Bank = { init }
