Feature: Play
  As a user of pry.js
  I want to play existing lines of code in context
  So I can see the side effects of my interactions

  Scenario: Play a single line
    Given I have open the "fizzbuzz" example
    When I type in "i = 15"
    When I type in "play 10"
    And I type in "output"
    Then The output should match "Fizz"

  Scenario: Play multiple lines
    Given I have open the "fizzbuzz" example
    When I type in "i = 15"
    And I type in "play 10 11"
    And I type in "output"
    Then The output should match "FizzBuzz"
