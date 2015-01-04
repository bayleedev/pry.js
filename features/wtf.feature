Feature: Wtf
  As a user of pry.js
  I want to be able to use the Wtf command
  So that I can see the last thrown exception

  Scenario: No caught exceptions
    Given I have open the "fizzbuzz" example
    When I type in "wtf"
    Then The output should match "No errors"

  Scenario: No caught exceptions
    Given I have open the "fizzbuzz" example
    When I type in "throw new Error('Foobar!');"
    And I type in "wtf"
    Then The output should match "Foobar!"
