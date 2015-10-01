Feature: Execute
  As a user of pry.js
  I want to be able to execute javascript in scope
  So I have a better idea of what my problem is

  Scenario: Looking at a variable
    Given I have open the "fizzbuzz" example
    When I type in "i"
    Then The output should match "1"

  Scenario: Have the same scope
    Given I have open the "fizzbuzz" example
    When I type in "this.bar()"
    Then The output should match "10"

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

  Scenario: Executes multiline javascript
    Given I have open the "fizzbuzz" example
    When I type in ctrl+v
    And I type in "if (true) {"
    And I type in "'hello world';"
    And I type in "}"
    And I type in ""
    Then The output should be "hello world"

  Scenario: Executes multiline coffeescript
    Given I have open the "fizzbuzz" example
    When I type in "mode"
    And I type in ctrl+v
    And I type in "{"
    And I type in "foo: 'hello world'"
    And I type in "bar: 'baz'"
    And I type in "}.foo"
    And I type in ""
    Then The output should be "hello world"

  Scenario: Should not overwrite global variables in Coffee
    Given I have open the "fizzbuzz" example
    When I type in "mode"
    And I type in "i = i || 20"
    Then The output should match "1"

  Scenario: Getting an error
    Given I have open the "fizzbuzz" example
    When I type in "i_do_not_exist"
    Then The output should match "is not defined"
