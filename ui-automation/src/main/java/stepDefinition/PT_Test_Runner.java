package stepDefinition;

import static org.testng.Assert.assertEquals;

import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Map.Entry;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.asserts.SoftAssert;

import cucumber.api.CucumberOptions;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import utilities.BaseTests;
import utilities.DriverUtil;

/* Module: Property Tax
 * 
 *
 *
 *
 *
 *
 */


@CucumberOptions(features = { "src/test/java/features/PT" }, glue = { "stepDefinition/" }, monochrome = true, tags = {
		"@pt14"}, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
				"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })
public class PT_Test_Runner extends AbstractTestNGCucumberTests implements BaseTests {
	//protected WebDriver driver;
	String ApplicationNum="";
	String path = System.getProperty("user.dir")+"/src/test/java/TestData";
	//String outputFile = path + "/" + "dataHindi" + ".properties";
	String outputFile = path + "/" + "data" + ".properties";


	elementLocators locator = new elementLocators();
	
	@BeforeClass
	public void eGovlauncher() {
		try {
			DriverUtil.getDefaultDriver();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	
// 	Start Citizen Region
	
	@When("^Select Language \"(.*)\"$")
	public void skiplink(String language ) {
		try {
            Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("language",pro.getProperty(language));
			eGovOp.clickElement(locator.selectcitizenLanguage(eGovOp.getRuntimeProps("language")), "Select Language");
        	eGovOp.clickElement(locator.citizenContinue(), "Click on Continue Button"); 
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Citizen Service \"(.*)\"$")
	public void citizenService(String service) {
		try {
            Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("service",pro.getProperty(service));
			eGovOp.clickElement(locator.selectService(eGovOp.getRuntimeProps("service")), "Select Language");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Location")
	public void selectLocation() {
		try {
            Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("location",pro.getProperty("location"));
			eGovOp.enterData(locator.inputfield(1), eGovOp.getRuntimeProps("location"), "Enter Location");
			eGovOp.clickElement(locator.selectLocation(eGovOp.getRuntimeProps("location")), "Select Location");
        	eGovOp.clickElement(locator.citizenContinue(), "Click on Continue Button"); 

		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Service Subtype \"(.*)\"$")
	public void serviceSubtype(String serviceSubtype ) {
		try {
            Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("serviceSubtype",pro.getProperty(serviceSubtype));
			eGovOp.clickElement(locator.selectServiceSubtype(eGovOp.getRuntimeProps("serviceSubtype")), "Select Language");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click On Create Property")
	public void createProperty() {
		try {
            
			eGovOp.clickElement(locator.selectHyperlinkText(3), "Click On Create Property");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Select Yes for Is Resident Property")
	public void residentProperty() {
		try {
            
			eGovOp.clickElement(locator.radioButtonfield(1), "Select Yes for Is Resident Property");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	@And("^Choose Number of Floors")
	public void numberofFloors() {
		try {
            
			eGovOp.clickElement(locator.radioButtonfield(1), "Choose Number of Floors");
			eGovOp.scrollToElement(locator.nextbutton());
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Choose Number of Basements")
	public void numberofBasements() {
		try {
            
			eGovOp.clickElement(locator.radioButtonfield(1), "Click Choose Number of Basements");
			eGovOp.scrollToElement(locator.nextbutton());
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Enter Ground Floor Details")
	public void groundfloorDetails() {
		try {
            
			eGovOp.enterData(locator.plotSize(),"400","Enter Plot Size");
			eGovOp.enterData(locator.builtUpArea(), "300","Enter Build Up Area");
			eGovOp.scrollToElement(locator.nextbutton());
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Select Floor Self Occupied Option")
	public void selfoccupiedOption() {
		try {
            
			eGovOp.clickElement(locator.radioButtonfield(1), "Select Fully rented out");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Enter Rental Details")
	public void enterRentalDetails() {
		try {
            
			eGovOp.enterData(locator.rentArea(),"40","Enter Rent Area");
			eGovOp.enterData(locator.annualRent(), "3000","Enter Annual Rent");
			eGovOp.scrollToElement(locator.nextbutton());
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@And("^Select No for floor unoccupied")
	public void selfunoccupiedOption() {
		try {
            
			eGovOp.clickElement(locator.radioButtonfield(2), "Select Fully rented out");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Enter VASIKA Property Details")
	public void vasikapropertyDetails() {
		try {
			String currentUrl=eGovOp.getUrl();
			if(currentUrl.contains("vasika-details")&&eGovOp.wait_for_element(locator.plotSize(),"check element")==true)
			{
				
			eGovOp.enterData(locator.plotSize(),"400","Enter Plot Size");
			eGovOp.enterData(locator.builtUpArea(), "300","Enter Build Up Area");
			eGovOp.scrollToElement(locator.nextbutton());
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
			eGovOp.enterData(locator.plotSize(),"400","Enter Plot Size");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
			eGovOp.enterData(locator.plotSize(),"400","Enter Plot Size");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
			
			}
			
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	//vacant land
	@And("^Enter Area")
	public void enterArea() {
		try {
            
			eGovOp.enterData(locator.floorArea(),"300", "Enter Area");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Proof of Address")
	public void proofofAddress() {
		try {
			
			eGovOp.clickElement(locator.dropdownfieldCitizen("1"), "Click on dropdown");
			eGovOp.clickElement(locator.selectfromDropdown("Electricity Bill"), "Select Electricity Bill");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Select Provide Ownership details Radio button \"(.*)\"$")
	public void checkradiobutton(String ownership) {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("ownership",pro.getProperty(ownership));
			eGovOp.clickElement(locator.maintype(eGovOp.getRuntimeProps("ownership")), "Click on Ownership details Radio button");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}	
	
	@And("^Enter Owner Details")
	public void ownerDetails() {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("ValidMobile",pro.getProperty("ValidMobile"));
			eGovOp.enterData(locator.inputfield(1),"TestName", "Enter Name");
			eGovOp.wait_for_element_to_click(locator.selectGender(), "Wait");
			eGovOp.clickElement(locator.selectGender(),"Select Male Radio Button");
			eGovOp.enterData(locator.mobileNumField(),eGovOp.getRuntimeProps("ValidMobile"),"Enter valid Complaint Number");
			eGovOp.scrollToElement(locator.radioButtonfield(2));
			eGovOp.enterData(locator.guardianField(),"TestGuardian", "Enter Gurdian Number");
			eGovOp.clickElement(locator.radioButtonfield(4),"Select Father Radio Button");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}	
	@And("^Select Special Owner category Radio button \"(.*)\"$")
	public void specialOwner(String specialOwner) {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("specialOwner",pro.getProperty(specialOwner));
			eGovOp.clickElement(locator.maintype(eGovOp.getRuntimeProps("specialOwner")), "Click on Special Owner Radio button");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Enter Owners Address")
	public void enterownerAddress() {
		try {
			
			eGovOp.enterData(locator.addressfield(),"Test Address", "Enter Owners Address");
			eGovOp.hoverOverclick(locator.svg(7));
			eGovOp.clickElement(locator.svg(7), "Click on checkbox Option");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Upload Special Owner Category Proof")
	public void specialownerProof() {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("file",pro.getProperty("file"));
			
			eGovOp.clickElement(locator.dropdownfieldCitizen("1"), "Click on dropdown");
			eGovOp.clickElement(locator.selectfromDropdown("General ID"), "Select Electricity Bill");
			
			String button = eGovOp.getElementText(locator.chooseFilebutton(),"Check the Upload button name in the screen");
			
			if (button.contains("Choose")) {
				String filep = System.getProperty("user.dir") + "/src/test/java/TestData/" + eGovOp.getRuntimeProps("file");
				eGovOp.clickChoose(locator.inputFile(), filep, "Click on Upload doc1");
			} 			
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");

		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Upload Proof Of Identity")
	public void proofofIdentity() {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("file",pro.getProperty("file"));
			
			eGovOp.clickElement(locator.dropdownfieldCitizen("1"), "Click on dropdown");
			eGovOp.clickElement(locator.selectfromDropdown("Aadhar Card"), "Select Electricity Bill");
			
			String button = eGovOp.getElementText(locator.chooseFilebutton(),"Check the Upload button name in the screen");
			
			if (button.contains("Choose")) {
				String filep = System.getProperty("user.dir") + "/src/test/java/TestData/" + eGovOp.getRuntimeProps("file");
				eGovOp.clickChoose(locator.inputFile(), filep, "Click on Upload doc1");
			} 		
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");

		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Review Answer and accept")
	public void reviewandAccept() {
		try {
			eGovOp.scrollToElement(locator.checkboxfield());
			eGovOp.hoverOverclick(locator.svg(7));
			eGovOp.clickElement(locator.svg(7), "Click on checkbox Option");
		//	eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Check Property Application Number")
	public void ptapplicationNumber() {
		try {
			 ApplicationNum=eGovOp.getElementText(locator.applicationNumber(),"get Application number");
				eGovOp.writePropertyApplicationNumber(ApplicationNum);

			if(ApplicationNum==null)
			{
			eGovOp.assertbyboolean(true,false,"Application number not genrated");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Check Property Unique ID")
	public void ptuid() {
		try {
			 ApplicationNum=eGovOp.getElementText(locator.propertyID(),"get Application number");
				eGovOp.writePropertyUID(ApplicationNum);

			if(ApplicationNum==null)
			{
			eGovOp.assertbyboolean(true,false,"Application number not genrated");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@And("^Enter Unique Property ID")
	public void enterPropertyID() {
		try {
			String pID=eGovOp.readPropertyUID();
			eGovOp.enterData(locator.propertyIDfield(),pID,"Enter Challan Number");
		} catch (Exception e) {
			e.getStackTrace();
		}
}
	
	@And("^Click on Search button")
	public void searchbutton() {
		try {
		
			eGovOp.clickElement(locator.eGovNext(),"Click on search");
		} catch (Exception e) {
			e.getStackTrace();
		}
}
	
	@And("^Click On My Application")
	public void myApplication() {
		try {
            
			eGovOp.clickElement(locator.selectHyperlinkText(5), "Click On My Application");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Click On Track button")
	public void clickonViewDetails() {
		try {

			String ptUID=eGovOp.readPropertyUID();
			eGovOp.clickElement(locator.viewDetails(ptUID), "Click On Track button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	//End Citizen Region
	//Employee DV
	@And("^Click on Property Tax")
	public void ptService() {
		try {
		
			eGovOp.clickElement(locator.selectServiceType(4),"Click on Property Tax");
		} catch (Exception e) {
			e.getStackTrace();
		}
}
	@When("^Enter Application Details")
	public void ptApplicationDetails() {
		try {
			String ptAppnum=eGovOp.readPropertyApplicationNumber();
			String ptUID=eGovOp.readPropertyUID();
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("ValidMobile",pro.getProperty("ValidMobile"));
			eGovOp.enterData(locator.inputfield(2),ptAppnum,"Enter PT Application Number");
			eGovOp.enterData(locator.inputfield(3),ptUID,"Enter PTUID");
			eGovOp.enterData(locator.inputfield(4),eGovOp.getRuntimeProps("ValidMobile"),"Enter Mobile Number");


		} catch (Exception e) {
			e.getStackTrace();
		}
}
	
	@And("^Click on Unique Property ID")
	public void applicationNumber() {
		try {
			String ptUID=eGovOp.readPropertyUID();

			eGovOp.clickElement(locator.comliantnum(ptUID), "Click on Unique Property ID");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Click on Verify")
	public void verifyOption() {
		try {

			eGovOp.clickElement(locator.takeActionOtions(1), "Click on Verify");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Click on Forward")
	public void forwardOption() {
		try {

			eGovOp.clickElement(locator.takeActionOtions(1), "Click on Forward");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Field Field Inspectors")
	public void selectFieldInspector() {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Field_Inspectors",pro.getProperty("Field_Inspectors"));
			eGovOp.enterData(locator.dropDownfieldEmp(3), eGovOp.getRuntimeProps("Field_Inspectors"), "Enter Field Inspector");
			eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("Field_Inspectors")), "Click on dropdown");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	
	@And("^Click On Verify button")
	public void clickonVerifybutton() {
		try {
			eGovOp.clickElement(locator.assignbutton(), "Click On assign button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	// Start Field Inspector Region 
	
	@And("^Select Approver")
	public void selectApprover() {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Approver",pro.getProperty("Approver"));
			eGovOp.enterData(locator.dropDownfieldEmp(3), eGovOp.getRuntimeProps("Approver"), "Enter Field Inspector");
			eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("Approver")), "Click on dropdown");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@And("^Click On Forward button")
	public void clickonForwardbutton() {
		try {
			eGovOp.clickElement(locator.assignbutton(), "Click On assign button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	// End Field Inspector region
	
	//Start Approver Region
	
	@Then("^Click on APPROVE")
	public void approveOption() {
		try {

			eGovOp.clickElement(locator.takeActionOtions(1), "Click on Verify");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click On Approve button")
	public void clickonApprovebutton() {
		try {
			eGovOp.clickElement(locator.assignbutton(), "Click On assign button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	//End Approver Region
	
	//Start Counter Employee Region
	@And("^Click On Search Property")
	public void clickonSearchProperty() {
		try {
			eGovOp.clickElement(locator.clickonLink(2), "Click On Search Property");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select PT Locality")
	public void selectPTLocality() {
		try {
			Properties pro = new Properties();

			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("locality",pro.getProperty("locality"));
			
			eGovOp.clickElement(locator.dropdownfield("3"), "Click On Search Property");
			eGovOp.clickElement(locator.selectLocality(eGovOp.getRuntimeProps("locality")), "Click On Search Property");

			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Enter UID and Number")
	public void EnterUIDNumber() {
		try {
			String ptUID=eGovOp.readPropertyUID();
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("ValidMobile",pro.getProperty("ValidMobile"));
			eGovOp.enterData(locator.inputfield(2),ptUID,"Enter PTUID");
			eGovOp.enterData(locator.inputfield(4),eGovOp.getRuntimeProps("ValidMobile"),"Enter Mobile Number");



		} catch (Exception e) {
			e.getStackTrace();
		}
		
		
}
	@Then("^Click on ASSESS PROPERTY")
	public void assessProperty() {
		try {

			eGovOp.clickElement(locator.takeActionOtions(1), "Click on ASSESS PROPERTY");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Financial Year")
	public void selectFinancialYear() {
		try {
          Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Financial_Years",pro.getProperty("Financial_Years"));
			
			eGovOp.clickElement(locator.radiobuttonsubtype(eGovOp.getRuntimeProps("Financial_Years")), "Select Financial Year");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click On Assess Property button")
	public void clickonAssessPropertybutton() {
		try {
			eGovOp.clickElement(locator.assignbutton(), "Click On Assess Property button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click On View Property Details")
	public void viewDetails() {
		try {
			eGovOp.scrollToElement(locator.viewdetails());
			eGovOp.clickElement(locator.viewdetails(),"Click On View Property Details");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click On Download Label")
	public void downloadlabel() {
		try {
			eGovOp.clickElement(locator.citizenDownloadlabel(), "Click On Download");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	
	@When("^Check information and Next")
	public void clickonnextbutton() {
	
		try {
			eGovOp.wait_for_element(locator.checkinformation(), "wait for list Header");
			eGovOp.clickElement(locator.nextbutton(), "Click on Next Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
/*
 * @After public void eGovgoCloseApp() { try { DriverUtil.closeDriver(); } catch
 * (Exception e) { e.getStackTrace(); } }
 */
 

}


