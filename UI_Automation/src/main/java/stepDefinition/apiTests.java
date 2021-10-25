package stepDefinition;

import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import cucumber.api.java.en.And;
import io.restassured.http.Header;
import io.restassured.http.Headers;
import io.restassured.response.Response;
import utilities.BaseTests;
import utilities.commonUtils;

public class apiTests implements BaseTests {
	
	commonUtils util = new commonUtils();

	@And("^Trigger POST api to get the eGov AuthToken")
	public void eGov_Auth() throws IOException {
		// Use the space

		String url = "https://qa.digit.org/user/oauth/token";
		List<Header> headerlist = new ArrayList<Header>();
		headerlist.add(new Header("authorization", "Basic ZWdvdi11c2VyLWNsaWVudDo="));
		headerlist.add(new Header("Content-Type", "application/x-www-form-urlencoded"));
		Headers headers = new Headers(headerlist);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("username", "EMPAUTO");
		map.put("password", "eGov@123");
		map.put("grant_type", "password");
		map.put("scope", "read");
		map.put("tenantId", "pb.amritsar");
		map.put("userType", "EMPLOYEE");

		Response response = eGovApi.triggerPOST(url, headers, map);
		 String authT = eGovApi.getValueFromJson(response, "access_token");
	        eGovOp.setRuntimeProps("eGovToken", authT);
		
		System.out.println("Response Body:\t" + response.prettyPrint());

	}

	@And("^Trigger Search API and extract Username, Mobile Number and Guardian for verification with tenant as \"(.*)\"$")
	public void eGov_Search(String tenant) throws IOException, ParseException {
		// Use the space
		String propId = eGovOp.getRuntimeProps("expected_UniqueID");
		String url = "https://qa.digit.org/property-services/property/_search?tenantId=" + tenant + "&propertyIds="
				+ propId;
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(new FileReader(
				"/Users/apple/eclipse-workspace/eGovUIAutomation/src/test/java/features/searchProp.json"));
		JSONObject jsonObject = (JSONObject) obj;
		String req = jsonObject.toJSONString();
		req = req.replace("TOKEN_VALUE", eGovOp.getRuntimeProps("eGovToken"));

		List<Header> headerlist = new ArrayList<Header>();
		headerlist.add(new Header("Content-Type", "application/json;charset=UTF-8"));
		Headers headers = new Headers(headerlist);

		System.out.println("URL:\t" + url);
		System.out.println("Headers:\t" + headers);
		System.out.println("Request:\t" + req);

		Response searchResponse = eGovApi.triggerFormalPOST(url, req, headers);
		System.out.println("RESPONSE:\t"+searchResponse.prettyPrint());
		String eName = eGovApi.getValueFromJson(searchResponse, "Properties[0].owners[0].name");
		String eMobile = eGovApi.getValueFromJson(searchResponse, "Properties[0].owners[0].mobileNumber");
		String eGuardn = eGovApi.getValueFromJson(searchResponse, "Properties[0].owners[0].fatherOrHusbandName");
		String epropId = eGovApi.getValueFromJson(searchResponse, "Properties[0].propertyId");
		
		eGovOp.setRuntimeProps("eName", eName);
		eGovOp.setRuntimeProps("eMobile", eMobile);
		eGovOp.setRuntimeProps("eGuardn", eGuardn);
		eGovOp.setRuntimeProps("eUniquePropID", epropId);
		
		//Assertion!
		util.assertValues(eGovOp.getRuntimeProps("eName"), eGovOp.getRuntimeProps("expected_GovName"), "Validate the User Name");
		util.assertValues(eGovOp.getRuntimeProps("eMobile"), eGovOp.getRuntimeProps("expected_GovMobile"), "Validate the User Mobile");
		util.assertValues(eGovOp.getRuntimeProps("eGuardn"), eGovOp.getRuntimeProps("expected_GovGaurdian"), "Validate the User Guardian");
		util.assertValues(eGovOp.getRuntimeProps("eUniquePropID"), eGovOp.getRuntimeProps("expected_UniqueID"), "Validate the User Guardian");
	}

}
