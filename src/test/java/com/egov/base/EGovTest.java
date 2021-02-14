package com.egov.base;

import static org.junit.Assert.assertTrue;
import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.ArrayList;
import java.util.Date;
import java.util.Collection;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.apache.commons.io.FileUtils;
import org.junit.BeforeClass;
import org.junit.Test;
import org.yaml.snakeyaml.Yaml;

import com.intuit.karate.KarateOptions;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import net.minidev.json.JSONValue;

@KarateOptions(features = {"classpath:com/egov"},
	tags = {"@reports,@searchMdms,@location,@localization,@userotp,@eGovUser,@accessControl," +
			"@hrms,@collectionServices,@billingServiceDemand,@pdfservice,@billingServiceBill," +
			"@idGenerate,@egovWorkflowProcess,@fileStore,@pgservices"})
// below tags will be added for execution once port fowarding is implemented on the system under execution
// @encService and @apportionService

public class EGovTest {
	@BeforeClass
	public static void before() {
		
	}

	@Test
	public void testParallel() {

		String karateOutputPath = "target/surefire-reports";
		Results stats = Runner.parallel(getClass(), 1, karateOutputPath);
		generateReport(karateOutputPath);
		assertTrue("there are scenario failures", stats.getFailCount() == 0);
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
		Configuration config = new Configuration(new File("target/" + currentDate), "eGov Functional Test");

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