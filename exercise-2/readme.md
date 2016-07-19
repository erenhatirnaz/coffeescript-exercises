# Exercise 2
* **Exercise name:** Advanced Bank System
* **Description:** Bank account is a normal account. The user can deposit and
withdraw the money. Bank account has orm features. bank account have orm
features. So, you can call `acc = BankAccount.find(12345678)` or 
```coffeescript
account = new BankAccount {
  number: 12345678
  name: 'Person'
}
account.save() # This method inserts the bank account into in-memory database.
account.remove() # This method removes this bank account from in-memory database.
```
* **Source file(s):**
  * [Module.coffee](./src/Module.coffee): This class have two static functions,
  `@extend()` and  `@include()`, which we can use for extending the class with
  static and instance properties.
  * [BankAccount.coffee](./src/BankAccount.coffee): `BankAccount` class
  * [Bank.coffee](./src/Bank.coffee): Those file contains `init` method. `init`
  method creates a in-memory database and adds orm features to BankAccount class. 
* **Test file(s):**
  * [Bank_test.coffee](./test/Bank_test.coffee): All classes are being tested in
  this file.
* **What have I learned with this exercise?:**
  * Define a class and adding constructor method
  * Inheritance and Super
  * Extending Classes
