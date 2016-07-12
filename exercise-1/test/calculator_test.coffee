assert = require('chai').assert
calculator = require '../src/calculator.coffee'

describe 'calculator tests', ->
  describe 'summation method', ->
    it 'should give correct answer', ->
      assert.equal calculator.summation(5, 5, 5, 5), 20, '5+5+5+5 = 20'
      assert.equal calculator.summation(-1, -2, -3), -6, '(-1)+(-2)+(-3) = -6'
      assert.equal calculator.summation(2.41, 0.51, 5.38), 8.3,
        '2.41+0.51+5.38 = 8.3'
      assert.equal calculator.summation(-4, 3, -1, 12.5, -0.5), 10,
        '(-4)+3+(-1)+12.5+(-0.5) = 10'

  describe 'subtraction method', ->
    it 'should give correct answer', ->
      assert.equal calculator.subtraction(8, 6, 2), 0, '8-6-2 = 0'
      assert.equal calculator.subtraction(-12, -4, -3), -5, '-12-(-4)-(-3) = -5'
      assert.equal calculator.subtraction(6.05, 0.02, 0.03), 6,
        '6.05-0.02-0.03 = 6'
      assert.equal calculator.subtraction(-4.85, 0.15, 3), -8,
        '-4.85-0.15-3 = -8'

  describe 'multiplication method', ->
    it 'should give correct answer', ->
      assert.equal calculator.multiplication(5, 5, 5), 125, '5*5*5 = 125'
      assert.equal calculator.multiplication(-3, -3, -3), -27,
        '-3*(-3)*(-3) = -27'
      assert.equal calculator.multiplication(2.04, 3.06, 4.08).toFixed(2),
        25.47, '2.04*3.06*4.08 = 25.47'
      assert.equal calculator.multiplication(-2, -4.2, 3).toFixed(1), 25.2,
        '-2*(-4.2)*(-3) = 25.2'

  describe 'division method', ->
    it 'should give correct answer', ->
      assert.equal calculator.division(16, 4, 2, 2), 1, '16/4/2/2 = 1'
      assert.equal calculator.division(-50, -10, -5), -1, '-50/-10/-5 = -1'
      assert.equal calculator.division(12.4, 3.1, 2), 2, '-12.4/3.1/2 = 2'
      assert.equal calculator.division(40.4, -4.04, 2), -5,
        '40.4*(-4.04)*2 = -5'
