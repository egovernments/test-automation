package stepDefinition;
	
import java.io.FileInputStream;
import java.util.Properties;

import org.testng.annotations.BeforeClass;
import org.testng.asserts.SoftAssert;
import cucumber.api.CucumberOptions;
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import junit.framework.Assert;
import utilities.BaseTests;
import utilities.DriverUtil;

	@CucumberOptions(features = { "src/test/java/features/PGR" }, glue = { "stepDefinition/" }, monochrome = true, tags = {
			"@pgr1" }, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
					"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })
	public class PGR_Test_Runner extends AbstractTestNGCucumberTests implements BaseTests {
		//protected WebDriver driver;
		String ApplicationNum="";


		elementLocators locator = new elementLocators();
		
		@BeforeClass
		public void eGovlauncher() {
			try {
				DriverUtil.getDefaultDriver();
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

		// Start Citizen Region
		
		@Then("^Click on Complaint type Radio button")
		public void checkradiobutton() {
			try {
				Properties pro = new Properties();

				String path = System.getProperty("user.dir")+"/src/test/java/TestData";
				 String outputFile = path + "/" + "data" + ".properties";
				
				FileInputStream fileLoc = new FileInputStream(outputFile);
				pro.load(fileLoc);
				eGovOp.setRuntimeProps("CompaintType",pro.getProperty("CompaintType"));
				eGovOp.clickElement(locator.maintype(eGovOp.getRuntimeProps("CompaintType")), "Click on My Complaint Option");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}	


		@And("^Click On Complaint Option")
		public void ClickOnComplaintOption() {
			try {
				eGovOp.clickElement(locator.ComplaintOption(), "Click on Complaint Option");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Click on upload")

		public void clickonuploadicon() {
			try {
				eGovOp.clickElement(locator.uploadfile(), "Click skip and next");
				;
			}
			catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Upload photo and Maxmb photo")
		public void uploadMaxmbimage() {
			try {
				
				Properties pro = new Properties();
				String path = System.getProperty("user.dir")+"/src/test/java/TestData";
				String outputFile = path + "/" + "data" + ".properties";
				
				FileInputStream fileLoc = new FileInputStream(outputFile);
				pro.load(fileLoc);
				eGovOp.setRuntimeProps("file",pro.getProperty("file"));
				
				eGovOp.implicitWait(5, "Wait for Upload document screen load again");
				String blank = System.getProperty("user.dir") + "/src/test/java/TestData/" + eGovOp.getRuntimeProps("file");
				String blankDifferent = System.getProperty("user.dir") + "/src/test/java/TestData/" + "blankDifferent.jpeg";
				String maxSize = System.getProperty("user.dir") + "/src/test/java/TestData/" + "5mb image.jpeg";
				System.out.println("File Location:\t" + blank);
				eGovOp.uploadfile(locator.uploadfile(),locator.nextimageupload(), blank,blankDifferent,maxSize,"File2 upload");
				eGovOp.implicitWait(10, "Observe if the document is uploaded");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Check file large error message")
		public void CheckFileLagemessage() {
			try {
				eGovOp.wait_for_element(locator.filelargeError(), "Wait for element");
				boolean status=eGovOp.verify(locator.filelargeError(),"Check File large error message");
				eGovOp.assertbyboolean(true,status,"Assert Check File large error message Fail");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Upload photo at \"(.*)\"$")
		public void uploadd(String fileLoc) {
			try {
				eGovOp.clickElement(locator.uploadfile(),"Click on Upload");
				eGovOp.implicitWait(5, "Wait for Upload document screen load again");
				String fileL = System.getProperty("user.dir") + "/src/test/java/TestData/" + fileLoc;
				System.out.println("File Location:\t" + fileL);
				eGovOp.uploadData(locator.uploadfile(), fileL, "File2 upload");
				eGovOp.wait_short_element_visib(locator.deleteiamgeicon(),"Wait till Image load");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		

		@And("^Check delete icon")
		public void checkDeleteIcon() {
			try {
				eGovOp.wait_for_element(locator.deleteiamgeicon(), "Wait for element");
				boolean status=eGovOp.verify(locator.deleteiamgeicon()," Verify delete icon");
				eGovOp.assertbyboolean(true,status,"Assert Verify delete icon unable to found Fail");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@Then("^Enter Additional details")
		public void additionaldetails() {
			try {
				eGovOp.uploadData1(locator.provideadditionalDetails(), "Test", "Enter additional details");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@Then("^Enter Citizen Additional details")
		public void additionalcitizenDetails() {
			try {
				eGovOp.uploadData1(locator.enteradditionalDetails(), "Test", "Enter additional details");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@When("^Enter Citizen Landmark")
		public void landmarkCitizen() {
			try {
				eGovOp.enterData(locator.landmark(), "Landmark", "Enter Citizen Landmark");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^Click On File Complaint button")
		public void fileComplaint() {
			try {
				eGovOp.clickElement(locator.eGovNext(), "Click On File Complaint button");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		

		
		@Then("^Click on Complaint Number")
		public void complaintnumber() {
			try {
				String number=eGovOp.readComplaintNumber();
				System.out.print(number);

				eGovOp.clickElement(locator.comliantnum(number), "Click on complaint Number");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@Then("^Check Complaint Number")
		public void checkcomplaintnumber1() {
			try {
				 ApplicationNum=eGovOp.getElementText(locator.applicationNumber(),"get Application number");
					eGovOp.writeComplaintNumber(ApplicationNum);

				if(ApplicationNum==null)
				{
				eGovOp.assertbyboolean(true,false,"Application number not genrated");
				}
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@Then("^Click on Reject button")
		public void rejectButton() {
			try {
				eGovOp.clickElement(locator.rejectgrocompButton(), "Click on Reject button");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		

		@When("^Click On Complaint Assign")
		public void clickonComplaintAssign() {
			try {
				eGovOp.clickElement(locator.assignCompliant(), "Click On Complaint Assign");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		
		@And("^Click On LME from dropdown")
		public void clickonlmedropdown() {
			try {
				eGovOp.clickElement(locator.clickOndropdown(), "Click Odropdown field");
				eGovOp.clickElement(locator.selectLme(), "Click On Complaint Assign");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
		@And("^File upload")
		public void Selectfile() {
		try {
			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("file",pro.getProperty("file"));
			
			String button = eGovOp.getElementText(locator.chooseFilebutton(),
					"Check the Upload button name in the screen");
			if (button.contains("Choose")) {
				String filep = System.getProperty("user.dir") + "/src/test/java/TestData/" + eGovOp.getRuntimeProps("file");
				eGovOp.clickChoose(locator.inputFile(), filep, "Click on Upload doc1");
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
			
		
		
			@When("^Click On Complaint Number Label")
			public void complaintnumlabel() {
			try {
				String number=eGovOp.readComplaintNumber();
				eGovOp.clickElement(locator.complaintnumberlabel(number),"Click On Complaint Number Label");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}	
		
			
			@And("^Citizen Select Ratings and Comment")
			public void selectRatings() {
				try {
					eGovOp.clickElement(locator.starRating(),"Star Rating");
					eGovOp.wait_short_element_visib(locator.ratingcheckboxfield("Services"),"Wait");
					eGovOp.hoverOverclick(locator.ratingcheckboxfield("Services"));
					eGovOp.hoverOverclick(locator.ratingcheckboxfield("Resolution Time"));
					eGovOp.hoverOverclick(locator.ratingcheckboxfield("Quality of Work"));
					eGovOp.hoverOverclick(locator.ratingcheckboxfield("Others"));
					eGovOp.scrollToElementIter(locator.Entercomments());
					eGovOp.enterData(locator.Entercomments(), "Test","Enter comment");
					
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			@And("^Check You Rated Text")
			public void yourated() {
				try {
					
					eGovOp.scrollToElement(locator.enterCitizencomment());
					
					boolean status=eGovOp.isdisplay(locator.youRatedtext(), "check Enter application or number Text");
					
					if(!status)
					{
					eGovOp.assertbyboolean(true,false, " Assert Fail Check You Rated Text");	
					}
					
					
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			
			@And("^Enter Comment and Send")
			public void commentandSend() {
				try {
					eGovOp.scrollToElement(locator.enterCitizencomment());
					eGovOp.enterData(locator.enterCitizencomment(), "Comment", "Enter Comment and Send");
					eGovOp.scrollToElement(locator.eGovNext());
					eGovOp.clickElement(locator.eGovNext(),"Click on Send");
					boolean result=eGovOp.isdisplay(locator.commentsuccessfulpopup(), "Check Comment Successful Popup");
					
					if(!result)
					{
					eGovOp.assertbyboolean(true,false, "Assert Fail Check Comment Successful Popup");	
					}
					
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			@When("^Click on Reopen")
			public void clickonReopen() {
			try {
				eGovOp.scrollToElementIter(locator.citizenReopen());
				eGovOp.clickElement(locator.citizenReopen(),"Click on Reopen");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
			@Then("^Select Reopen Reason")
			public void reopenReason() {
			try {
				eGovOp.clickElement(locator.citizenReopenReason(),"Select Reopen Reason");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

			//END citizen
		// CSR Region Start
			
			
			@And("^Click on New Complaint")
			public void newComplaint() {
			try {
				eGovOp.scrollToElement(locator.inbox());
				eGovOp.clickElement(locator.newComplaint(),"Click on New Complaint");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
			@And("^Select Complaint Type \"(.*)\"$")
			public void selectcomplaintType(String Property) {
				try {
					Properties pro = new Properties();

					String path = System.getProperty("user.dir")+"/src/test/java/TestData";
					 String outputFile = path + "/" + "data" + ".properties";
					
					FileInputStream fileLoc = new FileInputStream(outputFile);
					pro.load(fileLoc);
					eGovOp.setRuntimeProps("Property",pro.getProperty(Property));
					
					eGovOp.scrollpagewithpixel(0,400);
						eGovOp.clickElement(locator.dropdownfield("3"),"Click Complaint Dropdown");
						eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("Property")),"Select complaint");
				}catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			@And("^Select Complaint SubType \"(.*)\"$")
			public void selectcomplaintSubtype(String subProperty) {
				try {
					Properties pro = new Properties();

					String path = System.getProperty("user.dir")+"/src/test/java/TestData";
					 String outputFile = path + "/" + "data" + ".properties";
					
					FileInputStream fileLoc = new FileInputStream(outputFile);
					pro.load(fileLoc);
					eGovOp.setRuntimeProps("Property",pro.getProperty(subProperty));
					
					
						eGovOp.clickElement(locator.dropdownfield("4"),"Click Complaint Subtype Dropdown");
						eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("subProperty")),"Select Subtype complaint");
				}catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			@And("^Enter Citizen Mobile Number")
			public void mobilecCSRNumber() {
			try {
				
				eGovOp.enterData(locator.eGovmobile(),"9999999999","Enter Mobile Number");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
			}

			@And("^Enter Citizen Pincode Number")
			public void entercitizenPincode() {
			try {
				Properties pro = new Properties();

				String path = System.getProperty("user.dir")+"/src/test/java/TestData";
				 String outputFile = path + "/" + "data" + ".properties";
				
				FileInputStream fileLoc = new FileInputStream(outputFile);
				pro.load(fileLoc);
				eGovOp.setRuntimeProps("pincode",pro.getProperty("pincode"));
				eGovOp.scrollpagewithpixel(0, 350);
				eGovOp.enterData(locator.pincodeEC(),eGovOp.getRuntimeProps("pincode"),"Enter Pincode Number");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
			}
			
			@When("^Select Assign to all")
			public void assignToall() {
				try {
					eGovOp.clickElement(locator.assignToallbutton(), "Click on assign to all button");
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			@When("^Enter Complaint Number")
			public void enterCompliantNumber() {
			try {
				
				String validnum=eGovOp.readComplaintNumber();
				eGovOp.enterData(locator.complaintNumField(),validnum,"Enter valid Complaint Number");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
			
			
			@And("^Verify Search Result")
			public void verifycomSearchResult() {
			try {
				String validnum=eGovOp.readComplaintNumber();
				boolean status=eGovOp.isdisplay(locator.verfyresult(validnum), "check Complaint search  result ");
				if(!status)
				{
				eGovOp.assertbyboolean(true,false, " Assert Fail");	
				}
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
			
			
	
			
			@When("^Enter Wrong Mobile Number \"(.*)\"$")
			public void enterWrongMobileNum(String validnum) {
			try {
				
				eGovOp.enterData(locator.mobileNumField(),validnum,"Enter Invalid Complaint Number");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
		
			
			@When("^Enter Wrong Complaint Number \"(.*)\"$")
			public void enterWrongCompliantNumber(String Invalidnum) {
			try {
				
				eGovOp.enterData(locator.complaintNumField(),Invalidnum,"Enter  Invalid Complaint Number");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}

			
			@And("^Verify Wrong Search Result")
			public void verifyWrongcomSearchResult() {
			try {
				
				boolean status=eGovOp.isdisplay(locator.recordnotfoundTxt(), "check next button disabled ");
				eGovOp.assertbyboolean(true,status, " Assert Fail");	
				
			} catch (Exception e) {
				e.getStackTrace();
			}

			}
			
			
			@And("^Clear All")
			public void ClearAll() {
			try {
				
				eGovOp.clickElement(locator.clearAll(),"Clear All");
				
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
			
			@And("^Check and Select Status")
			public void selectStatus() {
				try {
					/*
					 * eGovOp.scrollpagewithpixel(0,650); try { Thread.sleep(1000L); }
					 * catch(Exception e) {
					 * 
					 * }
					 */		
					eGovOp.scrollToElement(locator.localitySubInput(4));
		String arr[]= {"","Pending for assignment","Pending for reassignment","Pending at LME","Rejected","Resolved","Closed after rejection","Closed after resolution","Pending At Supervisor","","Cancelled"};
				for(int i=1;i<11;i++) 
				{
					if(i!=4&&i!=9)
					{
						eGovOp.hoverOverclick(locator.selectstatus(i));
						eGovOp.implicitWait(1, "wait");
					String cuurentStatus=eGovOp.elementisNotPresnet(locator.currentStatus(3), "Current Status");
					System.out.println("Current Status"+cuurentStatus +"And Acutual "+arr[i]);
					if(!arr[i].equals(cuurentStatus))
					{
						
						eGovOp.assertbyboolean(true, false, "Check Status");
				    }
					eGovOp.hoverOverclick(locator.selectstatus(i));
					eGovOp.implicitWait(1, "wait");
					}
					
				}
				
				}catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			
			@And("^Select Compliant Subtype")
			public void selectComplaintSub() {
				try {
					
				eGovOp.clickElement(locator.complaintSubSelectiondropdown(),"Click dropdown");
				try
				{
					Thread.sleep(1000L);
				}
				catch(Exception e)
				{
					
				}
				eGovOp.clickElement(locator.complaintSubSelection(),"Click subtype");
				

				}catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			@And("^Select Locality")
			public void selectLocality() {
				try {
				eGovOp.clickElement(locator.localitySubInput(4),"Click dropdown");
				eGovOp.scrollpagewithpixel(0, 100);
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
			

			
			//CSR Region End
			
         // GRO Region Start
			
			@And("^Click on Reject Complaint")
			public void rejetcCompliant() {
				try {
					eGovOp.clickElement(locator.rejectComplaint(), "Click on reject compliant text");
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			@And("^Select Pending Assignment")
			public void SelectPendingassignment() {
				try {
					eGovOp.scrollpagewithpixel(0,200);
				
					eGovOp.hoverOverclick(locator.selectstatus(1));
					
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
			
			
			
			
			/*
			 * @After public void eGovgoCloseApp() { try { DriverUtil.closeDriver(); } catch
			 * (Exception e) { e.getStackTrace(); } }
			 */
			 

}
