package stepDefinition;

import static org.testng.Assert.assertEquals;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.testng.Assert;
import org.testng.annotations.BeforeClass;
import org.yaml.snakeyaml.Yaml;
import cucumber.api.CucumberOptions;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import utilities.BaseTests;
import utilities.DriverUtil;
import utilities.Log;
import yamlPojo.LogConfiguration;
import yamlPojo.Pages;
import yamlPojo.Location;


@CucumberOptions(features = { "src/test/java/features/FSM" }, glue = { "stepDefinition/" }, monochrome = true, tags = {
		"@pgr1" }, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
				"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })

public class yamlTestRunner extends AbstractTestNGCucumberTests implements BaseTests {
	//protected WebDriver driver;


	
	elementLocators locator = new elementLocators();
	String recId;
	String complaintnum="";
	boolean home;
	public static Map<String, Object> yamlMap = null;

	@When("^Execute tax payment form from \"(.*)\"$")
	public void readYml(String fileName) {

		LogConfiguration config = null;
		boolean terminateFlag = false;
		Yaml yaml = new Yaml();
		try (InputStream in = new FileInputStream(
				System.getProperty("user.dir") + "/src/test/java/features/" + fileName)) {
			config = yaml.loadAs(in, LogConfiguration.class);
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		Location Location[] = config.getLocation();
		Pages[][] Pages = Location[0].getPages();
		int NofPages = Location[0].getPages().length;
		Log.Comment("No. of Screens:\t" + NofPages);
		Log.Comment("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		for (int i = 0; i < NofPages; i++) {
			String titleVal = null;
			String[] fieldName = null;
			String screenTitle = eGovOp.getElementText(locator.resProp(), "Check the title of the screen");
			//System.out.println(i + ": Title Name from UI:\t" + screenTitle);
			int fieldCnt = Pages[i].length;
			titleVal = Pages[i][0].getTitlename();
			for (int j = 1; j < fieldCnt; j++) {
				terminateFlag = false;
				fieldName = Pages[i][j].getFieldtype();
								
				//System.out.println("Title Name from YAML:\t" + titleVal);
				if (screenTitle != null && titleVal != null && screenTitle.contains(titleVal)) {
					// System.out.println(i+","+j+","+screenTitle+": Title Name as Expected:\t" +
					// titleVal);
					if (fieldName[0].contains("radio")) {
						radioAction(fieldName[1], fieldName[2]);
					} else if (fieldName[0].contains("text")) {
						fieldAction(fieldName[2], fieldName[1]);
					} else if (fieldName[0].contains("dropdown")) {
						dropdownAction(fieldName[2], fieldName[1]);
					} else if (fieldName[0].contains("file")) {
						uploadFileAction(fieldName[1]);
					} else if (fieldName[0].contains("checkbox")) {
						checkboxAction(fieldName[1]);
					} else if (fieldName[0].contains("skip")) {
						skipButton(fieldName[1]);
						// Log.Comment("Click on Skip and continue for screen: " + screenTitle);
						terminateFlag = true;
						break;
					}
					if (j + 1 == fieldCnt) { //Reached end-of field iteration at Pages
						terminateFlag = true;
						nextSreen();
						break;
					}
				} else if (screenTitle == null) { //Don't iterate as the UI header title=Null
					terminateFlag = true;
					break;
				} else {
					// do nothing
				}
				if (terminateFlag) { //Reached end-of field iteration at Pages
					break;
				}
			} // End of Page Loop
			if (terminateFlag && screenTitle == null) { //
				// Log.Comment(i+","+NofPages+","+"Execution Completed!");
				break;
			} else if (terminateFlag) {
				screenTitle = null;
				// Log.Comment(i+","+NofPages+","+"Next screen, in-Progress..");
				i = -1;
			}
		} // End of Location Loop
	}

	
	
	

	@BeforeClass
	public void eGovlauncher() {
		try {
			DriverUtil.getDefaultDriver();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	 

	@When("^Select Create Property tax")
	public void eGovCreatePT() {
		try {
			eGovOp.clickElement(locator.eGovCreatePT(), "Select the Property Tax");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}


	@When("^Click File Complaint Option")
	public void ClickOnFileComplaintOption() {
		try {
			eGovOp.clickElement(locator.filecomplientlink(), "Click File a Complaint Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^Feed mobile number")
	public void eGovMobile() {
		try {
			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("mobileNumber",pro.getProperty("mobile"));
			eGovOp.enterData(locator.eGovmobile(), eGovOp.getRuntimeProps("mobileNumber"), "Enter Mobile number");
			nextSreen();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Feed mobile number as \"(.*)\"$")
	public void eGovMobile(String mobile) {
		try {
			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("mobileNumber",pro.getProperty(mobile));
			eGovOp.enterData(locator.eGovmobile(), eGovOp.getRuntimeProps("mobileNumber"), "Enter Mobile number");
			nextSreen();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^Feed Pin code")
	public void eGovPin() {
		try {
			eGovOp.enterData(locator.eGovPin1(), "1", "Enter Pin");
			eGovOp.enterData(locator.eGovPin2(), "2", "Enter Pin");
			eGovOp.enterData(locator.eGovPin3(), "3", "Enter Pin");
			eGovOp.enterData(locator.eGovPin4(), "4", "Enter Pin");
			eGovOp.enterData(locator.eGovPin5(), "5", "Enter Pin");
			eGovOp.enterData(locator.eGovPin6(), "6", "Enter Pin");
			nextSreen();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^yml_Go to Next eGov screen")
	public void nextSreen() {
		eGovOp.scrollToElement(locator.eGovNext());
		eGovOp.clickElement(locator.eGovNext(), "Go to next screen");

	}
	
	@When("^Select the language as English")
	public void selectEnglish() {
		try {
			// Thread.sleep(5000);
			eGovOp.clickElement(locator.langEnglish(), "Select the English language before login");
			// Thread.sleep(5000);
			eGovOp.wait_for_text(locator.engButton(), "CONTINUE");
			String buttonName = eGovOp.getElementText(locator.engButton(), "Observe the Button name");
			if (buttonName.contentEquals("CONTINUE")) {
				eGovOp.clickElement(locator.engButton(), "Select the Continue button");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Select the language")
	public void selectlanguage() {
		try {
			// Thread.sleep(5000);
			eGovOp.clickElement(locator.langEnglish(), "Select the English language before login");
			// Thread.sleep(5000);
		//	boolean avail=eGovOp.wait_short_element_visib(locator.loginButton(), "Wait for continue");
				
				do
				{
		    	eGovOp.javascriptclick(locator.langEnglish());

				}
		     	while(!eGovOp.No_wait_element_visib(locator.loginButton(), "Wait for continue"));
						
				eGovOp.clickElement(locator.loginButton(), "Select the Continue button");
			
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
			// eGovOp.clickElement(locator.selectCityElem(), "Select the expected City");
			eGovOp.IteratAndFind(locator.selectCityElem(), city, "Select the expected City");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@When("^Register property tax")
	public void eGovRegister() {
		try {
			eGovOp.scrollToElement(locator.eGovRegist());
			eGovOp.clickElement(locator.eGovRegist(), "Select the Next button to Register Payment Tax");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^yml_Enter details for page \"(.*)\"$")
	public void pageTitle(String title) {
		try {
			String usageType = eGovOp.getElementText(locator.resProp(), "Check the title of the screen");
			if (usageType.contains(title)) {
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^yml_mark radio \"(.*)\" for screen \"(.*)\"$")
	public void radioAction(String val, String info) {
		try {
			boolean initElem = eGovOp.wait_long_element_visib(locator.initPageElem(), "Radio button initial Load");
			if (initElem) {
				for (String radio : locator.radioValues()) {
					boolean usageValue = eGovOp.IteratAndFindRadioNew(radio, val, "Clicked on Radio button:\t" + val);
					if (usageValue) {
						if(eGovOp.wait_short_element_visib(locator.infoParagraphMsg(), "Checking for element")) {
							assertEquals(eGovOp.getElementText(locator.infoParagraphMsg(), "Validate Info Msg"), eGovOp.infoMsg(val ,info));
							System.out.println( val+ " Info Validation is Successful");
						}
						break;
					} else {
					}
				}
			} else {
			}

		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^yml_Click on Checkbox \"(.*)\" for screen \"(.*)\"$")
	public void checkboxAction(String val) {
		try {
			boolean initElem = eGovOp.wait_long_element_visib(locator.initPageElem(), "checkbox initial Load");
			if (initElem) {
				for (String checkbx : locator.checkboxValues()) {
					boolean usageValue = eGovOp.IteratAndFindCheckbox(checkbx, val, "Clicked on checkbox:\t" + val);
					if (usageValue) {
						break;
					} else {
					}
				}
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^yml_enter value as \"(.*)\" at \"(.*)\" for screen \"(.*)\"$")
	public void fieldAction(String testData, String fieldName) {
		try {
			boolean initElem = eGovOp.wait_long_element_visib(locator.initPageElem(), "checkbox initial Load");
			if (initElem) {
				Iterator<Map.Entry<By, By>> itr = locator.fieldValues().entrySet().iterator();
				while (itr.hasNext()) {
					Entry<By, By> entry = itr.next();
					String usageValue = eGovOp.getFieldText(entry.getKey(), "Verify if field is present in Screen");
					if (usageValue != null && usageValue.contentEquals(fieldName)) {
						eGovOp.scrollToElement(entry.getKey());
						System.out.println(fieldName+""+entry.getKey()+""+entry.getValue());
						eGovOp.enterData(entry.getValue(), testData, "Enter Plot field value Content");
						break;
					} else {
					}
				}
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@And("^yml_select \"(.*)\" for dropdown \"(.*)\" for screen \"(.*)\"$")
	public void dropdownAction(String testData, String drpdwnName) {
		try {
			boolean directDropDown = false;
			for (Map.Entry<By, By> fieldPair : locator.dropdownValues().entrySet()) { 
				String usageValue = eGovOp.getFieldText(fieldPair.getKey(), "Verify if field is present in Screen");
				if (usageValue != null && usageValue.contentEquals(drpdwnName)) {
					eGovOp.scrollToElement(fieldPair.getKey());
					eGovOp.pickDDVal(fieldPair.getValue(), locator.dropdownIterate().get(fieldPair.getValue()),
							testData, "Select Dropdown Value as: " + testData);
					break;
				} else if (usageValue == null && drpdwnName == null && directDropDown == false) {
					System.out.println("Looking for Titless Dropdown");
					for (Map.Entry<By, By> ddIterate : locator.dropdownIterate().entrySet()) {
						eGovOp.scrollToElement(ddIterate.getKey());
						directDropDown = eGovOp.pickDDVal(ddIterate.getKey(), ddIterate.getValue(), testData,
								"Select Direct Dropdown Value as: " + testData);
						if (directDropDown)
							break;
					}
				} else {
				}
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@And("^yml_Search for file as \"(.*)\" and the upload file for screen \"(.*)\"$")
	public void uploadFileAction(String fileLoc) {
		try {
			String buttonName = eGovOp.getElementText(locator.eGovUploadFileName(),
					"Check the Upload button name in the screen");
			if (buttonName.contains("Choose")) {
				String fileL = System.getProperty("user.dir") + "/src/test/java/" + fileLoc;
				eGovOp.clickChoose(locator.eGovUploadFile(), fileL, "Click on Upload doc1");
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	@When("^yml_Click on \"(.*)\" button")
	public void skipButton(String skipBtn) {
		try {
			eGovOp.scrollPage();
			String usageType = eGovOp.getElementText(locator.skipButton(), skipBtn + " Button is clicked");
			if (usageType.contains(skipBtn)) {
				eGovOp.clickElement(locator.skipButton(), "Click on Skip and Continue button");
			} else {
			}

		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	
	@Then("^Check complaint number")
	public void checkcomplaintnumber1() {
		try {
			 complaintnum=eGovOp.getElementText(locator.compliantnumber(),"get complaint number");
				eGovOp.writeApplicationNumber(complaintnum);

			if(complaintnum==null)
			{
			eGovOp.assertbyboolean(true,false,"complaint number not genrated");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	
	
	@And("^Click on Take Action")
	public void takeAction() {
		try {
			eGovOp.clickElement(locator.takeActionButton(), "Click on Take Action");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	
	@When("^Enter comment")
	public void enterComment() {
		try {
			System.out.print(complaintnum);
			eGovOp.enterData(locator.Entercomment(), "Test","Enter Comment");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	
	@And("^Navigate Back")
	public void NavigateBack() {
		try {
		
			//eGovOp.wait_for_text(locator.chSystem.out.print("After Click");
			eGovOp.clickElement(locator.backption(), "Click  Back");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	  @And("^Back till Home Page") 
	  public void BacktillHomePage() { 
		  
		  try {
	
		  while(!eGovOp.wait_short_element_visib(locator.filecomplientlink(), "Back Till Homepage"))
		  {
			 
			  eGovOp.javascriptclick(locator.backption());
		  }
		  }
	   catch (Exception e)
	   { e.getStackTrace(); }
	  
	  }
	 

	
	@And("^Verify Application Number")
	public void checkcomplaintnumber() {
		try {
			String applicationNumber=eGovOp.getElementText(locator.applicationNumber(),"Get Application Number");
			System.out.println(applicationNumber);

			if(applicationNumber==null){
				Assert.assertEquals(true,false,"complaint number not genrated");
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}


	

	
	
	@And("^Clear Search")
	public void clearSearch() {
	try {
		
		eGovOp.clickElement(locator.clearSearch(),"Clear Search");
		
	} catch (Exception e) {
		e.getStackTrace();
	}
}
	
	
	
	
	
	
	@And("^Click On Resolve")
	public void clickResolve() {
	try {
		eGovOp.clickElement(locator.resolveByLme(),"Click on Resolve label");

	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@Then("^Click On Resolve button")
	public void resolvebutton() {
	try {
		eGovOp.clickElement(locator.reslovebutton(),"Click on Resolve Button");

	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	
	
	/*
	 * @After public void eGovgoCloseApp() { try { DriverUtil.closeDriver(); } catch
	 * (Exception e) { e.getStackTrace(); } }
	 */
	 
	 
}