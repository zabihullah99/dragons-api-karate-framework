@Regression
Feature: get All Accounts

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Test get All Accounts
    Given path "/api/accounts/get-all-accounts"
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
   