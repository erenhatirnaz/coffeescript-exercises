summation = (numbers) ->
  result = 0
  numbers.forEach (n) -> result += n
  result

subtraction = (numbers) ->
  result = numbers[0]
  numbers[1..numbers.lenght].forEach (n) -> result -= n
  result

multiplication = (numbers) ->
  result = 1
  numbers.forEach (n) -> result *= n
  result

division = (numbers) ->
  result = numbers[0]
  numbers[1..numbers.lenght].forEach (n) -> result /= n
  result

getNumbers = ->
  numbers = []
  Array::slice.call(document.getElementsByTagName('input')).forEach (number) ->
    numbers.push parseInt(number.value) if number.value and
                                           not isNaN parseInt(number.value)
  numbers

numberCount = 2

numbersDiv = document.getElementById 'numbersDiv'

btnInsertNumber = document.getElementById 'btnInsertNumber'
btnInsertNumber.addEventListener 'click', ->
  newNumberCount = ++numberCount
  txtNewNumber = document.createElement 'input'
  txtNewNumber.setAttribute 'type', 'text'
  txtNewNumber.setAttribute 'id', "number#{newNumberCount}"
  txtNewNumber.setAttribute 'placeholder', "Number #{newNumberCount}"

  numbersDiv.appendChild txtNewNumber

btnSummation = document.getElementById 'btnSummation'
btnSummation.addEventListener 'click', ->
  numbers = getNumbers()

  alert "Result: #{summation(numbers)}"

btnSubtraction = document.getElementById 'btnSubtraction'
btnSubtraction.addEventListener 'click', ->
  numbers = getNumbers()

  alert "Result: #{subtraction(numbers)}"

btnMultiplication = document.getElementById 'btnMultiplication'
btnMultiplication.addEventListener 'click', ->
  numbers = getNumbers()

  alert "Result: #{multiplication(numbers)}"

btnDivision = document.getElementById 'btnDivision'
btnDivision.addEventListener 'click', ->
  numbers = getNumbers()

  alert "Result: #{division(numbers)}"
