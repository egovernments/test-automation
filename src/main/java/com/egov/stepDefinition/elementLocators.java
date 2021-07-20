package com.egov.stepDefinition;

import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.egov.utils.BaseTests;
import com.egov.utils.SelectElementByType;

public class elementLocators extends SelectElementByType implements BaseTests{
	WebElement element;
	WebDriverWait wait;
	
	public By usernameElem() {
		By by =  By.id("employee-phone");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By passwordElem() {
		By by =  By.id("employee-password");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By cityElem() {
		By by =  By.id("person-city");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By selectCityElem() {
		By by =  By.xpath("//div[@class='list-main-card']/div/div/span/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By citySearchElem() {
		By by =  By.id("city-picker-search");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By companyElem() {
		By by =  By.id("location");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By signIn() {
		By by =  By.xpath("//div[@class='login-form']/div[9]/input[@value='Login']");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By myAttend() {
		By by =  By.id("myAttendance");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By langEnglish() {
		By by =  By.id("button-item-0");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By engButton() {
		By by = By.xpath("//*[@id='continue-action']/span[1]/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By homePage() {
		By by = By.xpath("//*[@id='root']/div/div[1]/main/div/div[2]/div[2]/div/div/div[1]/div[1]/div[1]/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By loginButton() {
		By by = By.xpath("//*[@id='login-submit-action']/span[1]/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By proptx() {
		By by = By.id("PROPERTY-TAX-5");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By addNew() {
		By by = By.id("custom-containers-buttonLabel");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By addNewApply() {
		By by = By.id("custom-containers-applyButtonLabel");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By goNxt() {
		By by = By.xpath("//*[@id='tax-wizard-buttons']/div/div[2]/button/div/div/span/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By propAdd() {
		By by = By.xpath("//*[@id='tax-wizard-buttons']/div/div/button/div/div/span/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By getPropId() {
		By by = By.xpath("//*[@id='root']/div/div[1]/main/div/div[2]/div[2]/div/div/div[1]/div[1]/div/div[2]/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By markAtt() {
		By by =  By.xpath("//div[@class='col-md-7']/a");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By tx_locty() {
		By by =  By.id("custom-containers-local-locality");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By prop_loc() {
		By by =  By.id("react-select-4-option-1");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By prop_locty() {
		By by =  By.xpath("//*[@id='mohalla']/div/div/div/div[1]");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By prop_comm() {
		By by =  By.xpath("//*[@id='typeOfUsage']/div[1]/button");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By prop_erial() {
		By by =  By.xpath("/html/body/div[6]/div/div/div/div[1]/span");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By prop_type() {
		By by =  By.xpath("//*[@id='typeOfBuilding']/div[1]/button");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By prop_flr() {
		By by =  By.xpath("/html/body/div[6]/div/div/div/div[3]/span/div/div/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By plot_sz() {
		By by =  By.id("assessment-plot-size");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By owner_name() {
		By by =  By.id("ownerName");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By owner_mob() {
		By by =  By.id("ownerMobile");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By owner_gaurd() {
		By by =  By.id("ownerGuardian");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By owner_specCat() {
		By by =  By.xpath("//*[@id='ownerCategory']/div/div/div/div[2]/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By noneOfAbv() {
		By by =  By.xpath("(//div[@role='option'])[6]");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By specCateg() {
		By by =  By.xpath("//div[ends-with(@class,'autocomplete-dropdown']/div/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By none_specCat() {
		By by =  By.id("react-select-7-option-5");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By tx_exp_loc() {
		By by =  By.xpath("//*[@id='react-select-3-option-1']");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By tx_mob() {
		By by =  By.id("custom-containers-ownerMobNo");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By tx_ownrName() {
		By by =  By.id("custom-containers-ownerName");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By tx_uniq_propId() {
		By by =  By.id("custom-containers-propertyTaxUniqueId");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By tx_exist_propId() {
		By by =  By.id("custom-containers-existingPropertyId");
		driver.findElement(by).isDisplayed();
		return by;
	} 
	
	public By upload1() {
		By by =  By.xpath("(//span[@data-localization='PT_MUTATION_DOCUMENT_DETAILS_BUTTON_UPLOAD_FILE'])[1]");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By upload2() {
		//By by =  By.xpath("//*[@id='root']/div/div[1]/main/div/div[2]/div[2]/div/div/div[2]/div[3]/div/div/div/div[4]/div/div/div[4]/div/div/label/span/span[1]/span");
		By by =  By.xpath("(//span[@data-localization='PT_MUTATION_DOCUMENT_DETAILS_BUTTON_UPLOAD_FILE'])[1]");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By upload3() {
		By by =  By.xpath("(//span[@data-localization='PT_MUTATION_DOCUMENT_DETAILS_BUTTON_UPLOAD_FILE'])[3]");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By doc1() {
		//By by =  By.xpath("//*[@id='root']/div/div[1]/main/div/div[2]/div[2]/div/div/div[2]/div[3]/div/div/div/div[3]/div/div/div[3]/div/div/div/div/div/div/div[1]");
		By by =  By.xpath("//div[@class='rainmaker-card clearfix ']/div/div/div[3]/div/div/div[3]/div/div/div/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}	
	
	public By doc2() {
		By by =  By.xpath("//div[@class='rainmaker-card clearfix ']/div/div/div[4]/div/div/div[3]/div/div/div/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By doc3() {
		By by =  By.xpath("//div[@class='rainmaker-card clearfix ']/div/div/div[5]/div/div/div[3]/div/div/div/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By doc4() {
		By by =  By.xpath("//div[@class='rainmaker-card clearfix ']/div/div/div[6]/div/div/div[3]/div/div/div/div/div");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By bill_doc() {
		By by =  By.xpath("(//div[@role='option'])[1]");
		driver.findElement(by).isDisplayed();
		return by;
	}
	
	public By tx_dorrNo() {
		By by =  By.id("custom-containers-doorNo");
		driver.findElement(by).isDisplayed();
		return by;
	}

}
 