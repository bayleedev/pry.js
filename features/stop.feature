Feature: Stop
  As a user of pry.js
  I want to continue the execution of the code
  So I can see the side effects of my interactions

  Scenario: Skipping the iteration goes to the next variable
    Given I have open the "fizzbuzz" example
    When I type in "stop"
    And I type in "i"
    Then The output should match "2"
