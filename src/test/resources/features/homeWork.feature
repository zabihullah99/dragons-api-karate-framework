@Smoke
Feature: Get API Account

  #Scenario 9:
  #Endpoint = /api/accounts/get-account
  # For primeryPersonId <one of your accounts already created
  # Make sure email address is correct
  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify Valid token
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    # def step is to define new veriable in karate Framework
    * def generatedToken = response.token
    Given path "/api/accounts/get-account"
    And param primaryPersonId = 6692
    And header Authorization = "Bearer " + response.token
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == 6692
    And assert response.primaryPerson.email == "HusniaSidiqi@tekschool.com"
