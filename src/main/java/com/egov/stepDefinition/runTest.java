package com.egov.stepDefinition;

import org.openqa.selenium.WebDriver;

import com.egov.utils.BaseTests;
import com.egov.utils.DriverUtil;

import cucumber.api.CucumberOptions;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.api.testng.AbstractTestNGCucumberTests;

@CucumberOptions(features = { "src/test/java/com/egov/ui-services/tests/features" }, glue = { "com/egov/stepDefinition/" }, monochrome = true, tags = {
		"@egov" }, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
				"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })

public class runTest extends AbstractTestNGCucumberTests implements BaseTests {
	protected WebDriver driver;

	elementLocators locator = new elementLocators();
	String recId;
	boolean home;

	@When("Launch Browser")
	public void launcher() {
		try {
			DriverUtil.getDefaultDriver();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("Open eGov web page")
	public void launcherEmp() {
		try {

			eGovOp.navigateTo("https://qa.digit.org/employee/");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("Relaunch Empx Application")
	public void Relauncher() {
		try {
			eGovOp.getRelaunchApp();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^Select the language as English")
	public void selectEnglish() {
		try {
			//Thread.sleep(5000);
			eGovOp.clickElement(locator.langEnglish(), "Select the English language before login");
			//Thread.sleep(5000);
			eGovOp.wait_for_text(locator.engButton(), "CONTINUE");
			String buttonName = eGovOp.getElementText(locator.engButton(), "Observe the Button name");
			if (buttonName.contentEquals("CONTINUE")) {
				eGovOp.clickElement(locator.engButton(), "Select the Continue button");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@Given("^Enter eGov username as \"(.*)\"$")
	public void enterUsername(String username) {
		try {
			eGovOp.enterData(locator.usernameElem(), username, "Enter Username");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@And("^Enter eGov password as \"(.*)\"$")
	public void enterPassword(String password) {
		try {
			eGovOp.enterData(locator.passwordElem(), password, "Enter Password");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select eGov city field")
	public void clickCity() {
		try {
			eGovOp.clickElement(locator.cityElem(), "Enter City");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Search for the expected city as \"(.*)\"$")
	public void enterCity(String city) {
		try {
			eGovOp.enterData(locator.citySearchElem(), city, "Search the City");
			eGovOp.clickElement(locator.selectCityElem(), "Select the expected City");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@And("^Click on Continue to proceed further")
	public void landHomepage() {
		try {
			eGovOp.clickElement(locator.loginButton(), "Select the Continue button to Login");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Verify user lands on HomePage")
	public void showHomePage() {
		try {
			eGovOp.implicitWait(30, "Wait for Homepage to load!");
			home = eGovOp.wait_for_text(locator.homePage(), "Welcome");
			
			if (home) {
				System.out.println("Test PASS!!");
			}else {
				System.out.println("Test FAIL!!");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Go to Property Tax page")
	public void propTax() {
		try {
			eGovOp.clickElement(locator.proptx(), "Click on Property tax, left hand menu");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click on Add new Property button")
	public void addNewPrp() {
		try {
			eGovOp.implicitWait(5, "Let the Property Schema load");
			eGovOp.clickElement(locator.addNew(), "Click on Add new Property button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Proceed with Apply button")
	public void addNewApply() {
		try {
			eGovOp.implicitWait(5, "Let the Property details page load");
			eGovOp.clickElement(locator.addNewApply(), "Click on Proceed with Apply button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Provide Locality in Property address as \"(.*)\"$")
	public void propAddrDetails(String locale) {
		try {
			eGovOp.implicitWait(5, "Let the Property address page load");
			eGovOp.clickElement(locator.prop_locty(), "Enter Locale in Property Tax");
			eGovOp.clickElement(locator.prop_loc(), "Enter Locale in Property Tax");
			//eGovOp.clickElement(locator.tx_exp_loc(), "Click on the Expected locale Element");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Go to Next screen")
	public void goNext() {
		try {
			eGovOp.implicitWait(5, "Let the Next screen load");
			eGovOp.clickElement(locator.goNxt(), "Click on Go to Next screen");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click on add Property")
	public void addProp() {
		try {
			eGovOp.implicitWait(5, "Let the Screen wait for next screen to load");
			eGovOp.clickElement(locator.propAdd(), "Click on Go to Next screen");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Get the unique property ID")
	public void getId() {
		try {
			eGovOp.implicitWait(5, "Observe the Property creation and copy the PropertyID");
			String idText = eGovOp.getElementText(locator.getPropId(), "Get the Unique Property ID");
			String[] propID = idText.split(": ");
			String uniquePropId = propID[1];
			System.out.println("Property Id:\t"+uniquePropId);
			eGovOp.setRuntimeProps("expected_UniqueID", uniquePropId);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Upload first document at \"(.*)\"$")
	public void upload1(String fileLoc) {
		try {
			eGovOp.implicitWait(5, "Wait for Upload document screen load");
			eGovOp.clickElement(locator.doc1(), "Click on Select document1");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.bill_doc(), "Click on Bill document1");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.upload1(), "Click on Upload doc1");
			eGovOp.implicitWait(2, "Working with Local drives");
			String fileL = System.getProperty("user.dir")+"/src/test/java/"+fileLoc;
			System.out.println("File Location:\t"+fileL);
			eGovOp.uploadData(locator.upload1(),fileL , "File1 upload");
			eGovOp.implicitWait(10, "Observe if the document is uploaded");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Upload second document at \"(.*)\"$")
	public void upload2(String fileLoc) {
		try {
			eGovOp.implicitWait(5, "Wait for Upload document screen load again");
			eGovOp.scrollPage();
			eGovOp.clickElement(locator.doc2(), "Click on Select document2");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.bill_doc(), "Click on Bill document2");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.upload2(), "Click on Upload doc2");
			eGovOp.implicitWait(2, "Working with Local drives");
			String fileL = System.getProperty("user.dir")+"/src/test/java/"+fileLoc;
			System.out.println("File Location:\t"+fileL);
			eGovOp.uploadData2(locator.upload2(),fileL , "File2 upload");
			eGovOp.implicitWait(10, "Observe if the document is uploaded");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Upload third document at \"(.*)\"$")
	public void upload3(String fileLoc) {
		try {
			eGovOp.implicitWait(5, "Wait for Upload document screen load again");
			eGovOp.scrollPage();
			eGovOp.clickElement(locator.doc3(), "Click on Select document3");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.bill_doc(), "Click on Bill document3");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.upload2(), "Click on Upload doc3");
			eGovOp.implicitWait(2, "Working with Local drives");
			String fileL = System.getProperty("user.dir")+"/src/test/java/"+fileLoc;
			System.out.println("File Location:\t"+fileL);
			eGovOp.uploadData2(locator.upload2(),fileL , "File3 upload");
			eGovOp.implicitWait(10, "Observe if the document is uploaded");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Upload fourth document at \"(.*)\"$")
	public void upload4(String fileLoc) {
		try {
			eGovOp.implicitWait(5, "Wait for Upload document screen load again");
			eGovOp.scrollPage();
			eGovOp.clickElement(locator.doc4(), "Click on Select document4");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.bill_doc(), "Click on Bill document4");
			eGovOp.implicitWait(2, "Working with Local drives");
			eGovOp.clickElement(locator.upload2(), "Click on Upload doc4");
			eGovOp.implicitWait(2, "Working with Local drives");
			String fileL = System.getProperty("user.dir")+"/src/test/java/"+fileLoc;
			System.out.println("File Location:\t"+fileL);
			eGovOp.uploadData2(locator.upload2(),fileL , "File4 upload");
			eGovOp.implicitWait(10, "Observe if the document is uploaded");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Provide Property details as \"(.*)\"$")
	public void propDetails(String usg_type) {
		try {
			eGovOp.implicitWait(5, "Working with Local drives");
			eGovOp.clickElement(locator.prop_comm(), "Click on Usage Type");
			eGovOp.implicitWait(2, "Wait before click on Usage Type Commerial");
			eGovOp.clickElement(locator.prop_erial(), "Click on Usage Type Commerial");
			eGovOp.implicitWait(2, "Wait before Click on Property Type");
			eGovOp.clickElement(locator.prop_type(), "Click on Property Type");
			eGovOp.implicitWait(2, "Wait before Click on Property Type Vacant");
			eGovOp.clickElement(locator.prop_flr(), "Click on Property Type Vacant");
			eGovOp.implicitWait(2, "Wait before Enter Plot Size value");
			eGovOp.enterData(locator.plot_sz(), "10", "Enter Plot Size value");
			
			//eGovOp.clickElement(locator.tx_exp_loc(), "Click on the Expected locale Element");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Provide Owner details as \"(.*)\", \"(.*)\", \"(.*)\"$")
	public void propOwner(String name, String mobile, String gaurdian) {
		try {
			//Store in Runtime environments
			eGovOp.setRuntimeProps("expected_GovName", name);
			eGovOp.setRuntimeProps("expected_GovMobile", mobile);
			eGovOp.setRuntimeProps("expected_GovGaurdian", gaurdian);
			
			eGovOp.implicitWait(2, "Wait before Enter Owner name");
			eGovOp.enterData(locator.owner_name(), name, "Enter Owner name");
			eGovOp.implicitWait(2, "Wait before Enter Owner mobile number");
			eGovOp.scrollPage();
			eGovOp.enterData(locator.owner_mob(), mobile, "Enter Owner mobile number");
			eGovOp.implicitWait(2, "Wait before Enter Guardian name");
			eGovOp.enterData(locator.owner_gaurd(), gaurdian, "Enter Guardian name");
			eGovOp.implicitWait(2, "Wait before Click on Special Category");
			eGovOp.clickElement(locator.owner_specCat(), "Click on Special Category");
			eGovOp.implicitWait(5, "Wait before Click on Usage Type Commerial");
			eGovOp.scrollToElement(locator.noneOfAbv());
			eGovOp.implicitWait(2, "Wait before Click on Usage Type Commerial");
			eGovOp.clickElement(locator.none_specCat(), "Click on Usage Type Commerial");
//			Thread.sleep(5000);
			//eGovOp.clickElement(locator.tx_exp_loc(), "Click on the Expected locale Element");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Fill in the property tax details with \"(.*)\", \"(.*)\", \"(.*)\", \"(.*)\", \"(.*)\", \"(.*)\"$")
	public void enterTaxDetails(String locale, String mobile, String owner, String uniqPropId, String existPropId, String doorNo) {
		try {
			Thread.sleep(5000);
			eGovOp.enterData(locator.tx_locty(), locale, "Enter Locale in Property Tax");
			eGovOp.clickElement(locator.tx_exp_loc(), "Click on the Expected locale Element");
			eGovOp.enterData(locator.tx_mob(), mobile, "Enter Mobile in Property Tax");
			eGovOp.enterData(locator.tx_ownrName(), owner, "Enter Owner in Property Tax");
			eGovOp.enterData(locator.tx_uniq_propId(), uniqPropId, "Enter Unique Property Id in Property Tax");
			eGovOp.enterData(locator.tx_exist_propId(), existPropId, "Enter Exist Property Id in Property Tax");
			eGovOp.enterData(locator.tx_dorrNo(), doorNo, "Enter DoorNo. in Property Tax");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@And("^Logout and Close Application")
	public void goCloseApp() {
		boolean selVal;
		String pageSource;
		try {
			eGovOp.getCloseApp();

		} catch (Exception e) {
			// System.out.println("Closing from CATCH");
			eGovOp.getCloseApp();
			e.getStackTrace();
		}
	}
}