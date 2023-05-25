Feature: API Test Security Section

  @Test
  Scenario: Create token with valid username and password.
    #prepare request
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 200
    And print response

  #Scenario 1:
  Scenario: Validate Token with Invalid username
    #prepare request
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisorrrr","password": "tek_supervisor"}
    #Send request
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "User not found"

  #Scenario 2:
  Scenario: Validate Token with Invalid password
    #prepare request
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor123"}
    #Send request
    When method post
    #Validating response
    Then status 400
    And print response
    And assert response.errorMessage == "Password Not Matched"
    And assert response.httpStatus == "BAD_REQUEST"
