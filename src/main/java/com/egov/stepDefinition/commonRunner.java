package com.egov.stepDefinition;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import com.egov.utils.BaseTests;

import cucumber.api.CucumberOptions;
import cucumber.api.java.en.When;
import cucumber.api.testng.AbstractTestNGCucumberTests;

@CucumberOptions(features = { "src/test/java/features" }, glue = { "stepDefinition/" }, monochrome = true, tags = {
		"@sample" }, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
				"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })

public class commonRunner extends AbstractTestNGCucumberTests implements BaseTests {

	WebDriver driver;
	String ls;

	@When("^ I Enter username \"(.*)\"$")
	public void enterUsername(String username) {

		eGovOp.navigateTo("");

//		driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
		String pageSource = driver.getPageSource();
		System.out.println("LOG SOURCE:\n" + pageSource);
		System.out.println("LOG SOURCE");
		System.out.println(ls);
		WebElement usernm = driver.findElement(By.xpath("//div[contains(text(),'Email or Username')]"));
		usernm.click();
		usernm.clear();
		usernm.sendKeys(username);
	}
}
