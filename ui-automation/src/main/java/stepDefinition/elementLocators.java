package stepDefinition;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import utilities.BaseTests;

public class elementLocators implements BaseTests {
	WebElement element;
	String formHead = "//div[@class='main center-container mb-50']";
	//String formHead = "//div[@class='app-container']";

	public By usernameElem() {
		By by = By.id("employee-phone");
		return by;
	}

	public By passwordElem() {
		By by = By.id("employee-password");
		return by;
	}

	public By eGovCreatePT() {
		By by = By.xpath("//div[@class='citizen']/div[3]/div[3]/div[2]/a[3]");

		return by;
	}

	public By eGovfsmElm() {
		By by = By.cssSelector("div.links > a:nth-child(1)");

		return by;
	}
	public By filecomplientlink() {
		By by =  By.xpath("//a[text()='File a Complaint']");
		//driver.findElement(by).isDisplayed();
		return by;
	}

	public By eGovmobile() {
		By by = By.cssSelector("input[name=mobileNumber]");
		return by;
	}

	public By eGovNext() {
		By by = By.xpath("//button[@class='submit-bar ']/header");
		return by;
	}

	public By eGovUploadFileName() {
		By by = By.xpath(formHead + "/form/div/div[2]/div/button/h2");
		return by;
	}

	public By eGovUploadFile() {
		By by = By.xpath("//input[@type='file']");
		return by;
	}

	public By eGovRegist() {
		By by = By.xpath("//div[@class='app-container']/div[2]/span/button");
		return by;
	}

	public By eGovPin() {
		By by = By.xpath(formHead + "/form/div/div/input");
		return by;
	}

	public By eGovPin1() {
		// By by = By.xpath("div[@class='card']/div/input[1]");
		By by = By.xpath("//div[@class='app-container']/form/div/div/input[1]");
		return by;
	}

	public By eGovPin2() {
		By by = By.xpath("//div[@class='app-container']/form/div/div/input[2]");
		return by;
	}

	public By eGovPin3() {
		By by = By.xpath("//div[@class='app-container']/form/div/div/input[3]");
		return by;
	}

	public By eGovPin4() {
		By by = By.xpath("//div[@class='app-container']/form/div/div/input[4]");
		return by;
	}

	public By eGovPin5() {
		By by = By.xpath("//div[@class='app-container']/form/div/div/input[5]");
		return by;
	}

	public By eGovPin6() {
		By by = By.xpath("//div[@class='app-container']/form/div/div/input[6]");
		return by;
	}

	public By resProp() {
		By by = By.xpath(formHead + "/form/div/header |"+ formHead + "/div[2]/header");
		return by;
	}

	public By radio_Value() {
		By by = By.xpath(formHead + "/form/div/div/div[1]/span");
		return by;
	}

	public String radioValue1() {
		String elementExprsn = formHead + "/form/div/div/div | " + formHead + "/form/div/div/span/div/div";
		return elementExprsn;
	}

	public List<String> radioValues() {
		List<String> list = new ArrayList<String>();
		list.add(formHead + "/form/div/div/span/div/div");
		list.add(formHead + "/form/div/div/div");
		list.add(formHead + "/form/div/div");
		list.add(formHead + "/form/div/div/div/div");
		list.add(formHead + "/form/div/div/div[2]/div");
		list.add(formHead + "/form/div/div/div[3]/div");
		list.add(formHead + "/form/div/div/div[4]/div");
		list.add(formHead + "/form/div/div/div[5]/div");
		list.add(formHead + "/div/div/div[2]");
		list.add(formHead + "/div/div/div[1]");
		list.add(formHead + "/form/div/div/div[1]");
		return list;
	}

	public List<String> checkboxValues() {
		List<String> list = new ArrayList<String>();
		list.add(formHead + "/form/div/div");
		list.add(formHead+"/div[2]/div/div");
		return list;
	}

	public By initPageElem() {
		By by = By.xpath(formHead + "/form/div/div | " + formHead
				+ "/div/div/div |"+ formHead+"/div[2]/div |"+formHead+"/form/div/textarea");
		return by;
	}

	public By fieldName() {
		By by = By.xpath(formHead + "/form/div/h2");
		return by;
	}

	public Map<By, By> fieldValues() {
		Map<By, By> fieldList = new HashMap<By, By>();
		fieldList.put(By.xpath(formHead + "/form/div/div/div[1]/p") , By.xpath(formHead + "/form/div/div/div[1]/div/input"));
		fieldList.put(By.xpath(formHead + "/form/div/div/div[2]/p") , By.xpath(formHead + "/form/div/div/div[2]/div/input"));
		fieldList.put(By.xpath(formHead + "/form/div/h2"), By.xpath(formHead + "/form/div/div/input |"+formHead + "/form/div/div/div/input" ));
		//fieldList.put(By.xpath(formHead + "/form/div/h2"), By.xpath(formHead + "/form/div/textarea"));
		fieldList.put(By.xpath(formHead + "/form/div/h2"), By.xpath(formHead + "/form/div/textarea |"+formHead + "/form/div/div/input |"+formHead + "/form/div/div/div/input" ));
		fieldList.put(By.xpath(formHead + "/form/div/h2[1]"),
				By.xpath(formHead + "/form/div/div[1]/div/input |" + formHead + "/form/div/div/input"));
		fieldList.put(By.xpath(formHead + "/form/div/h2[2]"), By.xpath(formHead + "/form/div/div[2]/div/input"));
		fieldList.put(By.xpath(formHead + "/form/div/h2[3]"), By.xpath(formHead + "/form/div/div[3]/div"));
		fieldList.put(By.xpath(formHead + "/form/div/div/h2[1]"), By.xpath(formHead + "/form/div/div/div[1]/input"));
		fieldList.put(By.xpath(formHead + "/form/div/div/h2[2]"), By.xpath(formHead + "/form/div/div/div[2]/input"));
		fieldList.put(By.xpath(formHead + "/form/div/div/h2[3]"),
				By.xpath(formHead + "/form/div/div/div[3]/input |" + formHead + "/form/div/div/div[3]/div/input"));
		fieldList.put(By.xpath(formHead + "/form/div/div/h2[4]"), By.xpath(formHead + "/form/div/div/div[4]/input"));
		fieldList.put(By.xpath(formHead + "/form/div/div/h2[5]"), By.xpath(formHead + "/form/div/div/div[5]/input"));
		fieldList.put(By.xpath(formHead + "/form/div/div/h2[6]"), By.xpath(formHead + "/form/div/div/div[6]/input"));
		fieldList.put(By.xpath(formHead + "/form/div/div/h2[7]"), By.xpath(formHead + "/form/div/div/div[7]/input"));
		
		return fieldList;
	}

	public HashMap<By, By> dropdownValues() {
		HashMap<By, By> ddValList = new HashMap<By, By>();
		ddValList.put(By.xpath(formHead + "/form/div/div/h2[2]"),By.xpath(formHead + "/form/div/div/div[2]/div/input"));
		ddValList.put(By.xpath(formHead + "/form/div/h2"), By.xpath(formHead + "/form/div/div[1]/div"));
		ddValList.put(By.xpath(formHead + "/form/div/h2[2]"), By.xpath(formHead + "/form/div/div[2]/div"));
		ddValList.put(By.xpath(formHead + "/form/div/h2[3]"), By.xpath(formHead + "/form/div/div[1]/div"));
		ddValList.put(By.xpath(formHead + "/form/div/div/h2[1]"),By.xpath(formHead + "/form/div/div[1]/div/input |" + formHead + "/form/div/div/input"));
		ddValList.put(By.xpath(formHead + "/form/div/div/h2[2]"),By.xpath(formHead + "/form/div/div/span[2]/div/div |" + formHead + "/form/div/div/div[2]/div/input"));
		return ddValList;
	}

	public HashMap<By, By> dropdownIterate() {
		HashMap<By, By> drpdwnList = new HashMap<By, By>();
		drpdwnList.put(By.xpath(formHead + "/form/div/div/div"), By.xpath(formHead + "/form/div/div/div[2]/div"));
		drpdwnList.put(By.xpath(formHead + "/form/div/div[1]/div"), By.xpath(formHead + "/form/div/div[1]/div[2]/div"));
		drpdwnList.put(By.xpath(formHead + "/form/div/div[2]/div"), By.xpath(formHead + "/form/div/div[2]/div[2]/div"));
		drpdwnList.put(By.xpath(formHead + "/form/div/div/span[2]/div/div |" + formHead + "/form/div/div/div[2]/div/input"),
				By.xpath(formHead + "/form/div/div/span[2]/div/div[2]/div |" + formHead + "/form/div/div/div[2]/div[2]/div"));
		
		return drpdwnList;
	}

	public By skipButton() {
		By by = By.xpath(formHead + "/div/span |" +formHead + "/div[2]/span |" + formHead + "/form/div/span");
		return by;
	}

	public By burgerIcn() {
		By by = By.xpath("//div[@class='body-container']/div/div[1]/div/span");
		return by;
	}

	public By logOut() {
		By by = By.xpath("//div[@class='drawer-list']/div[3]/span/div");
		return by;
	}
	
	public By infoParagraphMsg() {
		By by = By.cssSelector(".info-banner-wrap > p");
		return by;
	}

	public By applicationNumber() {
		By by = By.xpath("//h2[contains(text(),'No')]//following::p");
		return by;
	}
	
	public By selectFsm() {
	    By by = By.xpath("//*[ text() = 'Faecal Sludge Management']");
	    return by;
	}
	
	public By englishButton() {
		By by = By.id("button-item-0");
		return by;
	}
	
	public By continueButton() {
		By by = By.id("continue-action");
		return by;
	}
	
	public By inputEmpId() {
		By by = By.id("employee-phone");
		return by;
	}
	
	public By inputEmpPasswd() {
		By by = By.id("employee-password");
		return by;
	} 
	
	public By selectCityDD() {
		By by = By.id("person-city");
		return by;
	}

	public By langEnglish() {
		By by =  By.id("button-item-0");
		//driver.findElement(by).isDisplayed();
		return by;
	}
	public By langHidi() {
		By by =  By.id("button-item-1");
		//driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By engButton() {
		By by = By.xpath("//*[@id='continue-action']/span[1]/div/div");
		//driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By loginButton() {
		By by = By.xpath("//div[@class='button-label-container ']");
		//driver.findElement(by).isDisplayed();
		return by;
	}
	public By entercity() {
		
		By by = By.id("pac-input");
		
		return by;
}
	public By citySearchElem() {
		By by =  By.id("city-picker-search");
		//driver.findElement(by).isDisplayed();
		return by;
	}
	public By cityElem() {
		By by =  By.id("person-city");
		//driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By selectCityElem() {
		//By by =  By.xpath("//div[@class='list-main-card']/div/div/span/div/div");
		By by =  By.xpath("//div[@class='list-main-card']/div/div");
		//driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By compliantnumber() {
		
		By by = By.xpath("//h2[text()='Complaint No.']//following::p");
		return by;
	}

public By complianticon() {
		
		By by = By.xpath("(//div[text()='Complaints'])[2]");
		return by;
	}

public By assignToallbutton() {
	
	By by = By.xpath("(//span[@class='radio-btn-wrap'])[2]");
	return by;
}

public By comliantnum(String num) {
	
	By by = By.xpath("//a[text()='"+num+"']");
	return by;
}
public By takeActionButton() {
	
	By by = By.xpath("//header[text()='TAKE ACTION']");
	return by;
}

public By rejectComplaint() {
	
	By by = By.xpath("//p[text()='Reject Complaint']");
	return by;
}

public By assignCompliant() {
	
	By by = By.xpath("//p[text()='Assign Complaint']");
	return by;
}

public By rejectgrocompButton() {
	
	By by = By.xpath("//h2[text()='Reject']");
	return by;
}

public By clickOndropdown() {
	
	By by = By.className("sect-dropdown-input-wrap");
	return by;
}

public By selectLme() {
	
	By by = By.xpath("//div[@class='sect-dropdown-card']//p[text()='PGR LME Street light']");
	return by;
}



public By Entercomment() {
	
	By by = By.name("comment");
	return by;
}


public By assignbutton() {
	
	By by = By.className("selector-button-primary");
	return by;
}

public By backption() {
	By by = By.xpath("//div[@class='back-btn2']");
	//driver.findElement(by).isDisplayed();
	return by;
}
	
//pending assignment checkbox

public By selectstatus(int num) {
	
	By by = By.xpath("(//input[@class='input-emp'])["+num+"]");
	return by;
}

//file input

public By inputFile() {
	
	By by = By.xpath("//input[@type='file']");
	return by;
}
public By chooseFilebutton() {
	
	By by = By.xpath("//h2[text()='Choose File']");
	return by;
}

//Compliant number field
public By complaintNumField() {
	
	By by = By.name("serviceRequestId");
	return by;
}


//Mobile number field
public By mobileNumField() {
	
	By by = By.name("mobileNumber");
	return by;
}

//Search Button
public By searchButton() {
	
	By by = By.xpath("//header[text()='Search']");
	return by;
}
//Record not found msg
public By recordnotfoundTxt() {
	
	By by = By.xpath("//p[text()='No Records Found']");
	return by;
}

public By applicationnotfoundTxt() {
	
	By by = By.xpath("//p[text()='No Application Found']");
	return by;
}
//clear search label 
public By clearSearch() {
	
	By by = By.className("link-label");
	return by;
}
// assign to me
public By assigntoMebutton() {
	
	By by = By.xpath("(//span[@class='radio-btn-wrap'])[1]");
	return by;
}
// Downward Arrow
public By downwardArrow() {
	
	By by = By.xpath("//select[@class='cp']");
	return by;
}

//RightFace Arrow
public By svg(int num) {
	
	By by = By.xpath("(//*[local-name()='svg'])["+num+"]");
	return by;
}

//clear all label
public By clearAll() {
	
	By by = By.xpath("//span[text()='CLEAR ALL']");
	return by;
}

//click on complaint subtype dropdown
public By complaintSubSelectiondropdown() {
	
	By by = By.xpath("(//div[@class='employee-select-wrap '])[3]");
	return by;
}

//click on locality subtype dropdown

public By dropDownfieldEmp(int num) {
	
	By by = By.xpath("(//div[@class='employee-select-wrap '])["+num+"]");
	return by;
}

//Select type from drop Down
public By complaintSubSelection() {
	
	By by = By.xpath("//span[text()='No streetlight']");
	return by;
}


public By localitySubSelection() {
	
	By by = By.xpath("//span[text()='Main Road Abadpura']");
	return by;
}

public By verfyresult(String compnum) {
	
	By by = By.xpath("//a[text()='"+compnum+"']");
	return by;
}

// New Compliant 

public By newComplaint() {
	
	By by = By.xpath("//a[text()='New Complaint']");
	return by;
}

public By inbox() {
	
	By by = By.xpath("//header[text()='Inbox']");
	return by;
}

//pending to LME

public By pendingToLmebox() {
			
By by = By.xpath("(//input[@class='input-emp'])[3]");
return by;
}	
	//Reassign LME


public By reassignByLme() {
	
By by = By.xpath("//p[text()='Reassign']");
return by;
}		


public By reassignTogro() {
	
By by = By.xpath("//p[text()='GRO']");
return by;
}

// Resolve label

public By resolveByLme() {
	
By by = By.xpath("//p[text()='Resolve']");
return by;
}

public By reslovebutton() {
	
By by = By.className("selector-button-primary");
return by;
}

public By fsm() {
	
By by = By.xpath("//div[text()='Faecal Sludge Management']");
return by;
}

public By newapplication() {
	
By by = By.xpath("//a[text()='New Emptying of Septic Tank / Pit Application']");
return by;
}
// Select channel

		
public By applicationChanneldropdown() {
			
By by = By.xpath("(//div[@class='employee-select-wrap '])[3]");
return by;
			
}
public By applicationChannel() {
	
By by = By.xpath("//span[text()='Counter']");
return by;
}

//Application Name 

public By inputfield(int num) {
	
By by = By.xpath("(//input[@type='text'])["+num+"]");
return by;
}

//Mobile Number
public By mobileNumber() {
	
By by = By.xpath("//input[@type='tel']");
return by;
}

//Property type dropdown

public By propertyDropdown() {
	
By by = By.xpath("(//div[@class='employee-select-wrap '])[4]");
return by;
}

//Select Residential from Drop down

public By selectResidential(String property) {
	
By by = By.xpath("//span[text()='"+property+"']");
return by;
}

//Property type dropdown

public By subtypepropDropdown() {
	
By by = By.xpath("(//div[@class='employee-select-wrap '])[5]");
return by;
}

//Select subtype from Drop down

public By selectsubtype(String subtype) {
	
By by = By.xpath("//span[text()='"+subtype+"']");
return by;
}

//pincode enter
public By pincodeEC() {
	
By by = By.xpath("(//input[@type='text'])[5]");
return by;
}

//Mohalla dropdown

public By mohallaDropdwon() {
	
By by = By.xpath("(//input[@type='text'])[7]");
return by;
}



public By selectmohallaEC(String Mohalla) {
	
By by = By.xpath("//span[text()='"+Mohalla+"']");
return by;
}
//Sanitation Type

public By sanitationTypedropdown() {
	
By by = By.xpath("(//input[@type='text'])[11]");
return by;
}


public By sanitationType(String sanitation) {
	
By by = By.xpath("//span[text()='"+sanitation+"']");
return by;
}

// Enter Street Name

public By streetName() {
	
By by = By.xpath("(//input[@type='text'])[9]");
return by;
}

public By houseNo() {
	
By by = By.xpath("(//input[@type='text'])[10]");
return by;
}

public By landmark() {
	
By by = By.name("landmark");
return by;
}



//input length
public By enterLength() {
	
By by = By.xpath("//input[@type='number']");
return by;
}


public By enterBreadth() {
	
By by = By.xpath("(//input[@type='number'])[2]");
return by;
}

public By enterDepth() {
	
By by = By.xpath("(//input[@type='number'])[3]");
return by;
}

public By vehicleDropdown() {
	
By by = By.xpath("(//input[@type='text'])[12]");
return by;
}


public By selectvehicleType(String vehicletype) {
	
By by = By.xpath("//span[text()='"+vehicletype+"']");
return by;
}

public By submitApplication() {
	
By by = By.xpath("//header[text()='Submit Application']");
return by;
}

//inbox 
public By inboxlabel() {
	
By by = By.xpath("//a[text()='Inbox']");
return by;
}

//fsm Text 
public By fsmtext() {
	
By by = By.xpath("//span[text()='FSM']");
return by;
}
//Complaint Text 
public By Complainttext() {
	
By by = By.xpath("//span[text()='Complaints']");
return by;
}

//FAECAL SLUDGE MGMT text
public By fsmfulltext() {
	
By by = By.xpath("//span[text()='FAECAL SLUDGE MGMT']");
return by;
}


//application number input' applicationNos
public By applicationoInput() {
	
By by = By.name("applicationNos");
return by;
}

public By takeactionColl() {
	
By by = By.xpath("//header[text()='Take Action']");
return by;
}


public By collectPayement() {
	
By by = By.xpath("//p[text()='Collect Payment']");
return by;
}

public By inputdate() {
	
By by = By.xpath("//*[local-name()='svg' and @fill='Black']");
return by;
}

public By genrateReceipt() {
	
By by = By.xpath("//button[@type='submit']");
return by;
}

//Receipt get Field

public By receiptField() {
	
By by = By.xpath("//p[contains(text(),'FSM')]");
return by;
}

//p[contains(text(),'MP')]

public By assignDSO() {
	
By by = By.xpath("//p[text()='Assign DSO']");
return by;
}

public By dsoDropdownfeild() {
	
By by = By.xpath("(//div[@class='employee-select-wrap '])[4]");
return by;
}

public By selectDSO() {
	
	By by = By.xpath("//span[text()='ABC1 DS services - Driver DSO 36']");
	return by;
}



public By dsoLogin() {
	
	By by = By.xpath("//a[contains(text(),'DSO Login')]");
	return by;
}



//DSO DashBoard link
public By dsoDashboard() {
	
	By by = By.xpath("//a[text()='DSO Login/ Dashboard']");
	return by;
}

public By assignVehicle() {
	
By by = By.xpath("//p[text()='Assign Vehicle']");
return by;
}


public By firstdropdownfield() {
	
By by = By.xpath("//div[@class='select-wrap ']");
return by;
}

public By VehicleRegNo() {
	                  
	By by = By.xpath("(//div[contains(@class,' options-card')]//span)[1]");
	
	return by;
}

public By inboxDSO() {
	
	By by = By.xpath("//span[text()='Inbox']");
	return by;
}


//complete request
public By completeRequest() {
	
By by = By.xpath("//p[text()='Complete Request']");
return by;
}

//vehicle In time 

public By vehicleinTime() {
	
By by = By.xpath("(//input[@name='hour12'])[1]");
return by;
}

public By vehicleoutTime() {
	
By by = By.xpath("(//input[@name='hour12'])[2]");
return by;
}


//click on vechicle log
public By vehicleinLog() {
	
By by = By.xpath("//td[text()='ABC1 DS services - Driver DSO 36']//parent::tr//td");
return by;
}
//select am pm
public By selectInAmPm() {
	
By by = By.xpath("//select[@name='amPm'][1]");
return by;
}

public By selectOutAmPm() {
	
By by = By.xpath("(//select[@name='amPm'])[2]");
return by;
}

public By submitButton() {
	
By by = By.xpath("//header[text()='Submit']");
return by;
}


public By fsmcitizenLogin() {
	
	By by = By.xpath("(//a[text()='My Applications'])[2]");
	return by;
}

public By viewButton(String appnum) {
	
	By by = By.xpath("//p[text()='"+appnum+"']//following::a[1]");
	return by;
}

public By viewDetails(String num) {
	
	By by = By.xpath("//p[text()='"+num+"']//following::button[1]");
	return by;
}
//rate us
public By rateUs() {
	
	By by = By.className("action-link");
	return by;
}

//start 
public By starRating() {
	
	By by = By.xpath("(//*[local-name()='svg'])[9]");
	return by;
}

public By nobuttonRating() {
	
	By by = By.xpath("(//span[@class='radio-btn-wrap'])[2]");
	return by;
}
//ear checkbox


public By ratingcheckboxfield(String option) {
	
	By by = By.xpath("//input[@value='"+option+"']");
	return by;
}

/*
 * public By eyeGerarRating() {
 * 
 * By by = By.xpath("//input[@value='EYE_GEAR']"); return by; }
 * 
 * public By noMaskRating() {
 * 
 * By by = By.xpath("//input[@value='NOSE_MASK']"); return by; }
 * 
 * public By handGlovesRating() {
 * 
 * By by = By.xpath("//input[@value='HAND_GLOVES']"); return by; }
 */
//commentS

public By Entercomments() {
	
	By by = By.name("comments");
	return by;
}

public By searchApplication() {
	
	By by = By.xpath("//a[text()='Search Application']");
	return by;
}

public By fsmapply() {
	
	By by = By.xpath("//a[text()='Apply for Emptying of Septic Tank / Pit']");
	return by;
}

//locality dropdown for editor 

public By localityDropdownEditor() {
	
	By by = By.xpath("(//div[@class='employee-select-wrap '])[3]");
	return by;
}

public By localitySubSelectionbyEdiotor() {
	
	By by = By.xpath("//span[text()='Main Road Abadpura']");
	return by;
}

public By selectedLocality() {
	
	By by = By.xpath("//input[@value='Main Road Abadpura']");
	return by;
}


//more button

public By clickonmore() {
	
	By by = By.className("filter-button");
	return by;
}

public By maintype(String property) {
	By by = By.xpath("//label[text()='"+property+"']//preceding-sibling::span[@class='radio-btn-wrap']");
	//driver.findElement(by).isDisplayed();
	return by;
}


public By nextbutton() {
	
	By by = By.className("submit-bar");
	//driver.findElement(by).isDisplayed();
	return by;
}


public By compliantsubtypeptext() {
	
	By by = By.xpath("//header[text()='Choose Complaint Sub-Type']");
	return by;
}

public By ComplaintOption() {
	By by =  By.xpath("//a[text()='My Complaints']");
    return by;
	}

public By radiobuttonsubtype(String subtype) {

By by = By.xpath("//label[text()='"+subtype+"']//preceding-sibling::span[@class='radio-btn-wrap']");
return by;
}


public By verifypinLoacationpage() {
	
	By by = By.xpath("//header[text()='Pin Property Location']");
	return by;
}

public By verifypincomplaintLoacationpage() {
	
	By by = By.xpath("//header[text()='Pin Complaint Location']");
	return by;
}


	
	public By pincodeenter() {
		
	By by = By.xpath("//input[@name='pincode']");
	return by;
}
	
	public By pinerrormsg() {
		
		By by = By.xpath("//h2[@class='card-label-error ']");
		return by;
}
	
public By localitybutton() {
		
		By by = By.xpath("(//span[@class='radio-btn-wrap'])[2]");
		return by;
}
	

public By skiplink() {
	
	By by = By.xpath("//span[contains(text(),'Skip')]");
	return by;
}
public By landmarkfield() {
	
	By by = By.className("landmark");
	return by;
}
public By landmarklandingpage() {
	
	By by = By.xpath("//header[text()='Provide Landmark']");
	return by;
}

public By checkvalidpintext() 
{
	
	By by = By.xpath("//h2[text()='Sorry we are not providing service in this city']");
	return by;
}

public By selectcitydropdown() {
	
	By by = By.xpath("(//div[@class='select-wrap '])[1]");
	return by;
}

public By selectcityCitizen(String city) {
	
	By by = By.xpath("//span[text()='"+city+"']");
	return by;
}

public By selectLocalitydropdown() {
	
	By by = By.xpath("(//div[@class='select-wrap '])[2]");
	return by;
}

public By selectLocality(String Locality) {
	
	By by = By.xpath("//span[text()='"+Locality+"']");
	return by;
}

public By radioButtonfield(int num) {
	
	By by = By.xpath("(//span[@class='radio-btn-wrap'])["+num+"]");
	return by;
}

public By provideslumDropdown() {
	
	By by = By.xpath("(//div[@class='select-wrap '])[1]");
	return by;
}

public By provideslum(String slum) {
	
	By by = By.xpath("//span[text()='"+slum+"']");
	return by;
}

public By enterStreet() {
	
	By by = By.xpath("(//input[@type='text'])[1]");
	return by;
}

public By enterHouse() {
	
	By by = By.xpath("(//input[@type='text'])[2]");
	return by;
}

public By selectseptictank() {
	
	By by = By.xpath("(//span[@class='radio-btn-wrap'])[1]");
	return by;
}

public By properrtyDetailstext() {
	
	By by = By.xpath("//header[text()='Property Details']");
	return by;
}



//Enter Application Number or Mobile Number to seacrh msg

public By enterdatamsg() {
	
	By by = By.xpath("//h2[text()='Enter Application Number or Mobile Number to search']");
	return by;
}

//update application 

public By updateApplication() {
	
	By by = By.className("menu-wrap");
	return by;
}

//for scroll
public By checkfieldpresent(String value) {
	
	By by = By.xpath("//input[@value='"+value+"']");
	return by;
}

public By myecomplientlink() {
	By by =  By.xpath("//a[text()='My Complaints']");
	return by;
}


public By masterCardIcon()
{
	By by =  By.name("MasterCard");
	return by;
}


public By cardNumInput()
{
	By by =  By.id("CardNumber");
	return by;
}
public By cardMonthInput()
{
	By by =  By.id("CardMonth");
	return by;
}
public By cardYearInput()
{
	By by =  By.id("CardYear");
	return by;
}

public By payNowButton()
{
	By by =  By.id("Paybutton");
	return by;
}
public By submit()
{
	By by =  By.xpath("//input[@value='Submit']");
	return by;
}

//view rating 

public By viewdetails()
{
	By by =  By.className("action-link");
	return by;
}
public By gearsRating()
{
	By by =  By.xpath("//p[text()='Eye Gear, Hand Gloves, Nose mask']");
	return by;
}

public By spillageoptionRating()
{
	By by =  By.xpath("//p[text()='NO']");
	return by;
}

public By checkcommentRating()
{
	By by =  By.xpath("//p[text()='Test']");
	return by;
}

public By downloadOption()
{
	By by =  By.className("multilink-labelWrap");
	return by;
}
public By applicationAcknowledgement()
{
	By by =  By.xpath("//div[text()='Application Acknowledgement']");
	return by;
}
public By profileicon() 
{
	By by =  By.className("user-img-txt");
	
    return by;
	}


public By logout() {
	By by =  By.xpath("(//span[text()='Logout'])[1]");
    return by;
	}

//RegistrationNumber
public By vehicleNumField() 
{
	By by =  By.name("registrationNumber");
    return by;
	}

public By dsoNameField()
{
	By by =  By.name("name");
    return by;
	}


//SVG Calender  Icon

public By svgCalender(int num) 
{
	By by =  By.xpath("(//*[name()='svg' and contains(@fill, 'Black')])["+num+"]");
    return by;
	}

//Wasted litre 

public By wastecollected() 
{
	By by =  By.name("wasteCollected");
    return by;
	}


public By dateinputfeild() 
{
	By by =  By.xpath("//input[@type='date']");
    return by;
	}

public By downloadButton() 
{
	By by =  By.className("response-download-button");
    return by;
	
}

// Go Back To Home PAge
public By backhomeomePageButton() 
{
	By by =  By.xpath("//header[text()='Go back to home page']");
    return by;
	
}

//Collect Payment Button

public By collectPaymentButton() 
{
	By by =  By.xpath("//header[text()='Collect Payment']");
    return by;
	
}


// Credit Card Radio Button

public By creditdebitRadiobutton() 
{
	By by =  By.xpath("//label[text()='Credit/Debit Card']//parent::div//span[@class='radio-btn-wrap']");
    return by;
	
}
//Cheque 

public By chequeRadioButton() 
{
	By by =  By.xpath("//label[text()='Cheque']//parent::div//span[@class='radio-btn-wrap']");
 return by;
	
}
public By chequeNumberfield() 
{
	By by =  By.xpath("//input[@name='instrumentNumber'][1]");
 return by;
	
}

public By ifscCodefield() 
{
	By by =  By.xpath("//div[@class='cheque-date']//input");
 return by;
	
}

public By searchIcon() 
{
	By by =  By.xpath("//button[@type='button']");
 return by;
	
}

public By GenReciptNumber() 
{
	By by =  By.xpath("(//input[@name='instrumentNumber'])[1]");
 return by;
	
}

public By inputfield(String pos) 
{
	By by =  By.xpath("(//input[@name='instrumentNumber'])["+pos+"]");
 return by;
	
}

public By homeBreadcrumb() 
{
	By by =  By.xpath("//a[text()='Home']");
 return by;
	
}

public By selectfromDropdown(String value) {
	
By by = By.xpath("//span[text()='"+value+"']");
return by;
}



public By dropdownfield(String position) {
	
By by = By.xpath("(//div[@class='employee-select-wrap '])["+position+"]");
return by;
}

public By dropdownfieldCitizen(String position) {
	
By by = By.xpath("(//div[@class='select-wrap '])["+position+"]");
return by;
}
//Payer name

public By payername() 
{
	By by =  By.name("payerName");
 return by;
	
}

public By payerMobile() 
{
	By by =  By.name("payerMobile");
 return by;
	
}
//payer details Text

public By payerdetails() 
{
	By by =  By.xpath("//header[text()='Payer Details']");
 return by;
	
}



//DSO decline request

public By declineRequest() 
{
	By by =  By.xpath("//p[text()='Decline Request']");
 return by;
	
}

//Receipt Go Home Page
public By recieptGohomepage() 
{
	By by =  By.xpath("//a[text()='Go back to home page']");
 return by;
	
}

//Admin Send Back 

public By sendBack() 
{
	By by =  By.xpath("//p[text()='Send Back']");
 return by;
	
}

//Admin Cancle Request 

public By requestCancle() 
{
	By by =  By.xpath("//p[text()='Cancel Request']");
 return by;
	
}

//Citizen


public By complaintnumberlabel(String num) {
	
	By by = By.xpath("//p[text()='"+num+"']");
	return by;
}



public By deleteiamgeicon() {
	
	By by = By.className("delete");
	return by;
}

public By filelargeError() {
	
	By by = By.xpath("//h2[text()='File is too large']");
	return by;

}

public By uploadfile() {
	
	By by = By.className("upload-wrap");
	return by;
}
public By nextimageupload() {
	
	By by = By.className("upload-img-container");
	return by;
}


public By enteradditionalDetails() {
	
	By by = By.name("description");
	return by;
}

public By provideadditionalDetails() {
	
	By by = By.xpath("//header[text()='Provide Additional Details']//following::textarea");
	return by;
}

// Citizen ReOpen


public By citizenReopen() {
	
	By by = By.xpath("//span[text()='REOPEN']");
	return by;
}

//Reopen Reson
//label[text()='No work was done']//preceding-sibling::span[@class='radio-btn-wrap']

public By citizenReopenReason() {
	
	By by = By.xpath("//label[text()='No work was done']//preceding-sibling::span");
	return by;
}

public By selectcity(String city) {
	
	By by = By.xpath("//div[text()='"+city+"']");
	return by;
}

public By youRatedtext() {
	
	By by = By.xpath("//div[@class='rating-with-text']");
	return by;
}

//Enter Comment Citizen

public By enterCitizencomment() {
	
	By by = By.xpath("//header[text()='Comments']//following::textarea");
	return by;
}
public By hindilanguage() {
	
	By by = By.xpath("//button[text()='हिंदी']");
	return by;
}

public By hindilanguageFsm() {
	
	By by = By.xpath("//span[text()='हिंदी']");
	return by;
}

public By englishlanguageFsm() {
	
	By by = By.xpath("//span[text()='ENGLISH']");
	return by;
}

public By clickonLangaeoption() {
	
	By by = By.xpath("//label[text()='ENGLISH']");
	return by;
}


public By clickonLangaeoptionHindi() {
	
	By by = By.xpath("//label[text()='हिंदी']");
	return by;
}


public By Hindilogoutoption() {
	
	By by = By.xpath("//div[contains(text(),'आउट')]");
	return by;
}

public By commentsuccessfulpopup() {
	
	By by = By.xpath("//h2[text()='Comment Successful']");
	return by;
}

public By currentStatus(int index) {
	
	By by = By.xpath("//td["+index+"]/span");
	return by;
}


//Print Recept
public By printReceipt() {
	
	By by = By.xpath("//div[text()='Print Receipt']");
	return by;
}

public By print() {
	
	By by = By.xpath("//div[text()='Print']");
	return by;
}


///////// mCollect

public By mCollectctext() {
	
	By by = By.xpath("//div[@class='inbox-service-list']//div[text()='mCollect']");
	return by;
}

public By consumerName() {
	
	By by = By.name("name");
	return by;
}
public By doorNo() {
	
	By by = By.name("doorNo");
	return by;
}

public By street() {
	
	By by = By.name("street");
	return by;
}
public By buildingName() {
	
	By by = By.name("buildingName");
	return by;
}

public By pincode() {
	
	By by = By.name("pincode");
	return by;
}

public By Tax() {
	
	By by = By.name("ADVT_HOARDINGS_TAX");
	return by;
}
public By FeildFee() {
	
	By by = By.name("ADVT_HOARDINGS_FIELD_FEE");
	return by;
}
public By PaymentreceiptField() {
	
By by = By.xpath("//p[contains(text(),'MP')]");
return by;
}

public By inboxfirstlink() {
	
By by = By.className("link");
return by;
}

public By challanNofield() {
	
By by = By.name("challanNo");
return by;
}

public By challanNoinput() {
	
By by = By.xpath("//input[@name='ChallanNo']");
return by;
}

public By receiptsText() {
	
By by = By.xpath("//p[text()='Receipts']");
return by;
}

public By detailsSafe() {
	
	By by = By.id("details-button");
	return by;

}

public By proceedSafe() {
	
	By by = By.id("proceed-link");
	return by;

}

public By Servicecatagory(String catagory) {
	
	By by = By.xpath("//p[text()='"+catagory+"']");
	return by;

}

public By Cancle() 
{
	By by =  By.xpath("//p[text()='Cancel']");
 return by;
	
}

public By SeacrhandPay(String value) 
{
	By by =  By.xpath("//h2[text()='"+value+"']//following::a[text()='Search and Pay']");
 return by;
	
}

public By myChallans() 
{
	By by =  By.xpath("//a[text()='My Challans']");
 return by;
	
}

public By applicationTimeline() 
{
	By by =  By.xpath("//header[contains(text(),'Timeline')]");
 return by;
	
}

public By chromecache() 
{
	By by =  By.id("clearBrowsingDataConfirm");
 return by;
	
}


public By clearicon() 
{
	By by =  By.xpath("(//span[@class='clear-search'])[1]");
 return by;
	
}

/////// Property Tax
public By selectcitizenLanguage(String language) 
{
	By by =  By.xpath("//label[text()='"+language+"']//parent::div//span");
 return by;

}

public By citizenContinue() 
{
	By by =  By.xpath("//button[contains(@class,'submit-bar')]//header");
 return by;
}

public By selectLocation(String location) 
{
	By by =  By.xpath("//label[text()='"+location+"']//preceding-sibling::span");
 return by;
}

public By selectService(String service) 
{
	By by =  By.xpath("//p[text()='"+service+"']");
 return by;
}

public By selectServiceSubtype(String servicesubType) 
{
	By by =  By.xpath("//p[text()='"+servicesubType+"']");
 return by;
}

public By selectHyperlinkText(int num) 
{
	By by =  By.xpath("//a["+num+"]");
 return by;
}

public By plotSize() 
{
	By by =  By.name("PlotSize");
 return by;
}

public By builtUpArea() 
{
	By by =  By.name("BuiltUpArea");
 return by;
}

public By rentArea() 
{
	By by =  By.name("RentArea");
 return by;
}


public By annualRent() 
{
	By by =  By.name("AnnualRent");
 return by;
}
public By floorArea() 
{
	By by =  By.name("floorarea");
 return by;
}
public By guardianField() 
{
	By by =  By.name("fatherOrHusbandName");
 return by;
}
public By selectGender() 
{
	By by =  By.xpath("//label[text()='Male']//preceding::span[@class='radio-btn-wrap']");
 return by;
}

public By checkboxfield() 
{
	By by =  By.className("custom-checkbox");
 return by;
}

public By addressfield() 
{
	By by =  By.name("address");
 return by;
}
public By propertyID() 
{
	By by =  By.xpath("//div[@class='value']");
 return by;
}

public By propertyIDfield() 
{
	By by =  By.name("propertyId");
 return by;
}


public By selectServiceType(int num) 
{
	By by =  By.xpath("(//div[@class='inbox-service-list']//div)["+num+"]");
 return by;
}


public By clickonLink(int num) 
{
	By by =  By.xpath("(//span[@class='link'])["+num+"]");
 return by;
}


public By takeActionOtions(int num) 
{
	By by =  By.xpath("(//div[@class='menu-wrap']//p)["+num+"]");
 return by;
}

public By citizenDownloadlabel() 
{
	By by =  By.xpath("//div[@class='app-container']//child::span");
 return by;
}

public By checkinformation() 
{
	By by =  By.xpath("(//header[@class='card-sub-header '])[8]");
 return by;
}

}




