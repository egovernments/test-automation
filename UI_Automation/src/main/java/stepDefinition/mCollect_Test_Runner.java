
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
import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.api.testng.AbstractTestNGCucumberTests;
import utilities.BaseTests;
import utilities.DriverUtil;

@CucumberOptions(features = { "src/test/java/features/mCollect" }, glue = { "stepDefinition/" }, monochrome = true, tags = {
		"@mCollect7" }, plugin = { "pretty", "html:target/cucumber-reports/cucumber-pretty",
				"json:target/cucumber-reports/CucumberTestReport.json", "rerun:target/cucumber-reports/rerun.txt" })
public class mCollect_Test_Runner extends AbstractTestNGCucumberTests implements BaseTests {
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
	
	
	
	// Start Counter Empolyee Region
	
	
	@And("^Click on mCollect option")
	public void mcollectoption() {
		try {
			  
			 try
				{
					Thread.sleep(3000);
				}
				catch(InterruptedException e)
				{
				}		
			 eGovOp.implicitWait(1, "");
			 eGovOp.clickElement(locator.mCollectctext(), "Click on mCollect option");
			 eGovOp.implicitWait(3, "");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Enter Consumer Name")
	public void consumerName() {
		try {
			eGovOp.enterData(locator.consumerName(), "Test","Enter Consumer Name");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Enter Door Number")
	public void doorNum() {
		try {
			eGovOp.enterData(locator.doorNo(), "12","Enter Door Number");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@And("^Enter Street Name")
	public void street() {
		try {
			eGovOp.enterData(locator.street(), "T1","Enter Street Name");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	@And("^Enter Building Number")
	public void buildingName() {
		try {
			eGovOp.enterData(locator.buildingName(), "B1","Enter Building Number");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
		
		
		@And("^Enter Pincode")
		public void Enterpin() {
			try {
				eGovOp.scrollToElement(locator.doorNo());
				eGovOp.enterData(locator.pincode(), "143001","Enter pincode");
			} catch (Exception e) {
				e.getStackTrace();
			}
		}
			
			
	@And("^Select Service Category \"(.*)\"$")
			public void serviceCategory(String category) {
				try {
					Properties pro = new Properties();

					String path = System.getProperty("user.dir")+"/src/test/java/TestData";
					 String outputFile = path + "/" + "data" + ".properties";
					
					FileInputStream fileLoc = new FileInputStream(outputFile);
					pro.load(fileLoc);
					eGovOp.setRuntimeProps("category",pro.getProperty(category));
					eGovOp.scrollToElement(locator.inputfield(8));
					eGovOp.clickElement(locator.inputfield(9),"Click Select Serviece Category");
					eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("category")),"Select Serviece Category");
					
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
				
	@And("^Select Service Type \"(.*)\"$")
				public void serviceType(String Type) {
					try {
						Properties pro = new Properties();

						String path = System.getProperty("user.dir")+"/src/test/java/TestData";
						 String outputFile = path + "/" + "data" + ".properties";
						
						FileInputStream fileLoc = new FileInputStream(outputFile);
						pro.load(fileLoc);
						eGovOp.setRuntimeProps("Type",pro.getProperty(Type));
						
						eGovOp.clickElement(locator.inputfield(10),"Click Select Serviece Type");
						eGovOp.enterData(locator.inputfield(10),eGovOp.getRuntimeProps("Type"), "Click On Service category dropdown");
						eGovOp.clickElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("Type")),"Select Serviece Type");
						
					} catch (Exception e) {
						e.getStackTrace();
					}
				}
	
	             @And("^Select From and To Date")
					public void selectDates() {
						try {
							eGovOp.clickElement(locator.svgCalender(1), "Click");
							eGovOp.hoverOverclick(locator.svgCalender(1));
							eGovOp.Enter(locator.svgCalender(1));
							
							eGovOp.clickElement(locator.svgCalender(2), "Click");
							eGovOp.hoverOverclick(locator.svgCalender(2));
							eGovOp.PressRightEnter(locator.svgCalender(2));
						} catch (Exception e) {
							e.getStackTrace();
						}
					}
					
						@And("^Enter Tax")
						public void entertax() {
							try {
								eGovOp.scrollToElement(locator.Tax());		
								eGovOp.enterData(locator.Tax(),"1000","Enter Tax");								
							} catch (Exception e) {
								e.getStackTrace();
							}
						}
						
						@And("^Enter Feild Fee")
						public void feildfee() {
							try {
								eGovOp.enterData(locator.FeildFee(),"100","Enter Feild Fee");								
								
							} catch (Exception e) {
								e.getStackTrace();
							}
						}
	
						@Then("^Check Challan Number")
						public void checkcomplaintnumber1() {
							try {
								 ApplicationNum=eGovOp.getElementText(locator.applicationNumber(),"get Challan number");
									eGovOp.writeChallanNumber(ApplicationNum);

								if(ApplicationNum==null)
								{
								eGovOp.assertbyboolean(true,false,"Challan number not genrated");
								}
							} catch (Exception e) {
								e.getStackTrace();
							}
						}
	
	
	
	
						@And("^Click On Print")
						public void printReceipt() {
						try {
							String parentWindow = eGovOp.getCurrentWindow();
							eGovOp.clickElement(locator.print(), "Click On Print Recipt");
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
						
						

						@And("^Click On PAY")
						public void clickonpay() {
						try {
							eGovOp.wait_short_element_visib(locator.eGovNext(), "");
							eGovOp.clickElement(locator.eGovNext(), "Click On PAY");
						   
						} catch (Exception e) {
							e.getStackTrace();
						}
						}
						
						@And("^Select GEN Receipt Issue Date")
						public void GenReceiptIssueDate() {
							try {
								eGovOp.clickElement(locator.svgCalender(1), "Click");
								eGovOp.hoverOverclick(locator.svgCalender(1));
								eGovOp.Enter(locator.svgCalender(1));
							} catch (Exception e) {
								e.getStackTrace();
							}
						}
						
						@Then("^Check Payment Receipt number")
						public void checkRecepitNumber() {
							try {
								 String ReceiptNum=eGovOp.getElementText(locator.PaymentreceiptField(),"Check Receipt number");
								 System.out.print(ReceiptNum);
								if(ReceiptNum==null)
								{
								eGovOp.assertbyboolean(true,false,"Check Receipt number not genrated");
								}
							} catch (Exception e) {
								e.getStackTrace();
							}
						}
			
   @When("^Click On Search mchallan")
   public void searchCHallan() {
  try {
			eGovOp.clickElement(locator.inboxfirstlink(), "Click mchallan search");
			
			} catch (Exception e) {
			e.getStackTrace();
			}
						}
   
   @Then("^Enter Challan Number")
	public void Enterchallan() {
		try {
			String challanNum=eGovOp.readChallanNumber();
			eGovOp.enterData(locator.challanNofield(),challanNum,"Enter Challan Number");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
   
   @Then("^Citizen Enter Challan Number")
 	public void CitizenEnterchallan() {
 		try {
 			String challanNum=eGovOp.readChallanNumber();
 			eGovOp.enterData(locator.challanNoinput(),challanNum,"Enter Challan Number");
 		} catch (Exception e) {
 			e.getStackTrace();
 		}
 	}

	@And("^Check and Select Status \"(.*)\"$")
	public void selectStatus(String status) {
		try {	
			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("status",pro.getProperty(status));
			
		      Map<String,Integer> map=new HashMap<>();
		        map.put("Paid",1);
		        map.put("Cancelled",2);
		        map.put("Active",3);
				eGovOp.hoverOverclick(locator.selectstatus(map.get(eGovOp.getRuntimeProps("status"))));
				eGovOp.implicitWait(1, "wait");
				eGovOp.scrollToElement(locator.eGovNext());
				eGovOp.clickElement(locator.eGovNext(), "Click on Apply");
				
			String cuurentStatus=eGovOp.elementisNotPresnet(locator.currentStatus(6), "Current Status");
			if(!eGovOp.getRuntimeProps("status").equals(cuurentStatus))
			{
				eGovOp.assertbyboolean(true,false, " Assert Status Fail Result Message");	
		    }	
			
		
		
		}catch (Exception e) {
			e.getStackTrace();
		}
	} 
	

	@And("^Scroll till Search button")
	public void scrolltillSearch() {
		try {	
		     
			eGovOp.scrollToElement(locator.searchButton());
			eGovOp.clickElement(locator.clearicon(), "Clear field");
		
		
		}catch (Exception e) {
			e.getStackTrace();
		}
	} 
	
	@And("^Service Catagory \"(.*)\"$")
	public void serviceCatagory(String catagory) {
		try {	
			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("catagory",pro.getProperty(catagory));
			
		      Map<String,Integer> map=new HashMap<>();
		        map.put("Gas Balloon Advertisement",80);
		        
			
				
				eGovOp.implicitWait(2, "wait");
				if(map.get(catagory)>5)
				{
					eGovOp.scrollToElement(locator.clickonmore());
					eGovOp.clickElement(locator.clickonmore(), "Click on More");
					eGovOp.scrollToElement(locator.selectstatus(map.get(eGovOp.getRuntimeProps("catagory"))-3));
					eGovOp.wait_short_element_visib(locator.Servicecatagory(eGovOp.getRuntimeProps("catagory")), "wait");
					eGovOp.hoverOverclick(locator.selectstatus(map.get(eGovOp.getRuntimeProps("catagory"))));
					eGovOp.scrollToElement(locator.eGovNext());
					eGovOp.clickElement(locator.eGovNext(), "Click on Apply");
				
				}
				else
				{
					eGovOp.hoverOverclick(locator.selectstatus(map.get(eGovOp.getRuntimeProps("catagory"))));
					eGovOp.implicitWait(1, "wait");
					eGovOp.scrollToElement(locator.eGovNext());
					eGovOp.clickElement(locator.eGovNext(), "Click on Apply");	
				}

				
			String cuurentStatus=eGovOp.elementisNotPresnet(locator.currentStatus(3), "Current Status");
			if(!catagory.equals(cuurentStatus))
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
	
	
	@Then("^Click on Challan Number")
	public void complaintnumber() {
		try {
			String number=eGovOp.readChallanNumber();
			System.out.print(number);

			eGovOp.clickElement(locator.comliantnum(number), "Click on Challan Number");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@Then("^Click On Update Label")
	public void updatelabel() {
		try {
			eGovOp.clickElement(locator.Servicecatagory("Update"), "Click on Update");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Download Receipt")
	public void downloadReceipt() {
		try {
			eGovOp.wait_for_element_to_click(locator.eGovNext(), "Click on Download");
			eGovOp.clickElement(locator.eGovNext(), "Click on Download");
			eGovOp.wait_for_element_to_click(locator.receiptsText(), "Click on Receipts");
			eGovOp.clickElement(locator.receiptsText(), "Click on Receipts");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	@Then("^Click On Cancel")
	public void canclelabel() {
	try {		
		eGovOp.clickElement(locator.Cancle(),"Click On Cancel Request");

	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	
	@And("^Click On Yes")
	public void clickonYes() {
	try {		
		eGovOp.clickElement(locator.assignbutton(),"Click On Cancel Request");

	} catch (Exception e) {
		e.getStackTrace();
	}
	}
	/*
	 * @After public void eGovgoCloseApp() { try { DriverUtil.closeDriver(); } catch
	 * (Exception e) { e.getStackTrace(); } }
	 */
	
	
	// Start Citizen Region 
	
	@When("^Click On Search and Pay")
	public void SeacrhandPay() {
		try {

			eGovOp.clickElement(locator.mCollectSearchPay(), "Click On Search and Pay");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@When("^Click On My Challans")
	public void myChallan() {
		try {

			eGovOp.clickElement(locator.myChallans(), "Click On My Challans");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	
	@And("^Click On View Details")
	public void clickonViewDetails() {
		try {

			String challanNum=eGovOp.readChallanNumber();
			eGovOp.clickElement(locator.viewDetails(challanNum), "Click On View Details");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Citizen Enter City")
	public void citizenEnterCity() {
		try {

			eGovOp.clickElement(locator.dropdownfieldCitizen("1"), "^Citizen Enter City");
			eGovOp.clickElement(locator.selectcity(), "Select City");

		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	@And("^Choose Service Category \"(.*)\"$")
	public void chooseServiceCategory(String category) {
		try {

			Properties pro = new Properties();

			String path = System.getProperty("user.dir")+"/src/test/java/TestData";
			 String outputFile = path + "/" + "data" + ".properties";
			
			FileInputStream fileLoc = new FileInputStream(outputFile);
			pro.load(fileLoc);
			eGovOp.setRuntimeProps("category",pro.getProperty(category));
			
			eGovOp.clickElement(locator.inputfield(2), "Click On Service category dropdown");
			eGovOp.enterData(locator.inputfield(2),eGovOp.getRuntimeProps("category"), "Click On Service category dropdown");
			eGovOp.scrollToElement(locator.selectfromDropdown(eGovOp.getRuntimeProps("category")));
			eGovOp.wait_short_element_visib(locator.selectfromDropdown(eGovOp.getRuntimeProps("category")), "wait for element");
			eGovOp.hoverOverclick(locator.selectfromDropdown(eGovOp.getRuntimeProps("category")));
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	/*
	 * @After public void eGovgoCloseApp() { try { DriverUtil.closeDriver(); } catch
	 * (Exception e) { e.getStackTrace(); } }
	 */
	
	
}
	
