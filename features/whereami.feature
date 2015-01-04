Feature: Whereami
  As a user of pry.js
  I want to be able to use the Whereami command
  So that I can see exactly where I am

  Scenario: The pointer should be on the pry statement
    Given I have open the "fizzbuzz" example
    When I type in "whereami"
    Then The output should match "=>.*pry.it"

  Scenario: Should get 2 lines before and 1 after
    Given I have open the "fizzbuzz" example
    When I type in "whereami 2 1"
    Then The output should be "4" lines

  Scenario: Should get 2 lines before and after
    Given I have open the "fizzbuzz" example
    When I type in "whereami 2 2"
    Then The output should be "5" lines
