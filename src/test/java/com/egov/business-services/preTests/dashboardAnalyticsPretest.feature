Feature: Dashboard Analytics API call 

Background:

  * def jsUtils = read('classpath:jsUtils.js')
  	# calling dashboard Json
  * def dashboardRequest = read('../requestPayload/dashboardAnalytics/dashboard.json')
  * configure headers = read('classpath:websCommonHeaders.js')

@successDashboard
Scenario: success dashboard

  Given url configHomeUrl 
  And header auth-token = authToken
  When method get
  Then status 200
  And def dashboardResponseHeader = responseHeaders
  And def dashboardResponseBody = response

@successDashboardChart
Scenario: success dashboard

  Given url getChartUrl 
  And request dashboardRequest
  * print dashboardRequest
  When method post
  Then status 200
  And def dashboardResponseHeader = responseHeaders
  And def dashboardResponseBody = response

@errorDashboardChart
Scenario: success dashboard

  Given url getChartUrl 
  And request dashboardRequest
  When method post
  Then status 403
  And def dashboardResponseHeader = responseHeaders
  And def dashboardResponseBody = response