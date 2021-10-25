package stepDefinition;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.testng.annotations.BeforeClass;
import org.yaml.snakeyaml.Yaml;

import cucumber.api.CucumberOptions;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import utilities.BaseTests;
import utilities.DriverUtil;
import utilities.Log;
import yamlPojo.Location;
import yamlPojo.LogConfiguration;
import yamlPojo.Pages;
	
	@CucumberOptions(features = { "src/test/java/features/PGR" }, glue = { "stepDefinition/" }, monochrome = true, tags = {
	"@fsm2" }, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
			"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })

public class Base_Test_Runner extends AbstractTestNGCucumberTests implements BaseTests {
		//protected WebDriver driver;
		elementLocators locator = new elementLocators();	
		String baseUrl="https://uat.digit.org/";
		String empUrl="employee/language-selection";
		String citizenUrl="digit-ui/citizen";
	
		
		@When("^Open new web url \"(.*)\"$")
		public void eGovlauncherEmp(String url) {
			try {
				if (url.equals("employee"))
				{
				System.out.println("Enter employee URL");
			   // eGovOp.deleteAllCookies();
			  eGovOp.getCokkies(locator.chromecache());
				eGovOp.navigateTo(baseUrl+empUrl);
				 try
					{
						Thread.sleep(5000);
					}
					catch(InterruptedException e)
					{
					}
			
				
				  
				
				}
				if (url.equals("citizen"))
				{
					System.out.println("Enter Citizen URL");
			    	//eGovOp.deleteAllCookies();
					 eGovOp.getCokkies(locator.chromecache());
					eGovOp.navigateTo(baseUrl+citizenUrl);
					 try
						{
							Thread.sleep(5000);
						}
						catch(InterruptedException e)
						{
						}
				
					
				}
				
				/* if(eGovOp.wait_short_element_visib(locator.detailsSafe(),""))
				{
					eGovOp.clickElement(locator.detailsSafe(), "");
					eGovOp.clickElement(locator.proceedSafe(), "");
				} */
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
	

		
		@Given("^Enter eGov username as \"(.*)\"$")
		public void enterUsername(String username) {
			
			try {
				Properties pro = new Properties();

				String path = System.getProperty("user.dir")+"/src/test/java/TestData";
				 String outputFile = path + "/" + "credentials" + ".properties";
				
				FileInputStream fileLoc = new FileInputStream(outputFile);
				pro.load(fileLoc);
				eGovOp.setRuntimeProps("loginUser",pro.getProperty(username));
				System.out.print("User Name"+eGovOp.getRuntimeProps("loginUser"));
				
				eGovOp.enterData(locator.usernameElem(), eGovOp.getRuntimeProps("loginUser"), "Enter Username");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		@And("^Enter eGov password")
		public void enterPassword() {
			try {		
				Properties pro = new Properties();

				String path = System.getProperty("user.dir")+"/src/test/java/TestData";
				 String outputFile = path + "/" + "data" + ".properties";
				
				FileInputStream fileLoc = new FileInputStream(outputFile);
				pro.load(fileLoc);
				eGovOp.setRuntimeProps("loginPassword",pro.getProperty("password"));
				
				eGovOp.enterData(locator.passwordElem(), eGovOp.getRuntimeProps("loginPassword"), "Enter Password");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		
		
	@And("^Employee Logout and Close")
	public void goCloseApp() {
		try {
			eGovOp.clickElement(locator.profileicon(),"Click on Profile");
			eGovOp.clickElement(locator.logout(),"Click on Logout");
			 try
				{
					Thread.sleep(2000);
				}
				catch(InterruptedException e)
				{
				}
		
			
		   // eGovOp.getCloseApp();

		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^eGov Launch Browser")
	public void eGovlauncher() {
		try {
			DriverUtil.getDefaultDriver();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@When("Launch Browser")
	public void launcher() {
		try {
			DriverUtil.getDefaultDriver();
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@And("^Click on Continue to proceed further")
	public void landHomepage() {
		try {
		//	boolean avail=eGovOp.wait_short_element_visib(locator.loginButton(), "Wait for continue");
	//		if(avail)
		//	{
			eGovOp.clickElement(locator.loginButton(), "Select the Continue button to Login");
		//	}
		//	else
		//	{
		//		eGovOp.refreshPage();
		//	}
		} catch (Exception e) {
			e.getStackTrace();
		}
		
	}


		@And("^Logout from eGov and Close")
		public void eGovLogout() {
			try {
				eGovOp.clickElement(locator.burgerIcn(), "Click on Burger Icon");
				eGovOp.clickElement(locator.logOut(), "Click on Logout");
				 try
					{
						Thread.sleep(2000);
					}
					catch(InterruptedException e)
					{
					
					}
				//eGovOp.getCloseApp();
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Change Language and Logout")
		public void changelaguageLogout() {
			try {
				eGovOp.clickElement(locator.burgerIcn(), "Click on Burger Icon");
				eGovOp.clickElement(locator.hindilanguage(), "Click on Logout");
				eGovOp.wait_short_element_visib(locator.Hindilogoutoption(), "Click on Logout");
				eGovOp.clickElement(locator.Hindilogoutoption(), "Click on Logout");
				//eGovOp.getCloseApp();
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Click On Download button")
		public void downloadButton() {
			try {
				eGovOp.clickElement(locator.downloadButton(),"Click On Download");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Click On Download")
		public void download() {
			try {
				eGovOp.clickElement(locator.eGovNext(),"Click On Download");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Click On Back To Homepage button")
		public void backTohomepage() {
			try {
				eGovOp.clickElement(locator.backhomeomePageButton(),"Click On Back to Home Page Button");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Click On Back To Home button")
		public void backTohome() {
			try {
				eGovOp.clickElement(locator.eGovNext(),"Click On Back to Home Button");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		

		

		
		@And("^Verify Citizen Home Page")
		public void homepageverify() {
			try {
			 boolean status=eGovOp.isdisplay(locator.filecomplientlink(), "Check Home Page Complaint Option");
				
			 if(!status)
				{
				eGovOp.assertbyboolean(true,false, " Assert Fail");	
				}
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}


		@And("^Verify Employee Home Page")
		public void employeehomePage() {
			try {
			 boolean status=eGovOp.isdisplay(locator.fsmtext(), "Check Home Page FSM Inbox ");
				
			 if(!status)
				{
				eGovOp.assertbyboolean(true,false, " Assert Fail");	
				}
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Verify PGR Employee Home Page")
		public void employeepgrhomePage() {
			try {
			 boolean status=eGovOp.isdisplay(locator.Complainttext(), "Check Home Page FSM Inbox ");
				
			 if(!status)
				{
				eGovOp.assertbyboolean(true,false, " Assert Fail");	
				}
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		
		@And("^Verify Employee Inbox Page")
		public void employeeinboxPage() {
			try {
			 boolean status=eGovOp.isdisplay(locator.fsmfulltext(), "Check Home Page FSM full Text ");
				
			 if(!status)
				{
				eGovOp.assertbyboolean(true,false, " Assert Fail");	
				}
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		// Start Region Citizen 
		
		
		@And("^check SubType Radio button \"(.*)\"$")
		public void checksubcomplaintRadioButton(String subtype) {	
			try
			{
			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("subtype",pro.getProperty(subtype));
			
			
			eGovOp.clickElement(locator.radiobuttonsubtype(eGovOp.getRuntimeProps("subtype"))," Sub Complaint radio button");
			
			} catch (Exception e) {
				e.getStackTrace();
			}
			
			}	
		
		
		@When("^Click On Take Action button")
		public void takeactioncoll() {
			try {
				eGovOp.clickElement(locator.takeactionColl(), "Click On Take Action button");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		@Then("^Click On Assign button")
		public void clickonassignbutton() {
			try {
				eGovOp.clickElement(locator.assignbutton(), "Click On assign button");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
       //End Citizen Region
		// Start LME Region
		@And("^Click LME Pendig Filter")
		public void lmePending() {
		try {
			eGovOp.scrollpagewithpixel(0,250);
			eGovOp.hoverOverclick(locator.pendingToLmebox());

			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
		
		@And("^Reassign By LME")
		public void reassignBylme() {
		try {
			eGovOp.clickElement(locator.reassignByLme(),"Click on dropdown");

			
		} catch (Exception e) {
			e.getStackTrace();
		}
		}
		
		@And("^Reassign to GRO")
		public void reassigntogro() {
		try {
			eGovOp.clickElement(locator.clickOndropdown(),"Click on dropdown");
			eGovOp.clickElement(locator.reassignTogro(),"Reassign to EMP GRO");	
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
		
		//Start Employee region
		@And("^Select City")
		public void selectCity() {
			try {
				Properties pro = new Properties();

				String path = System.getProperty("user.dir")+"/src/test/java/TestData";
				 String outputFile = path + "/" + "data" + ".properties";
				
				FileInputStream fileLoc = new FileInputStream(outputFile);
				pro.load(fileLoc);
				eGovOp.setRuntimeProps("city",pro.getProperty("city"));
				 eGovOp.clickElement(locator.selectcity(eGovOp.getRuntimeProps("city")), "Select the expected City");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		//PGR Empolye filter\"(.*)\"$
		
		@And("^Check filter and Select Application \"(.*)\"$")
		public void selectStatus(String status) {
			try {	
			      Map<String,Integer> map=new HashMap<>();
			        map.put("Pending for assignment",1);
			        map.put("Pending for reassignment",2);
			        map.put("Pending at LME",3);

			       
				eGovOp.scrollToElement(locator.localitySubInput(4));
				String pendingAssign="Pending for assignment";
	
					eGovOp.hoverOverclick(locator.selectstatus(map.get(status)));
					eGovOp.implicitWait(1, "wait");
				String cuurentStatus=eGovOp.elementisNotPresnet(locator.currentStatus(3), "Current Status");
				if(pendingAssign.equals(cuurentStatus))
				{
					
					eGovOp.scrollToElement(locator.complaintNumField());
			    }			
			
			
			}catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Click on Home Option Top")
		public void homeOption() {
		try {
			eGovOp.scrollPageUp();
			eGovOp.clickElement(locator.homeBreadcrumb(),"Click on Home Option Top");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
		}
		// Inbox Field
		
		@And("^Enter Mobile Number \"(.*)\"$")
		public void enterMobileNum(String validnum) {
		try {
			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("validnum",pro.getProperty(validnum));
			eGovOp.wait_long_element_visib(locator.mobileNumField(), "wait");
			eGovOp.enterData(locator.mobileNumField(),eGovOp.getRuntimeProps("validnum"),"Enter valid Complaint Number");

			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
		
		@Then("^Click On Search")
		public void clickSearch() {
		try {
			
			eGovOp.clickElement(locator.searchButton(),"Click Search");
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	// Collector Creator Collector
	
	@And("^Select Pending for Payment Status")
	public void selectStatus() {
		
		try {
			
			eGovOp.scrollToElement(locator.localitySubInput(3));
	       String arr[]= {"","Pending for Payment"};
		
				eGovOp.hoverOverclick(locator.selectstatus(1));
				eGovOp.implicitWait(1, "wait");
				
			String cuurentStatus=eGovOp.elementisNotPresnet(locator.currentStatus(4), "Current Status");
			System.out.println("Current Status"+cuurentStatus +"And Acutual "+arr[1]);
			if(!arr[1].equals(cuurentStatus))
			{
				
				eGovOp.assertbyboolean(true, false, "Check Status");
		    }
			else
			{
				eGovOp.scrollToElementIter(locator.homeBreadcrumb());
			}
		
		
		}catch (Exception e) {
			e.getStackTrace();
		
		}}
	
	@And("^Click on compliant icon")
	public void complianticon() {
		try {
			
				eGovOp.clickElement(locator.complianticon(), "Click on compliant icon");
		
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	@When("^Click on Next button")
	public void clickonnextbutton() {
		
	
		try {
			eGovOp.scrollToElement(locator.nextbutton());
			eGovOp.clickElement(locator.nextbutton(), "Click on Nedxt Option");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	}


