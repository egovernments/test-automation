package com.egov.utils;

import java.util.HashMap;

import io.restassured.RestAssured;
import io.restassured.http.Headers;
import io.restassured.response.Response;

public class apiHelper implements BaseTests {
	
    public Response triggerFormalPOST(String url, String request, Headers headers) {
        System.out.println("Endpoint:\t" + url);
        System.out.println("Request:\t" + request);
        Response iresp = RestAssured
                .given()
                .headers(headers)
                .relaxedHTTPSValidation()
                .body(request)
                .when()
                .post(url);

        Response resp = iresp.then()
                .extract()
                .response();
        return resp;

    }
    
    public Response triggerPOST(String url, Headers headers, HashMap<String, String> formprm) {
        System.out.println("Endpoint:\t" + url);
        System.out.println("Request:\t" + formprm);
        Response iresp = RestAssured
                .given()
                .headers(headers)
                .relaxedHTTPSValidation()
                .contentType("application/x-www-form-urlencoded; charset=UTF-8")
                .formParams(formprm)
                .when()
                .post(url);

        Response resp = iresp.then()
                .extract()
                .response();
        return resp;

    }
    
	public String triggerPATCH(String url, String request, Headers headers) {
        System.out.println("Endpoint:\t" + url);
        System.out.println("Request:\t" + request);
        Response iresp = RestAssured
                .given()
                .headers(headers)
                .relaxedHTTPSValidation()
                .proxy("127.0.0.1", 9090)
                .body(request)
                .when()
                .patch(url);

        String resp = iresp.then()
                .extract()
                .response()
                .prettyPrint();

        int irespCode = iresp
                .then().extract().statusCode();
        resp = String.valueOf(irespCode) + "Response:" + resp;
        System.out.println(resp);
        return resp;

    }
	
	public static String getValueFromJson(Response response, String nodePath) {
		String value = null;
		try {
			value =response.jsonPath().getString(nodePath);
		}catch (Exception e) {
		}
		return value; 
	}

}
