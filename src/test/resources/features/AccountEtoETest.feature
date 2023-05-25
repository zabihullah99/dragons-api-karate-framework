@Regression
Feature: End-to-End Account Testsing.

  Background: API Test Setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End-to-End Account Creation Testing
      * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Husnia",
      "lastName": "Sidiqi",
      "title": "Ms.",
      "gender": "FEMALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Software Tester",
      "dateOfBirth": "1988-07-17"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    And assert response.firstName == "Husnia"
    * def generatedAccountId = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "9876 Some Street",
      "city": "Falls Church",
      "state": "Virginia",
      "postalCode": "22135",
      "countryCode": "",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.addressLine1 == "9876 Some Street"
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    * def autoPhoneNum = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(autoPhoneNum)",
      "phoneExtension": "",
      "phoneTime": "Morning",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == autoPhoneNum
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
      * def autoPlateNum = dataGenerator.getNumberPlate()
    And request
      """
      {
      "make": "Ford",
      "model": "Mustang",
      "year": "2020",
      "licensePlate": "#(autoPlateNum)"
      }
      """
    When method post
    And status 201
    And print response
    And assert response.licensePlate == autoPlateNum
    Given path "/api/accounts/get-account"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == generatedAccountId