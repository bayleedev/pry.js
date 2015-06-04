Feature: Underscore
  As a user of pry.js
  I want to be able to use the last result
  So I can better use the tools provided

  Scenario: Using dynamic underscore variable
    Given I have open the "fizzbuzz" example
    When I type in "42"
    When I type in "_"
    Then The output should match "42"
