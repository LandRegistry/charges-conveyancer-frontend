@US63 @update_caselist_when_signed

Feature: Caselist is updated only when all borrowers have signed
    As a Lender/Conveyancer
    I want to know when all borrowers have signed
    So that I know I can continue with the process

Background:
    Given I have created a case and deed with two borrowers

@delete_test_data
Scenario: When no borrowers have signed the case status is still 'Deed created'
    When I navigate to the conveyancer frontend "/cases" page
    Then the status for the case is "Deed created"

@delete_test_data
Scenario: When one of two borrower has signed the case status is still 'Deed created'
    Given I navigate to the borrower frontend "/deed/search" page
    And I have signed my mortgage deed as "John Hughes"
    When I navigate to the conveyancer frontend "/cases" page
    Then the status for the case is "Deed created"

@delete_test_data
Scenario: When two of two borrowers have signed the case status is still 'Deed signed'
    Given I navigate to the borrower frontend "/deed/search" page
    And I have signed my mortgage deed as "John Hughes"
    And I navigate to the borrower frontend "/deed/search" page
    And I have signed my mortgage deed as "Susan Paula Hughes"
    When I navigate to the conveyancer frontend "/cases" page
    Then the status for the case is "Deed signed"
