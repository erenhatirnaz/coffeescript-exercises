summation = (numbers...) ->
  result = 0
  result += n for n in numbers
  result

subtraction = (numbers...) ->
  result = numbers[0]
  result -= n for n in numbers[1..numbers.lenght]
  result

multiplication = (numbers...) ->
  result = 1
  result *= n for n in numbers
  result

division = (numbers...) ->
  result = numbers[0]
  result /= n for n in numbers[1..numbers.lenght]
  result

module.exports = { summation, subtraction, multiplication, division }
