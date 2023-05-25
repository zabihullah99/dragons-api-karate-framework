@Regression
Feature: Create Account and delete Test

  Background: API Test Setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      { "email": "SunriseTTTT@postman.com",
      		"firstName": "HusniaS",
      		"lastName": "sidiqi","title": "Ms.",
      		"gender": "FEMALE","maritalStatus": "MARRIED",
      		"employmentStatus": "student",
      		"dateOfBirth": "1988-07-17"
      		} 
      """
    When method post
    Then status 201
    Then print response
    And assert response.email == "SunriseTTTT@postman.com"
    #Delete Account
    Given path "api/accounts/delete-account"
    And header Authorization = "Bearer " + generatedToken
    And param primaryPersonId = response.id
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
