package com.egov.utils;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.aventstack.extentreports.ExtentTest;
import com.aventstack.extentreports.markuputils.CodeLanguage;
import com.aventstack.extentreports.markuputils.ExtentColor;
import com.aventstack.extentreports.markuputils.MarkupHelper;
import com.intuit.karate.Results;
import com.intuit.karate.core.ExecutionContext;
import com.intuit.karate.core.ExecutionHook;
import com.intuit.karate.core.Feature;
import com.intuit.karate.core.FeatureResult;
import com.intuit.karate.core.PerfEvent;
import com.intuit.karate.core.Scenario;
import com.intuit.karate.core.ScenarioContext;
import com.intuit.karate.core.ScenarioResult;
import com.intuit.karate.core.Step;
import com.intuit.karate.core.StepResult;
import com.intuit.karate.core.Tag;
import com.intuit.karate.http.HttpRequestBuilder;

public class ExtentReportHook implements ExecutionHook {
	private static ExtentTest scenarioTest;
    String Status, Error;
    String logUrl, logMethod, logRequestHeaders, logRequestBody, logResponseBody;
    ArrayList<HashMap<String, String>> scenarioSteps;
    
    @Override
    public void beforeAll(Results results) {
        ExtentManager.createReport();

    }
    
    @Override
    public boolean beforeFeature(Feature feature, ExecutionContext context) {
        return true;
    }

    @Override
    public boolean beforeScenario(Scenario scenario, ScenarioContext context) {
		return true;
    }

    @Override
    public boolean beforeStep(Step step, ScenarioContext context) {
        return true;
    }

    @Override
    public void afterStep(StepResult result, ScenarioContext context) {
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
    public void afterScenario(ScenarioResult result, ScenarioContext context) {
        try{
            if (result.isFailed()) {
                Status = "FAILED";
                }else{
                    Status = "PASSED";
                }
                if (result.getError() == null) {
                    Error = "No Error";
                }else{
                    Error = result.getError().getMessage();
                    if(Error.contains("url: http")) {
                    	Error = Error.substring(0, Error.indexOf("url: http"));
                    }
                }
            try {
				logUrl = context.getRequestBuilder().getUrlAndPath();
				logMethod = context.getPrevRequest().getMethod();
				logRequestHeaders = context.getPrevRequest().getHeaders().toString();
				try{
					logRequestBody = new String(context.getPrevRequest().getBody());
				}catch(Exception e2){}
				logResponseBody = new String(context.getPrevResponse().getBody());
			} catch (Exception e1) {}
            List<String> scenarioTags = new ArrayList<String>();
			for(Tag tag: result.getScenario().getTags()){
			    scenarioTags.add(tag.toString());
			}
			List<String> propertyTags = Arrays.asList(System.getProperty("tags").split(","));
			List<String> matchingTags = new ArrayList<String>(scenarioTags);
			matchingTags.retainAll(propertyTags);
			String tags = "";
			for(String tag: scenarioTags) {
				tags += ", " + tag;
			}
			tags = tags.substring(1,  tags.length());
            if(matchingTags.size() > 0){
            	scenarioTest = ExtentManager.getInstance().createTest("<b>SCENARIO :   </b>" + result.getScenario().getName());
            	scenarioTest.info("<b>FEATURE :   </b>" + result.getScenario().getFeature().getName());
            	scenarioTest.assignCategory(result.getScenario().getFeature().getName());
            	scenarioTest.info("<b>TAGS :   </b>" + tags);
                if (Status == "FAILED") {
                    scenarioTest.fail(MarkupHelper.createLabel("<b>STATUS :   </b>" + Status, ExtentColor.RED));
                    scenarioTest.fail("<b>ERROR :   </b>" + Error);
                    scenarioTest.fail("<b>URL :   </b>" + logUrl);
                    scenarioTest.fail("<b>METHOD :   </b>" + logMethod);
                    scenarioTest.fail("<b>REQUEST HEADERS :   </b>" + logRequestHeaders);
                    try{
                        scenarioTest.fail(MarkupHelper.createLabel("<b>REQUEST BODY :</b>", ExtentColor.RED));
                        scenarioTest.fail(MarkupHelper.createCodeBlock(logRequestBody, CodeLanguage.JSON));
                    }catch(Exception e3){}
                        scenarioTest.fail(MarkupHelper.createLabel("<b>RESPONSE BODY :</b>", ExtentColor.RED));
                        scenarioTest.fail(MarkupHelper.createCodeBlock(logResponseBody, CodeLanguage.JSON));
                }else{
                    scenarioTest.pass(MarkupHelper.createLabel("<b>STATUS :   </b>" + Status, ExtentColor.GREEN));
                }
                List<Map> backGroundSteps = (List<Map>) result.backgroundToMap().get("steps");
                ExtentTest backgroundNode = scenarioTest.createNode("BACKGROUND:");
    			for( Map step: backGroundSteps) {
//    				ExtentTest level1Node = null, level2Node = null;
    				String stepText = step.get("keyword").toString() + " " + step.get("name").toString();
    				Map resultStatus = (Map) step.get("result");
    				if(resultStatus.get("status").equals("failed")) {
    					backgroundNode.fail(stepText);
    				}else if(resultStatus.get("status").equals("skipped")) {
    					backgroundNode.skip(stepText);
    				}else {
    					backgroundNode.pass(stepText);
    				}
    				
    			}
    			List<Map> scenarioSteps = (List<Map>) result.toMap().get("steps");
    			ExtentTest scenarioStepsNode = scenarioTest.createNode("SCENARIO STEPS:");
    			for( Map step: scenarioSteps) {
    				String stepText = step.get("keyword").toString() + " " + step.get("name").toString();
    				Map resultStatus = (Map) step.get("result");
    				if(resultStatus.get("status").equals("failed")) {
    					scenarioStepsNode.fail(stepText);
    				}else if(resultStatus.get("status").equals("skipped")) {
    					scenarioStepsNode.skip(stepText);
    				}else {
    					scenarioStepsNode.pass(stepText);
    				}
    			}
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    public void afterFeature(FeatureResult result, ExecutionContext context) {
    }

    @Override
    public void afterAll(Results results) {
        ExtentManager.getInstance().flush();
    }

    @Override
    public String getPerfEventName(HttpRequestBuilder req, ScenarioContext context) {
        return null;
    }

    @Override
    public void reportPerfEvent(PerfEvent event) {
    }

}