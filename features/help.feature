Feature: Help
  As a user of pry.js
  I want to be ask for help
  So I can better use the tools provided

  Scenario: Getting all the help
    Given I have open the "fizzbuzz" example
    When I type in "help"
    Then The output should match "whereami"
    And The output should match "help"

  Scenario: Getting all the help with extra space
    Given I have open the "fizzbuzz" example
    When I type in "help "
    Then The output should match "whereami"
    And The output should match "help"

  Scenario: Getting specific help
    Given I have open the "fizzbuzz" example
    When I type in "help help"
    Then The output should not match "whereami"
    And The output should match "help"
    And The output should be "2" lines
