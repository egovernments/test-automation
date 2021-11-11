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

@CucumberOptions(features = { "src/test/java/features/FSM" }, glue = { "stepDefinition/" }, monochrome = true, tags = {
		"@fsm22"}, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
				"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })
public class FSM_Test_Runner extends AbstractTestNGCucumberTests implements BaseTests {
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
	
	@When("^Click on Apply Septic Tank Pit")
	public void fsmApply() {
		try {
			eGovOp.clickElement(locator.fsmapply(), "Select FSM");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^Click On Fsm My Application")
	public void fsmmyapplication() {
		try {
			eGovOp.scrollToElement(locator.fsmcitizenLogin());
			eGovOp.clickElement(locator.fsmcitizenLogin(), "Click On Fsm My Application");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@And("^Click On View")
	public void clickonView() {
		try {

			String appnum=eGovOp.readApplicationNumber();
			eGovOp.clickElement(locator.viewButton(appnum), "Click On View");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click on Rate Us")
	public void clickateUs() {
		try {
			//eGovOp.scrollpagewithpixel(0, 500);
			eGovOp.scrollToElement(locator.applicationTimeline());
			eGovOp.clickElement(locator.rateUs(), "Click on Rate Us");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Ratings and Comment")
	public void selectRatings() {
		try {
			eGovOp.clickElement(locator.starRating(), "Star Rating");
			eGovOp.clickElement(locator.nobuttonRating(), "NO Radio Button Rating");
			eGovOp.hoverOverclick(locator.ratingcheckboxfield("HAND_GLOVES"));
			eGovOp.hoverOverclick(locator.ratingcheckboxfield("NOSE_MASK"));
			eGovOp.hoverOverclick(locator.ratingcheckboxfield("EYE_GEAR"));
			eGovOp.enterData(locator.Entercomments(), "Test","Enter comment");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Click on Property type Radio button \"(.*)\"$")
	public void checkradiobutton(String property) {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("property",pro.getProperty(property));
			eGovOp.clickElement(locator.maintype(eGovOp.getRuntimeProps("property")), "Click on My Complaint Option");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}	


	
	@Then("^Verify on Comlaint Sub type Landing page")
	public void verfycomplientsubtypelandingpage() {
		
			boolean status=eGovOp.verify(locator.compliantsubtypeptext(),"Complaint Landing page");
			eGovOp.assertbyboolean(true,status, " Assert Complaint Landing page Fail");
		
		}


	@And("^Pin Complaint Location")
	public void PinComplaintLocationPage() {
		
			boolean status=eGovOp.verify(locator.verifypincomplaintLoacationpage(),"Pin Complaint Location Page");
			eGovOp.assertbyboolean(true,status, " Assert Pin Complaint Location Fail");
		
		}
	
	
	@And("^Pin Property Location")
	public void PinLocationPage() {
		
			boolean status=eGovOp.verify(locator.verifypinLoacationpage(),"Pin Property Location Page");
			eGovOp.assertbyboolean(true,status, " Assert Pin Complaint Location Fail");
		
		}
	
	@Then("^Enter pincode \"(.*)\"$")
	public void enterpincode(String pincode) {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("pincode",pro.getProperty(pincode));
		
			if(eGovOp.wait_for_element(locator.pincodeenter(),"check element")==true)
			{
				eGovOp.enterData(locator.pincodeenter(), eGovOp.getRuntimeProps("pincode"), "Enter pincode");
					
				
	        	eGovOp.scrollToElement(locator.nextbutton());
	        	eGovOp.clickElement(locator.nextbutton(), "Click on Nedxt Option"); 
		
			}
			else
			{
				eGovOp.clickElementShort(locator.skiplink(), "Click skip and next");
			}
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Click on Locality")
	public void localitybutton() {
		
		try {
	
				eGovOp.clickElement(locator.localitybutton(), "Click on Locality Button");				
		}
		
		
		  catch (Exception e) {
			e.getStackTrace();
		}
		
	}
	

	@And("^Click skip and next")
	public void skiplink() {
		try {
			eGovOp.clickElement(locator.skiplink(), "Click skip and next");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@Then("^Verify Landmark Page")
	public void landmarkpage() {
		try {
			boolean status=eGovOp.verify(locator.landmarklandingpage()," Verify Landmark  Page");
			eGovOp.assertbyboolean(true,status, " Assert Verify Landmark Page Fail");
					} 
		catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@And("^Select City and Check Locality")
	public void selectcitywuthoutpin() {
		try {
           Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("city",pro.getProperty("city"));
			eGovOp.setRuntimeProps("Mohalla",pro.getProperty("Mohalla"));
			if(eGovOp.wait_for_element(locator.selectcitydropdown(), "")==true)
			{
			eGovOp.clickElement(locator.selectcitydropdown(), "Select City Dropdown");
			eGovOp.clickElement(locator.selectcityCitizen(eGovOp.getRuntimeProps("city")), "Select City");
			eGovOp.clickElement(locator.selectLocalitydropdown(), "Select Locality Dropdown");
			eGovOp.clickElement(locator.selectLocality(eGovOp.getRuntimeProps("Mohalla")), "Select locality");
			eGovOp.scrollToElement(locator.nextbutton());
			}
			eGovOp.clickElement(locator.nextbutton(), "Click on Nedxt Option");
	
		}
		catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@When("^Scroll click on Next button")
	public void scrollclickonnextbutton() {
	
		try {
			eGovOp.wait_for_element_to_click(locator.skiplink(), "element to be click");
			eGovOp.scrollToElement(locator.skiplink());
			eGovOp.clickElement(locator.skiplink(), "Click On Skip Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Check Can enter city")
	public void entercity() {
		try {
			eGovOp.implicitWait(10, "Wait");
			eGovOp.enterData(locator.entercity(), "Mumbai", "Enter city in field");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Verify provide valid pin text")
	public void  providevalidpintext() {
		try {
			eGovOp.wait_for_element(locator.checkvalidpintext(), "Wait for element");
			boolean status=eGovOp.verify(locator.checkvalidpintext()," Verify provide valid pin text");
			eGovOp.assertbyboolean(true,status,"Assert Verify provide valid pin text Fail");
					} 
		catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	@And("^Clear pin field")
	public void cleantext() {
		try {
			eGovOp.cleartext(locator.pincodeenter(), "clear text field");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@And("^Click Slum Located Option")
	public void slumLocatedOption() {
		
	
		try {
			eGovOp.clickElement(locator.radioButtonfield(1), "Click on Yes Slum");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Provide Name of the Slum \"(.*)\"$")
	public void provideNameoftheSlum(String slum) {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Slum_Area",pro.getProperty(slum));
			
			eGovOp.clickElement(locator.provideslumDropdown(), "Slum dropdown");
			eGovOp.clickElement(locator.provideslum(eGovOp.getRuntimeProps("Slum_Area")), "Select Slum Area");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@Then("^Update Name of the Slum")
	public void updateNameoftheSlum() {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Slum_Area",pro.getProperty("Slum_Area"));
			eGovOp.clickElement(locator.inputfield(8), "Slum dropdown");
			eGovOp.clickElement(locator.provideslum(eGovOp.getRuntimeProps("Slum_Area")), "Update Slum Area");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Update Name of the Slum as \"(.*)\"$")
	public void updateNameoftheSlumdata(String slum) {
		try {
			Properties pro = new Properties();
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Slum_Area",pro.getProperty(slum));
			eGovOp.clickElement(locator.inputfield(8), "Slum dropdown");
			eGovOp.clickElement(locator.provideslum(eGovOp.getRuntimeProps("Slum_Area")), "Update Slum Area");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Enter Street and Door")
	public void enterStreetDoor() {
		
	
		try {
			eGovOp.enterData(locator.enterStreet(), "Test","Enter Street Name");
			eGovOp.enterData(locator.enterHouse(), "T1","Enter House Number");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@And("^Choose Sanitation type")
	public void sanitationtypeinCitizen() {
	
		try {
			eGovOp.clickElement(locator.selectseptictank(), "Choose Sanitation Type");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Click My Complaint Option")
	public void ClickMyomplaintOption() {
		try {
			eGovOp.clickElement(locator.myecomplientlink(), "Click on My Complaint Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click Make Payment")
	public void makePayment() {
		try {
			eGovOp.scrollToElement(locator.eGovNext());
			eGovOp.clickElement(locator.eGovNext(), "Click Make Payment");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click Pay button")
	public void payButton() {
		try {
			eGovOp.clickElement(locator.eGovNext(), "Click Pay Button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@And("^Click On Master Card")
	public void masterCard() {
		try {
			eGovOp.clickElement(locator.masterCardIcon(), "Click On Master Card");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Enter Card Details \"(.*)\"$")
	public void cardDetails(String cardnum) {
		try {
			Properties pro = new Properties();

			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("cardnum",pro.getProperty(cardnum));
			
			eGovOp.enterData(locator.cardNumInput(),eGovOp.getRuntimeProps("cardnum"), "Enter Card Number");
			eGovOp.enterData(locator.cardMonthInput(),"12", "Enter Card Month");
			eGovOp.enterData(locator.cardYearInput(),"25", "Enter Card Year");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Click On Pay Now button")
	public void payNow() {
		try {
			eGovOp.clickElement(locator.payNowButton(), "Click On Pay Now Button");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@And("^Click On Submit")
	public void submitbuttn() {
		try {
			eGovOp.clickElement(locator.submit(),"Click On Submit");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Download Reciept and Goto Homepage")
	public void gotoHomepage() {
		try {
			eGovOp.clickElement(locator.eGovNext(),"Click On Download Recipet");
			eGovOp.clickElement(locator.recieptGohomepage(),"Click On Go to Home Page");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	
	@And("^Click On View Rating")
	public void viewRating() {
		try {
			eGovOp.clickElement(locator.viewrating(),"Click On View Rating");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Check Ratings")
	public void checkRatings() {
		try {
			boolean gearrating=	eGovOp.isdisplay(locator.gearsRating(),"Check Gear Rating");
			boolean spillagerating=eGovOp.isdisplay(locator.spillageoptionRating(),"Check Spillage Rating");
			boolean commentstatus=eGovOp.isdisplay(locator.checkcommentRating(),"check Comment");
			
			if(!gearrating||!spillagerating||!commentstatus)
			{
				SoftAssert softAssertion= new SoftAssert();
				System.out.println("softAssert Method Was Started");
				softAssertion.assertEquals(true,false);
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Download Acknowledgement")
	public void downloadAcknowldgement() {
		try {
			eGovOp.clickElement(locator.downloadOption(),"Click On Download");
			eGovOp.clickElement(locator.applicationAcknowledgement(),"Click On application Acknowledgement");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	
	//End Citizen Region
	
	
// Start Editor Creator Region
	
	@And("^Click on FSM")
	public void clickonfsm() {
		try {
			eGovOp.clickElement(locator.fsm(), "Click on FSM");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click on New Application")
	public void ClickonNewApplication() {
		try {
			eGovOp.clickElement(locator.newapplication(), "Click on New Application");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Application Channel")
	public void selectapplicationChannel() {
		try {
			    eGovOp.clickElement(locator.applicationChanneldropdown(),"Application Channel dropdown");
				eGovOp.clickElement(locator.applicationChannel(),"Enter Application Channel");
		}catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Enter Application Name")
	public void enterapplicationName() {
	try {
		
		eGovOp.enterData(locator.inputfield(2),"Test","Enter Application NAme");
		
	} catch (Exception e) {
		e.getStackTrace();
	}
}
	
	@And("^Enter Mobile Number")
	public void mobileNumber() {
	try {
		
		eGovOp.enterData(locator.mobileNumber(),"9869313101","Enter Mobile Number");
		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	@And("^Select Property \"(.*)\"$")
	public void selectProperty(String Property) {
		try {
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Property",pro.getProperty(Property));
			
			eGovOp.scrollpagewithpixel(0,400);
				eGovOp.clickElement(locator.propertyDropdown(),"Click property Dropdown");
				eGovOp.clickElement(locator.selectResidential(eGovOp.getRuntimeProps("Property")),"Select Residential");
		}catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	@And("^Select SubType \"(.*)\"$")
	public void selectSubtype(String value) {
		try {
			
			Properties pro = new Properties();

			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("value",pro.getProperty(value));
			
				eGovOp.clickElement(locator.selectcitydropdown(),"Click on Dropdown");
				eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("value")),"Select value from dropdown");
		}catch (Exception e) {
			e.getStackTrace();
		}
	}

	
	@And("^Update Property \"(.*)\" and \"(.*)\"$")
	public void updateProperty(String Property,String exSubtype) {
		try {
		
			Properties pro = new Properties();
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("Property",pro.getProperty(Property));
			eGovOp.setRuntimeProps("exSubtype",pro.getProperty(exSubtype));
		eGovOp.wait_short_element_visib(locator.checkfieldpresent(eGovOp.getRuntimeProps("exSubtype")), "Check visibility");
		boolean wait_ele=eGovOp.isEnabled(locator.checkfieldpresent(eGovOp.getRuntimeProps("exSubtype")), "Check visibility");
		if(wait_ele)
		{
			eGovOp.scrollPageUp();
		}
			
				eGovOp.clickElement(locator.propertyDropdown(),"Click property Dropdown");
				eGovOp.clickElement(locator.selectResidential(eGovOp.getRuntimeProps("Property")),"Select Residential");
		}catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Property SubType \"(.*)\"$")
	public void Selectpropertysubtype(String subtype) {
	try {
		Properties pro = new Properties();
		
		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("subtype",pro.getProperty(subtype));
		
		eGovOp.clickElement(locator.subtypepropDropdown(),"Click Property subtype dropdown");
		eGovOp.clickElement(locator.selectsubtype(eGovOp.getRuntimeProps("subtype")),"Select Property subtype");		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	
	@And("^Select Citizen Property SubType \"(.*)\"$")
	public void Selectcitizenpropertysubtype(String subtype) {
	try {
		Properties pro = new Properties();

		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("subtype",pro.getProperty(subtype));
		
		eGovOp.clickElement(locator.firstdropdownfield(),"Click Property subtype dropdown");
		eGovOp.clickElement(locator.selectsubtype(eGovOp.getRuntimeProps("subtype")),"Select Property subtype");		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	
	@And("^Enter Pincode Number")
	public void enterPincode() {
	try {
		Properties pro = new Properties();
		
		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("pincode",pro.getProperty("pincode"));
		eGovOp.scrollpagewithpixel(0, 400);
				
			eGovOp.enterData(locator.pincodeEC(),eGovOp.getRuntimeProps("pincode"),"Enter Pincode Number");
                
		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@And("^Enter Pincode Number as \"(.*)\"$")
	public void enterPincodedata(String pincode) {
	try {
		Properties pro = new Properties();

		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("pincode",pro.getProperty(pincode));
		eGovOp.scrollpagewithpixel(0, 400);
		eGovOp.enterData(locator.pincodeEC(),eGovOp.getRuntimeProps("pincode"),"Enter Pincode Number");
		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@And("^Select Locality Mohalla \"(.*)\"$")
	public void selectMohalla(String Mohalla) {
	try {
		Properties pro = new Properties();
		
		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("Mohalla",pro.getProperty(Mohalla));
		eGovOp.implicitWait(2, "wait");
		eGovOp.clickElement(locator.mohallaDropdwon(),"Click Locality Dropdown");
		eGovOp.enterData(locator.mohallaDropdwon(), eGovOp.getRuntimeProps("Mohalla"), "Enter Mohalla");
		eGovOp.clickElement(locator.selectmohallaEC(eGovOp.getRuntimeProps("Mohalla")),"Select Locality");		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@And("^Enter Street House and Landmark")
	public void enterStreetHouseLandmark() {
	try {
		
		eGovOp.enterData(locator.streetName(),"Street Test","Enter Street ");
		eGovOp.enterData(locator.houseNo(),"1 Test","Enter House Number");
		eGovOp.enterData(locator.landmark(),"Landmark Test","Enter Landmark");

		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@When("^Select Sanitation Type \"(.*)\"$")
	public void sanitationType(String sanitation) {
	try {
		Properties pro = new Properties();

		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("sanitation",pro.getProperty(sanitation));
		eGovOp.scrollpagewithpixel(0, 400);
		eGovOp.clickElement(locator.sanitationTypedropdown(),"Click Sanitation Dropdown");
		eGovOp.clickElement(locator.sanitationType(eGovOp.getRuntimeProps("sanitation")),"Click Sanitation Type");		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@Then("^Enter Length Breadth and Depth")
	public void enterLBD() {
	try {
		
		eGovOp.enterData(locator.enterLength(),"40","Enter Length");
		eGovOp.enterData(locator.enterBreadth(),"10","Enter Breadth");
		eGovOp.enterData(locator.enterDepth(),"20","Enter Depth");

		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@Then("^Enter Length Breadth")
	public void enterLB() {
	try {
		
		eGovOp.enterData(locator.enterLength(),"40","Enter Length");
		eGovOp.enterData(locator.enterBreadth(),"10","Enter Breadth");
		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	@And("^Select Vehicle Type \"(.*)\"$")
	public void selectVehicleType(String vehicletype) {
	try {
		Properties pro = new Properties();

		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("vehicletype",pro.getProperty(vehicletype));
		eGovOp.scrollpagewithpixel(0, 300);
		
		eGovOp.clickElement(locator.vehicleDropdown(),"Click on vehicle Dropdown");
		eGovOp.clickElement(locator.selectvehicleType(eGovOp.getRuntimeProps("vehicletype")),"Select Vehicle Type");		
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@And("^Click Submit Application button")
	public void submitApplication() {
	try {		
		eGovOp.clickElement(locator.submitApplication(),"Click on Submit Application");
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@Then("^Check Application Number")
	public void checkcomplaintnumber1() {
		try {
			 ApplicationNum=eGovOp.getElementText(locator.applicationNumber(),"get Application number");
				eGovOp.writeApplicationNumber(ApplicationNum);

			if(ApplicationNum==null)
			{
			eGovOp.assertbyboolean(true,false,"Application number not genrated");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click Search Application")
	public void searchApplication() {
	try {		
		eGovOp.clickElement(locator.searchApplication(),"Click on Search Application");
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@And("^Check final Status")
	public void finalStatus() {
	try {		
		boolean status=eGovOp.isdisplay(locator.selectsubtype("Completed Request"), "check Enter application or number Text");
		if(!status)
		{
		eGovOp.assertbyboolean(true,false, " Assert Fail Result Message");	
		}
	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	// End of the Editor Creator Region 
	
	// Start Employee Editor Region

	@When("^Select Employee fsm")
	public void clickEmpFsm() {
		try {
			eGovOp.clickElement(locator.selectFsm(), "Select FSM");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click on Inbox")
	public void clickinbox() {
		try {
			eGovOp.clickElement(locator.inboxlabel(), "Click on Inbox");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Enter Application Number")
	public void enterApplicationNumber() {
	try {
		String number=eGovOp.readApplicationNumber();
		//eGovOp.clickElement(locator.applicationoInput(), "Select FSM");
		eGovOp.enterData(locator.applicationoInput(),number,"Enter Application Number");
		
	} catch (Exception e) {
		e.getStackTrace();
	}
}
	
	@And("^Click on Application Number")
	public void applicationNumber() {
		try {
			String number=eGovOp.readApplicationNumber();
			System.out.print(number);

			eGovOp.clickElement(locator.comliantnum(number), "Click on Application Number");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click on Assign DSO")
	public void assignDSO() {
		try {
			eGovOp.clickElement(locator.assignDSO(), "Click on Assign DSO");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Click On DSO from dropdown")
	public void clickonDsodropdown() {
		try {
			eGovOp.clickElement(locator.dsoDropdownfeild(), "Click droopdown field");
			eGovOp.clickElement(locator.selectDSO(), "Click On Select DSO");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Select Locality By Editor")
	public void selectLocalityEditor() {
		try {
			eGovOp.scrollpagewithpixel(0,650);
			try
			{
				Thread.sleep(1000L);
			}
			catch(Exception e)
			{
				
			}
		eGovOp.clickElement(locator.localityDropdownEditor(),"Click dropdown");
		try
		{
			Thread.sleep(1000L);
		}
		catch(Exception e)
		{
		
		}
		eGovOp.implicitWait(5, "wait for element");
		eGovOp.clickElement(locator.localitySubSelectionbyEdiotor(),"Click subtype");
		}catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Enter Wrong Application Number \"(.*)\"$")
	public void enterWrongApplicationNumber(String Invalid) {
	try {
		//eGovOp.clickElement(locator.applicationoInput(), "Select FSM");
		eGovOp.enterData(locator.applicationoInput(),Invalid,"Enter Application Number");
		
	} catch (Exception e) {
		e.getStackTrace();
	}
}
	
@And("^Verify Wrong Application Search Result")
	public void verifyWrongappSearchResult() {
	try {
		
		boolean status=eGovOp.isdisplay(locator.applicationnotfoundTxt(), "check next button disabled ");
		eGovOp.assertbyboolean(true,status, " Assert Fail");	
		
	} catch (Exception e) {
		e.getStackTrace();
	}

	}

@And("^Verify Enter Search Result")
public void verifyEntrtSearchResult() {
try {
	String validnum=eGovOp.readApplicationNumber();
	boolean status=eGovOp.isdisplay(locator.verfyresult(validnum), "check Complaint search  result ");
	if(!status)
	{
	eGovOp.assertbyboolean(true,false, " Assert Fail");	
	}
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Select FSM Locality")
public void selectLocality() {
	try {
	eGovOp.scrollpagewithpixel(0, 100);
	eGovOp.clickElement(locator.dropDownfieldEmp(3),"Click dropdown");
	
	try
	{
		Thread.sleep(1000L);
	}
	catch(Exception e)
	{
		
	}
	eGovOp.wait_short_element_visib(locator.localitySubSelection(), "wait for element");
	eGovOp.clickElement(locator.localitySubSelection(),"Click subtype");
	eGovOp.wait_short_element_visib(locator.selectedLocality(), "wait for element");
	}catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Select Status Options")
public void selectStatus() {
	
	try {
		/*
		 * eGovOp.scrollpagewithpixel(0,650); try { Thread.sleep(1000L); }
		 * catch(Exception e) {
		 * 
		 * }
		 */		
		eGovOp.scrollToElement(locator.dropDownfieldEmp(3));
       String arr[]= {"","DSO Rejected","Pending for DSO Assignment","Application Created","Pending for DSO Approval","DSO InProgress"};
	for(int i=1;i<6;i++) 
	{
		if(i==4)
		{
			boolean morepotion=eGovOp.isdisplay(locator.clickonmore(), "Check More Option");
			if(morepotion)
			{
				eGovOp.clickElement(locator.clickonmore(), "Click on More Option");
			}
		}
			eGovOp.hoverOverclick(locator.selectstatus(i));
			eGovOp.implicitWait(1, "wait");
			
		String cuurentStatus=eGovOp.elementisNotPresnet(locator.currentStatus(4), "Current Status");
		System.out.println("Current Status"+cuurentStatus +"And Acutual "+arr[i]);
		if(!arr[i].equals(cuurentStatus))
		{
			
			eGovOp.assertbyboolean(true, false, "Check Status");
	    }
		eGovOp.hoverOverclick(locator.selectstatus(i));
		eGovOp.implicitWait(1, "wait");
		}
		
	
	
	}catch (Exception e) {
		e.getStackTrace();
	
	}
}


@And("^Check Result Message")
public void verifycomSearchResult() {
try {
	
	boolean status=eGovOp.isdisplay(locator.enterdatamsg(), "check Enter application or number Text");
	if(!status)
	{
	eGovOp.assertbyboolean(true,false, " Assert Fail Result Message");	
	}
	
} catch (Exception e) {
	e.getStackTrace();
}
}


@Then("^Click On Update Application")
public void updateApplication() {
try {
	
	eGovOp.clickElement(locator.updateApplication(), "Click On Update Application");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@Then("^Click On Update Application button")
public void updateApplicationbutton() {
try {
	
	eGovOp.clickElement(locator.eGovNext(), "Click On Update Application Button");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Click on Re-Assign DSO")
public void reassignDso() {
try {
	
	eGovOp.clickElement(locator.updateApplication(), "Click On Re-assign DSO");
	
} catch (Exception e) {
	e.getStackTrace();
}
}


@And("^Enter Reason For Re-assign \"(.*)\"$")
public void reasonreassign(String reason) {
try {
	Properties pro = new Properties();

	FileInputStream fileLoc = new FileInputStream(outputFile);
	pro.load(fileLoc);
	eGovOp.setRuntimeProps("reason",pro.getProperty(reason));
	
	eGovOp.clickElement(locator.dropdownfield("3"), "Re-assign reason dropdown field");
	eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("reason")), "Re-assign reason dropdown field");

	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Re Assign DSO and Date")
public void reassignDSO() {
try {
	
	eGovOp.clickElement(locator.dropdownfield("4"), "Select DSO dropdown field");
	eGovOp.clickElement(locator.selectDSO(), "select DSO");
	eGovOp.hoverOverclick(locator.svgCalender(1));
	eGovOp.clickElement(locator.svgCalender(1), "Click");
	eGovOp.Enter(locator.svgCalender(1));
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Re Re Assign DSO and Date")
public void rereassignDSO() {
try {
	
	eGovOp.clickElement(locator.dropdownfield("5"), "Select DSO dropdown field");
	eGovOp.clickElement(locator.selectDSO(), "select DSO");
	eGovOp.hoverOverclick(locator.svgCalender(1));
	eGovOp.clickElement(locator.svgCalender(1), "Click");
	eGovOp.Enter(locator.svgCalender(1));
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Click On Print Recipt")
public void printReceipt() {
try {
	String parentWindow = eGovOp.getCurrentWindow();
	eGovOp.clickElement(locator.printReceipt(), "Click On Print Recipt");
    try
    {
    	Thread.sleep(4000);
    }
    catch(InterruptedException e)
    {
    	
    }
	eGovOp.switchToOldWindow(parentWindow);
	
} catch (Exception e) {
	e.getStackTrace();
}
}

// End Of Employee Editor Region

//Start Of Employee Collector Region


@Then("^Click Collect Payment")
public void collectPayment() {
	try {
		eGovOp.clickElement(locator.collectPayement(), "Click Collect Payment");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Click Collect Payment button")
public void collectButton() {
try {
	eGovOp.clickElement(locator.collectPaymentButton(), "Click Collect Payment button");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@When("^Select Cheque and Enter Details")
public void enterDate() {
try {

	eGovOp.clickElement(locator.chequeRadioButton(), "Cheque Radio Button");
	eGovOp.enterData(locator.chequeNumberfield(),"123456","Cheque Number");
	eGovOp.hoverOverclick(locator.svgCalender(1));
	eGovOp.clickElement(locator.svgCalender(1), "Click");
	eGovOp.Enter(locator.svgCalender(1));
	eGovOp.enterData(locator.ifscCodefield(),"ICIC0006561","Enter IFSC Code");	
	eGovOp.clickElement(locator.searchIcon(), "Click on Search Icone");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@When("^Select Card and Enter Details")
public void cardDetails() {
try {

	eGovOp.clickElement(locator.creditdebitRadiobutton(),"Cheque Radio Button");
	eGovOp.enterData(locator.inputfield("1"),"4545","Last Card digit");
	eGovOp.enterData(locator.inputfield("2"),"123456","Enter Transaction Number");
	eGovOp.enterData(locator.inputfield("3"),"123456","Confirm Transaction Number");

	
} catch (Exception e) {
	e.getStackTrace();
}
}


@And("^Change Language")
public void changeLanguageFsm() {
try {
	eGovOp.clickElement(locator.clickonLangaeoption(),"Click on English to chnage language");
	eGovOp.clickElement(locator.hindilanguageFsm(),"Click on Himdi");
	eGovOp.clickElement(locator.clickonLangaeoptionHindi(),"Click on Himdi to chnage language");
	eGovOp.clickElement(locator.englishlanguageFsm(),"Click on English");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Enter Payer Details")
public void paidBy() {
try {
	eGovOp.wait_short_element_visib(locator.payerdetails(), "");
	eGovOp.scrollToElement(locator.payerdetails());
	eGovOp.clickElement(locator.dropdownfield("3"),"Click on dropDownfield");
	eGovOp.clickElement(locator.selectfromDropdown("Other"),"Click on other");
	eGovOp.enterData(locator.payername(),"Test Payer","Click on dropDownfield");
	eGovOp.enterData(locator.payerMobile(),"9999999999","Click on dropDownfield");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Enter GEN Receipt Number")
public void genRecieptNumber() {
try {
	eGovOp.enterData(locator.GenReciptNumber(),"GEN1","Enter GEN Receipt Number");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Click on Genrate Receipt")
public void genrateReceipt() {
try {
	eGovOp.clickElement(locator.genrateReceipt(), "Click on Genrate Receipt");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@Then("^Check Receipt number")
public void checkRecepitNumber() {
	try {
		 String ReceiptNum=eGovOp.getElementText(locator.receiptField(),"Check Receipt number");
		 System.out.print(ReceiptNum);
		if(ReceiptNum==null)
		{
		eGovOp.assertbyboolean(true,false,"Check Receipt number not genrated");
		}
	} catch (Exception e) {
		e.getStackTrace();
	}
}


//End Of Employee Collector region 

// Start OF DSO Region

@When("^Click On DSO Login")
public void dsoLogin() {
	try {
		eGovOp.scrollToElement(locator.dsoLogin());
		eGovOp.clickElement(locator.dsoLogin(), "Click On DSO Login");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@Then("^Click On DSO Dashboard")
public void dsoDashboard() {
	try {
		eGovOp.scrollToElement(locator.dsoDashboard());
		eGovOp.clickElement(locator.dsoDashboard(), "Click On DSO Dashboard");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Click On DSO Inbox")
public void dsoInbox() {
	try {
		eGovOp.clickElement(locator.inboxlabel(), "Click On DSO Inbox");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@Then("^Click On Assign Vehicle")
public void assignVehicle() {
	try {
		eGovOp.clickElement(locator.assignVehicle(), "Click On Assign Vehicle");
	} catch (Exception e) {
		e.getStackTrace();
	}
}
@And("^Click On Vehicle Number from dropdown")
public void clickonVehicledropdown() {
	try {
		eGovOp.clickElement(locator.firstdropdownfield(), "Click On Vehicle Number from dropdown");
		String VehicleNum=eGovOp.getElementText(locator.VehicleRegNo(), "Get Vehicle Number and Store");
		eGovOp.writeVehicleNumber(VehicleNum);
		eGovOp.clickElement(locator.VehicleRegNo(), "Click On Vehicle Number");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Click On Complete Request")
public void completeRequest() {
	try {
		eGovOp.clickElement(locator.completeRequest(), "Click On Complete Request");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Choose Date and Waste Collected")
public void dateAndWastecollected() {
	try {
		eGovOp.hoverOverclick(locator.svgCalender(1));
		eGovOp.clickElement(locator.svgCalender(1), "Click");
		eGovOp.Enter(locator.svgCalender(1));
		
		eGovOp.enterData(locator.wastecollected(), "30", "Enter Collected Waste");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@Then("^Click On Complete button")
public void clickCompletebutton() {
	try {
		eGovOp.clickElement(locator.assignbutton(), "Click On complete button");
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@Then("^Click On Decline Request")
public void clickdeclineReuest() {
	try {
		eGovOp.clickElement(locator.declineRequest(), "Click on Decline Request");		
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Choose Decline Reason \"(.*)\"$")
public void declinewithdetails(String reason) {
	try {
		Properties pro = new Properties();

		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("reason",pro.getProperty(reason));
		eGovOp.clickElement(locator.selectcitydropdown(), "Click on Dropdown");		
		eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("reason")), "Click on Decline Request");		
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Enter Comment")
public void entercomment() {
	try {
    eGovOp.enterData(locator.Entercomments(), "Test Comment", "Comment");
	} catch (Exception e) {
		e.getStackTrace();
	}
}



@Then("^Click On Decline Request button")
public void declinerequestButton() {
	try {
		eGovOp.clickElement(locator.assignbutton(), "Click on Decline Request Button");		
	} catch (Exception e) {
		e.getStackTrace();
	}
}


//End Of DSO Region

// Start FSTPO Region 

@When("^Enter DSO Name and Vehicle")
public void dsoanvechicle() {
try {		
	String vehicleNum=eGovOp.readVehicleNumber();
	eGovOp.enterData(locator.vehicleNumField(),vehicleNum,"Enter Vehicle Number");
	eGovOp.enterData(locator.dsoNameField(),"ABC1 DS services","Enter DSO Name");
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Click Vehicle Log")
public void vehicleLog() {
try {	
	String vehicleNum=eGovOp.readVehicleNumber();
	eGovOp.enterData(locator.vehicleNumField(),vehicleNum,"Enter Vehicle Number");
	eGovOp.clickElement(locator.searchButton(),"Click on Search");
	eGovOp.clickElement(locator.vehicleinLog(),"Click on Vehicle Log");

} catch (Exception e) {
	e.getStackTrace();
}
}

@When("^Enter Vehicle In Time")
public void vehicleTime() {
try {

    eGovOp.enterData(locator.vehicleinTime(),"1010","Enter Vehicle In Time");
	eGovOp.SelectfromDropdown(locator.selectInAmPm(), "AM");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Enter Vehicle Out Time")
public void vehicleoutTime() {
try {
   
	eGovOp.enterData(locator.vehicleoutTime(),"1100","Enter Vehicle In Time");
	eGovOp.SelectfromDropdown(locator.selectOutAmPm(), "AM");
	
} catch (Exception e) {
	e.getStackTrace();
}
}

@Then("^Click Submit button")
public void submitButton() {
try {		
	eGovOp.scrollToElement(locator.eGovNext());	
eGovOp.clickElement(locator.eGovNext(),"Click on Submit Button");
} catch (Exception e) {
e.getStackTrace();
   }
}

// End Of FSTPO Region

// Start Admin Region

@Then("^Click On Reject")
public void cancelrequest() {
try {		
	eGovOp.clickElement(locator.updateApplication(),"Click On Cancle Request");
} catch (Exception e) {
	e.getStackTrace();
}
}

@And("^Select Reason \"(.*)\"$")
public void cancleReason(String reason) {
try {		
	Properties pro = new Properties();

	FileInputStream fileLoc = new FileInputStream(outputFile);
	pro.load(fileLoc);
	eGovOp.setRuntimeProps("reason",pro.getProperty(reason));
	eGovOp.clickElement(locator.dropdownfield("3"),"Click On dropdpwm");
	eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("reason")), "Click on Decline Request");		

} catch (Exception e) {
	e.getStackTrace();
}
}

@Then("^Click On Send Back")
public void clicksendBack() {
try {		
	eGovOp.clickElement(locator.sendBack(),"Click On Send Back");

} catch (Exception e) {
	e.getStackTrace();
}
}

@Then("^Click On Cancel Request")
public void canclerequest() {
try {		
	eGovOp.clickElement(locator.requestCancle(),"Click On Cancel Request");

} catch (Exception e) {
	e.getStackTrace();
}
}

@Then("^Click On Send Back button")
public void sendback() {
	try {
		eGovOp.clickElement(locator.assignbutton(), "Click on Decline Request Button");		
	} catch (Exception e) {
		e.getStackTrace();
	}
}

@And("^Select Status \"(.*)\"$")
public void selectfilterStatus(String status) {
	try {	
		Properties pro = new Properties();

		FileInputStream fileLoc = new FileInputStream(outputFile);
		pro.load(fileLoc);
		eGovOp.setRuntimeProps("status",pro.getProperty(status));
		
		
	      Map<String,Integer> map=new HashMap<>();
	        map.put("Pending for DSO Assignment",2);
	        map.put("DSO InProgress",3);
	        map.put("Pending for DSO Approval",5);
	        map.put("DSO Rejected",6);
	        
	        
			eGovOp.scrollToElement(locator.dropDownfieldEmp(3));
			eGovOp.implicitWait(2, "wait");
			if(map.get(status)>3)
			{
				eGovOp.clickElement(locator.clickonmore(), "Click on More");
				eGovOp.hoverOverclick(locator.selectstatus(map.get(eGovOp.getRuntimeProps("status"))));
			}
			else
			{
			eGovOp.hoverOverclick(locator.selectstatus(map.get(eGovOp.getRuntimeProps("status"))));
			}

			
		String cuurentStatus=eGovOp.elementisNotPresnet(locator.currentStatus(4), "Current Status");
		if(!status.equals(cuurentStatus))
		{
			eGovOp.assertbyboolean(true,false, " Assert Status Fail Result Message");	
	    }	
		else
		{
			eGovOp.scrollToElement(locator.homeBreadcrumb());
	    }
		
	
	
	}catch (Exception e) {
		e.getStackTrace();
	}
}
/*
 * @After public void eGovgoCloseApp() { try { DriverUtil.closeDriver(); } catch
 * (Exception e) { e.getStackTrace(); } }
 */
 

}


