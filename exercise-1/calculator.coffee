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
  numbers[0] / numbers[1]

window.onload = ->
  numbersDiv = document.createElement "div"
  numbersDiv.setAttribute "id", "numbersDiv"
  numberCount = 2

  for i in [1..2]
    numberN = document.createElement "input"
    numberN.setAttribute "type", "text"
    numberN.setAttribute "id", "number#{i}"
    numberN.setAttribute "placeholder", "Number #{i}"
    numberN.setAttribute "style", "margin-bottom: 5px; display: block"

    numbersDiv.appendChild numberN

  btnInsertNumber = document.createElement "button"
  btnInsertNumber.innerText = "Insert Number"
  btnInsertNumber.setAttribute "style", "margin-right: 3px;"
  btnInsertNumber.addEventListener "click", (e) ->
    newNumberCount = numberCount + 1
    newNumberN = document.createElement "input"
    newNumberN.setAttribute "type", "text"
    newNumberN.setAttribute "id", "number#{newNumberCount}"
    newNumberN.setAttribute "placeholder", "Number #{newNumberCount}"
    newNumberN.setAttribute "style", "margin-bottom: 5px; display: block"

    numbersDiv.appendChild newNumberN
    numberCount++;

  btnSum = document.createElement "button"
  btnSum.innerText = "+"
  btnSum.addEventListener "click", ->
    numbers = []

    for i in [1..numberCount]
      number = document.getElementById "number#{i}"
      numbers.push parseInt(number.value) if number.value and not isNaN parseInt(number.value)

    alert "Result=" + summation(numbers)

  btnSubt = document.createElement "button"
  btnSubt.innerText = "-"
  btnSubt.addEventListener "click", ->
    numbers = []

    for i in [1..numberCount]
      number = document.getElementById "number#{i}"
      numbers.push parseInt(number.value) if number.value and not isNaN parseInt(number.value)

    alert "Result=" + subtraction(numbers)

  btnMultip = document.createElement "button"
  btnMultip.innerText = "*"
  btnMultip.addEventListener "click", ->
    numbers = []

    for i in [1..numberCount]
      number = document.getElementById "number#{i}"
      numbers.push parseInt(number.value) if number.value and not isNaN parseInt(number.value)

    alert multiplication(numbers)

  btnDivis = document.createElement "button"
  btnDivis.innerText = "/"
  btnDivis.addEventListener "click", ->
    numbers = []

    for i in [1..numberCount]
      number = document.getElementById "number#{i}"
      numbers.push parseInt(number.value) if number.value and not isNaN parseInt(number.value)

    alert division(numbers)

  document.body.appendChild numbersDiv
  document.body.appendChild btnInsertNumber
  document.body.appendChild btnSum
  document.body.appendChild btnSubt
  document.body.appendChild btnMultip
  document.body.appendChild btnDivis
