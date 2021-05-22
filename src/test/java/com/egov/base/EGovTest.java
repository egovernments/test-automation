package com.egov.base;

import static org.junit.Assert.assertTrue;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.yaml.snakeyaml.Yaml;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import net.minidev.json.JSONValue;

@KarateOptions(features = {"classpath:com/egov"},
	tags = {"@reports,@searchMdms,@location,@localization,@userOtp,@eGovUser,@accessControl," +
			"@hrms,@collectionServices,@billingServiceDemand,@pdfservice,@billingServiceBill," +
			"@idGenerate,@egovWorkflowProcess,@fileStore,@pgservices"})

public class EGovTest {
	static String karateOutputPath = "target/surefire-reports";
	@BeforeClass
	public static void before() {
		
	}

	@Test
	public void testParallel() {
		
		Results stats = Runner.parallel(getClass(), 1, karateOutputPath);
		
		assertTrue("there are scenario failures", stats.getFailCount() == 0);
	}

	@AfterClass
	public static void after(){
		generateReport(karateOutputPath);
	}

	private static void generateReport(String karateOutputPath) {

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		Date date = new Date();
		String currentDate = dateFormat.format(date);

		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
		List<String> jsonPaths = new ArrayList(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		
		// To Store reports in other location in system
		//Configuration config = new Configuration(new File("C:/Users/Toshiba/Documents/KarateResults/" + currentDate), "eGov Functional Test");
		Configuration config = new Configuration(new File("target/" + currentDate), "eGov Test Automation Results");

		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}

	public static String converToString(String conValue) {
		return conValue.replaceAll("\"", "");
	}
	
	public static String getYamlProperties(String yamlString) {
	    Yaml yaml= new Yaml();
	    Object obj = yaml.load(yamlString);

	    return JSONValue.toJSONString(obj);
	}
}