Feature: Version
  As a user of pry.js
  I want to be able to use the Version command
  So that I can see what version of pry.js I am using

  Scenario: I want to see the current pry.js version
    Given I have open the "fizzbuzz" example
    When I type in "version"
    Then The output should match "\d+\.\d+\.\d+"
