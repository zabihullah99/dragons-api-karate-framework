@Regression
Feature: Token Verify Test

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Verify Valid URL
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "supervisor"
    When method get
    Then status 200
    And print response

  #Scenario 6:
  #Endpoint = /api/token/verify
  #wrong username should send as parameter
  # response HTTP Status Code 400
  # and error message "Worng UserName send along with Token"
  Scenario: Negative test validate token verify with wrong username
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = response.token
    And param username = "super"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Wrong Username send along with Token"

  #Scenario 7:
  Scenario: Negative test varify Token with invalid token and valid username
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    Given path "/api/token/verify"
    And param token = "wrong token"
    And param username = "supervisor"
    When method get
    Then status 400
    And print response
    And assert response.errorMessage == "Token Expired or Invalid Token"
