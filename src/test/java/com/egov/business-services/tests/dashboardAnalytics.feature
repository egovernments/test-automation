Feature: Business Services - Dashboard Analytics service tests

 Background:

     * def jsUtils = read('classpath:jsUtils.js')
     * def commonConstants = read('../../common-services/constants/genericConstants.yaml')
     * def dashboardServiceData = read('../constants/dashboardAnalytics.yaml')
     * def dashboardTestData = read('../requestPayload/dashboardAnalytics/chartAPI.json')
     * print dashboardTestData
     * def departmentId = commonConstants.invalidParameters.nullValue
     * def visualizationType = dashboardServiceData.parameters.visualizationType
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.totalComplaints
     * def startDate = getCurrentEpochTime()
     * def endDate = getCurrentEpochTime()
     * def interval = dashboardServiceData.parameters.interval

     
     * call read('../../common-services/pretests/egovMdmsPretest.feature@successSearchState')
     * def dashboardConfig = mdmsStateDashboard[0].MODULE_LEVEL
     * def modulePT = dashboardConfig[1].propertytax.filterKey
     * def moduleLevel = dashboardConfig[3].pgr.filterKey
     
     
@getDashboardConfig_01 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboard')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * assert dashboardResponseBody.responseData[0].visualizations.length != 0 


@getChartV2_metric_01 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * print dashboardResponseBody
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.metric


@getChartV2_piechart_02 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.complaintsByStatus
     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.pie


@getChartV2_bargraph_03 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.totalComplaintsbyStatus
     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.line


@getChartV2_multiplelinegraph_04 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.totalComplaintsbySource
     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.line


@getChartV2_filter_05 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def departmentId = dashboardServiceData.parameters.departmentId
     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.xpgrStatusByCatagory
     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.xtable
     * assert dashboardResponseBody.responseData.filter.length != 0 


@getChartV2_timeseries_06 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.eventDurationGraph
     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.line


@getChartV2_table_07 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.demandCollectionIndexUsageRevenue
     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.table


@getChartV2_drill_08 @positive @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def visualizationCode = dashboardServiceData.parameters.visualizationCode.wardDrillDown
     * def moduleLevel = modulePT
     * call read('../preTests/dashboardAnalyticsPretest.feature@successDashboardChart')
     * match dashboardResponseBody.statusInfo.statusMessage == dashboardServiceData.expected.successMessages.status
     * match dashboardResponseBody.responseData.visualizationCode == visualizationCode
     * match dashboardResponseBody.responseData.chartType == dashboardServiceData.expected.chartType.table


@getChartV2_invalidtenant_09 @negative @dashboardAnalytics
Scenario: Verify the API call to get config for the dashboard

     * def tenantId = commonConstants.invalidParameters.invalidTenantId
     * call read('../preTests/dashboardAnalyticsPretest.feature@errorDashboardChart')
     * match dashboardResponseBody.Errors[0].message == commonConstants.errorMessages.invalidTenantIdError