generateRandomAccNumber = ->
  max = 99999999
  min = 10000000
  Math.floor(Math.random() * (max - min + 1)) + min

bankAcc = new BankAccount generateRandomAccNumber(), 'Eren Hatırnaz'
bankAcc.deposit 150
bankAcc.withDraw 22
bankAcc.deposit 10
bankAcc.withDraw 500
console.log bankAcc

savingAcc = new SavingAccount generateRandomAccNumber(), 'Eren Hatırnaz', 25
savingAcc.deposit 50
savingAcc.addInterest()
console.log savingAcc
