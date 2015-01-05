Feature: Execute
  As a user of pry.js
  I want to be able to execute javascript in scope
  So I have a better idea of what my problem is

  Scenario: Looking at a variable
    Given I have open the "fizzbuzz" example
    When I type in "i"
    Then The output should match "1"

  Scenario: Setting the variable
    Given I have open the "fizzbuzz" example
    When I type in "i = 20"
    And I type in "i"
    Then The output should match "20"

  Scenario: Executes javascript
    Given I have open the "fizzbuzz" example
    When I type in "if (true) { 'js'; }"
    Then The output should be "js"

  Scenario: Executes coffeescript
    Given I have open the "fizzbuzz" example
    When I type in "mode"
    And I type in "if true then 'coffee'"
    Then The output should be "coffee"
