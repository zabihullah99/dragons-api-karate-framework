@Regression
Feature: Account Testing

  Background: Setup Test Generate Token
    * def tokenFeature = callonce read('GenerateToken.feature')
    * def token = tokenFeature.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: End to End Account testing
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def autoEmail = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + token
    And request
      """
      { 
      "email": "#(autoEmail)",
      		"firstName": "zabih",
      		"lastName": "Ahmadi","title": "Mr.",
      		"gender": "Male","maritalStatus": "Single",
      		"employmentStatus": "student",
      		"dateOfBirth": "1990-07-17"
      		} 
      """
    When method post
    Then status 201
    Then print response
    And assert response.email == autoEmail
    * def generatedAccountId = response.id
    #address
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + token
    And request
      """
      {
      
      "addressType": "House",
      "addressLine1": "1535 alfred street",
      "city": "Yuba",
      "state": "CA",
      "postalCode": "22451",
      "countryCode": "011",
      "current": true
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.addressType == "House"
    #add car
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + token
    * def autoPlateNum = dataGenerator.getNumberPlate()
    And request
      """
      {
      
      "make": "Audi",
      "model": "A6",
      "year": "2023",
      "licensePlate": "#(autoPlateNum )"
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.licensePlate == autoPlateNum
    #add phone
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + token
    * def autoPhoneNum = dataGenerator.getPhoneNumber()
    And request
      """
      {      
      "phoneNumber": "#(autoPhoneNum)",
      "phoneExtension": "205",
      "phoneTime": "Morning",
      "phoneType": "cell"
      }
      """
    When method post
    Then status 201
    Then print response
    And assert response.phoneNumber == autoPhoneNum
    #Get account
    Given path "/api/accounts/get-account"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + token
    When method get
    Then status 200
    And print response
