package utilities;

import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

import org.apache.commons.io.FileUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.Cookie;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.sikuli.script.FindFailed;
import org.sikuli.script.Pattern;
import org.sikuli.script.Screen;
import org.testng.Assert;

import com.sun.xml.bind.validator.Locator;

import stepDefinition.elementLocators;


public class NavigateMethods extends DriverUtil implements BaseTests {
	// SelectElementByType eleType= new SelectElementByType();
	private WebElement element = null;
	private String old_win = null;
	private String lastWinHandle;
	WebDriverWait waitMax;// = new WebDriverWait(driver, 30);
	WebDriverWait waitMin;// = new WebDriverWait(driver, 2);
	Actions act = new Actions(driver);
	JavascriptExecutor js = (JavascriptExecutor) driver;
	elementLocators locator = new elementLocators();

	
	public WebDriverWait waitMax() {
		waitMax = new WebDriverWait(driver, 50);
		return waitMax;
	}
	
	public WebDriverWait waitMin() {
		waitMin = new WebDriverWait(driver, 3);
		return waitMin;
	}
	/**
	 * Method to open link
	 * 
	 * @param url : String : URL for navigation
	 */
	public void navigateTo(String url) {
		
		driver.get(url);
		
	
	}
	
public String getUrl() {
			
		return driver.getCurrentUrl();

	}
	
	public void getCokkies(By byElem) throws InterruptedException {

		    driver.get("chrome://settings/clearBrowserData");
try
{
	Thread.sleep(1000L);
}
catch(InterruptedException e)
{
	
}
					
					
					Actions action = new Actions(driver);
					action.sendKeys(Keys.TAB).build().perform();
					action.sendKeys(Keys.TAB).build().perform();
					action.sendKeys(Keys.TAB).build().perform();
					action.sendKeys(Keys.TAB).build().perform();
					action.sendKeys(Keys.TAB).build().perform();
					action.sendKeys(Keys.TAB).build().perform();
					action.sendKeys(Keys.TAB).build().perform();
					action.sendKeys(Keys.ENTER).build().perform();
				}
			
	  
		
	
	
	
	
	

	/**
	 * Method to navigate back & forward
	 * 
	 * @param direction : String : Navigate to forward or backward
	 */
	public void navigate(String direction) {
		if (direction.equals("back"))
			driver.navigate().back();
		else
			driver.navigate().forward();
	}
	

	/**
	 * Method to return key by OS wise
	 * 
	 * @return Keys : Return control or command key as per OS
	 */
	public Keys getKey() {
		String os = System.getProperty("os.name").toLowerCase();
		if (os.contains("win"))
			return Keys.CONTROL;
		else if (os.contains("nux") || os.contains("nix"))
			return Keys.CONTROL;
		else if (os.contains("mac"))
			return Keys.COMMAND;
		else
			return null;
	}

	/**
	 * 
	 * @param byElem
	 * @param inOut
	 */
	public void zoomInOut(By byElem, String inOut) {
		WebElement Sel = driver.findElement(byElem);
		if (inOut.equals("ADD"))
			Sel.sendKeys(Keys.chord(getKey(), Keys.ADD));
		else if (inOut.equals("SUBTRACT"))
			Sel.sendKeys(Keys.chord(getKey(), Keys.SUBTRACT));
		else if (inOut.equals("reset"))
			Sel.sendKeys(Keys.chord(getKey(), Keys.NUMPAD0));
	}

	/**
	 * 
	 * @param byElem
	 * @param inOut
	 */
	public void zoomInOutTillElementDisplay(By byElem, String inOut) {
		Actions action = new Actions(driver);
		element = waitMax().until(ExpectedConditions.presenceOfElementLocated(byElem));
		while (true) {
			if (element.isDisplayed())
				break;
			else
				action.keyDown(getKey()).sendKeys(inOut).keyUp(getKey()).perform();
		}
	}

	/**
	 * Method to resize browser
	 * 
	 * @param width  : int : Width for browser resize
	 * @param height : int : Height for browser resize
	 */
	public void resizeBrowser(int width, int height) {
		driver.manage().window().setSize(new Dimension(width, height));
	}

	/** Method to maximize browser */
	public void maximizeBrowser() {
		driver.manage().window().maximize();
	}

	/**
	 * 
	 * @param byElem
	 */
	public void hoverOverElement(By byElem) {
		Actions action = new Actions(driver);
		element = waitMax().until(ExpectedConditions.presenceOfElementLocated(byElem));
		action.moveToElement(element).perform();
	}
	
	public void hoverOverclick(By byElem) {

	Actions action = new Actions(driver);
	element = waitMax().until(ExpectedConditions.presenceOfElementLocated(byElem));
	action.moveToElement(element).click().perform();

	}
	/**
	 * 
	 * @param byElem
	 */
	public void scrollToElement(By byElem) {
		element = waitMax().until(ExpectedConditions.presenceOfElementLocated(byElem));
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		executor.executeScript("arguments[0].scrollIntoView();", element);
	}

	public void scrollToElementIter(By byElem) {
		element = waitMax().until(ExpectedConditions.presenceOfElementLocated(byElem));

		JavascriptExecutor executor = (JavascriptExecutor) driver;
		executor.executeScript("arguments[0].scrollIntoView();", element);
	}
	
	public void javascriptclick(By byElem) {
		element = waitMax().until(ExpectedConditions.presenceOfElementLocated(byElem));

		JavascriptExecutor executor = (JavascriptExecutor)driver;
		executor.executeScript("arguments[0].click();", element);
	}
	
	

	/**
	 * Method to scroll page to top or end
	 * 
	 * @param to : String : Scroll page to Top or End
	 * @throws Exception
	 */
	public void scrollPage(String to) throws Exception {
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		if (to.equals("end"))
			executor.executeScript(
					"window.scrollTo(0,Math.max(document.documentElement.scrollHeight,document.body.scrollHeight,document.documentElement.clientHeight));");
		else if (to.equals("top"))
			executor.executeScript(
					"window.scrollTo(Math.max(document.documentElement.scrollHeight,document.body.scrollHeight,document.documentElement.clientHeight),0);");
		else
			throw new Exception("Exception : Invalid Direction (only scroll \"top\" or \"end\")");
	}

	/** Method to switch to new window */
	public void switchToNewWindow() {
		old_win = driver.getWindowHandle();
		for (String winHandle : driver.getWindowHandles())
			lastWinHandle = winHandle;
		driver.switchTo().window(lastWinHandle);
	}

	/** Method to switch to old window */
	public void switchToOldWindow() {

		String parentWindow=driver.getWindowHandle();

		  //store the set of all windows
		  Set<String> allwindows= driver.getWindowHandles();

		  for (String childWindow : allwindows) {
		    if(!childWindow.equals(parentWindow))
		      {
		        driver.switchTo().window(childWindow);
		        System.out.println("child window");
		        System.out.println(driver.getTitle());      
		  
		         driver.close();    
		     }
		    }
		    driver.switchTo().window(parentWindow);
	}
	
	public void switchToOldWindow(String parentWindows) {

		  //store the set of all windows
		String childWindow=driver.getWindowHandle();
		System.out.println(childWindow);
    	System.out.println(parentWindows);
		    if(!childWindow.equals(parentWindows))
		      {
		    	 driver.switchTo().window(childWindow);
		    	System.out.println(childWindow);
		    	System.out.println(parentWindows);
		        System.out.println(driver.getTitle());  
		         driver.close();    
		    }
		    driver.switchTo().window(parentWindows);
	}
	
	public String getCurrentWindow() {
		String parentWindows=driver.getWindowHandle();
		  //store the set of all windows
		 return parentWindows;
	}

	
	 
	/**
	 * Method to switch to window by title
	 * 
	 * @param windowTitle : String : Name of window title to switch
	 * @throws Exception
	 */
	public void switchToWindowByTitle(String windowTitle) throws Exception {
		old_win = driver.getWindowHandle();
		boolean winFound = false;
		for (String winHandle : driver.getWindowHandles()) {
			String str = driver.switchTo().window(winHandle).getTitle();
			if (str.equals(windowTitle)) {
				winFound = true;
				break;
			}
		}
		if (!winFound)
			throw new Exception("Window having title " + windowTitle + " not found");
	}

	/** Method to close new window */
	public void closeNewWindow() {
		driver.close();
	}

	/**
	 * Method to switch frame using web element frame
	 * 
	 * @param accessType : String : Locator type (index, id, name, class, xpath,
	 *                   css)
	 * @param accessName : String : Locator value
	 */
	public void switchFrame(By byElem) {
		element = waitMax().until(ExpectedConditions.presenceOfElementLocated(byElem));
		driver.switchTo().frame(element);
	}

	/** method to switch to default content */
	public void switchToDefaultContent() {
		driver.switchTo().defaultContent();
	}

	public void openEmpx() {
		driver.get("https://live2.empxtrack.com");
	}
	
	
	//read text for complaint number
	
	public String readApplicationNumber()
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData";

        String outputFile = path + "/" + "Application_Number" + ".txt";
        if (!new File(outputFile).exists()) {
            try
            {
                new FileOutputStream(new File(outputFile));

                FileWriter writer = new FileWriter(outputFile);
                writer.write("0");
                writer.close();
            }
            catch (FileNotFoundException e)
            {
                System.out.println(e.getMessage());
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
        String tempp = null;
        try
        {
            FileReader red = new FileReader(new File(outputFile));
            BufferedReader textreader = new BufferedReader(red);
            tempp = textreader.readLine();

            red.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return tempp;
    }
	
	//write text
	
	public void writeApplicationNumber (String complaintNumber)
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";
        System.out.println(path);

        File theDir = new File(path);
        if (!theDir.exists()) {
            boolean result = false;
            try {
                theDir.mkdirs();
                result = true;
            } catch (SecurityException localSecurityException) {
            }
        }
        String outputFile = path + "/" + "Application_Number" + ".txt";
        try {
            FileWriter writer = new FileWriter(new File(outputFile));
            writer.write(complaintNumber);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	public String readPropertyApplicationNumber()
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData";

        String outputFile = path + "/" + "PT Application Number" + ".txt";
        if (!new File(outputFile).exists()) {
            try
            {
                new FileOutputStream(new File(outputFile));

                FileWriter writer = new FileWriter(outputFile);
                writer.write("0");
                writer.close();
            }
            catch (FileNotFoundException e)
            {
                System.out.println(e.getMessage());
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
        String tempp = null;
        try
        {
            FileReader red = new FileReader(new File(outputFile));
            BufferedReader textreader = new BufferedReader(red);
            tempp = textreader.readLine();

            red.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return tempp;
    }
	
	//write text
	
	public void writePropertyApplicationNumber (String complaintNumber)
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";
        System.out.println(path);

        File theDir = new File(path);
        if (!theDir.exists()) {
            boolean result = false;
            try {
                theDir.mkdirs();
                result = true;
            } catch (SecurityException localSecurityException) {
            }
        }
        String outputFile = path + "/" + "PT Application Number" + ".txt";
        try {
            FileWriter writer = new FileWriter(new File(outputFile));
            writer.write(complaintNumber);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	
	public String readPropertyUID()
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData";

        String outputFile = path + "/" + "PT Unique ID" + ".txt";
        if (!new File(outputFile).exists()) {
            try
            {
                new FileOutputStream(new File(outputFile));

                FileWriter writer = new FileWriter(outputFile);
                writer.write("0");
                writer.close();
            }
            catch (FileNotFoundException e)
            {
                System.out.println(e.getMessage());
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
        String tempp = null;
        try
        {
            FileReader red = new FileReader(new File(outputFile));
            BufferedReader textreader = new BufferedReader(red);
            tempp = textreader.readLine();

            red.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return tempp;
    }
	
	//write text
	
	public void writePropertyUID (String complaintNumber)
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";
        System.out.println(path);

        File theDir = new File(path);
        if (!theDir.exists()) {
            boolean result = false;
            try {
                theDir.mkdirs();
                result = true;
            } catch (SecurityException localSecurityException) {
            }
        }
        String outputFile = path + "/" + "PT Unique ID" + ".txt";
        try {
            FileWriter writer = new FileWriter(new File(outputFile));
            writer.write(complaintNumber);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	public String readComplaintNumber()
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData";

        String outputFile = path + "/" + "Complaint_Number" + ".txt";
        if (!new File(outputFile).exists()) {
            try
            {
                new FileOutputStream(new File(outputFile));

                FileWriter writer = new FileWriter(outputFile);
                writer.write("0");
                writer.close();
            }
            catch (FileNotFoundException e)
            {
                System.out.println(e.getMessage());
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
        String tempp = null;
        try
        {
            FileReader red = new FileReader(new File(outputFile));
            BufferedReader textreader = new BufferedReader(red);
            tempp = textreader.readLine();

            red.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return tempp;
    }
	
	//write text
	
	public void writeComplaintNumber (String complaintNumber)
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";
        System.out.println(path);

        File theDir = new File(path);
        if (!theDir.exists()) {
            boolean result = false;
            try {
                theDir.mkdirs();
                result = true;
            } catch (SecurityException localSecurityException) {
            }
        }
        String outputFile = path + "/" + "Complaint_Number" + ".txt";
        try {
            FileWriter writer = new FileWriter(new File(outputFile));
            writer.write(complaintNumber);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	
	//read Vehicle Number
	public String readVehicleNumber()
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";

        String outputFile = path + "/" + "Vehicle_Number" + ".txt";
        if (!new File(outputFile).exists()) {
            try
            {
                new FileOutputStream(new File(outputFile));

                FileWriter writer = new FileWriter(outputFile);
                writer.write("0");
                writer.close();
            }
            catch (FileNotFoundException e)
            {
                System.out.println(e.getMessage());
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
        }
        String tempp = null;
        try
        {
            FileReader red = new FileReader(new File(outputFile));
            BufferedReader textreader = new BufferedReader(red);
            tempp = textreader.readLine();

            red.close();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return tempp;
    }
	
	//write Vehicle Number
	
	public void writeVehicleNumber (String complaintNumber)
    {
        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";
        System.out.println(path);

        File theDir = new File(path);
        if (!theDir.exists()) {
            boolean result = false;
            try {
                theDir.mkdirs();
                result = true;
            } catch (SecurityException localSecurityException) {
            }
        }
        String outputFile = path + "/" + "Vehicle_Number" + ".txt";
        try {
            FileWriter writer = new FileWriter(new File(outputFile));
            writer.write(complaintNumber);
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

	
	//read Challan Number
		public String readChallanNumber()
	    {
	        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";

	        String outputFile = path + "/" + "Challan_Number" + ".txt";
	        if (!new File(outputFile).exists()) {
	            try
	            {
	                new FileOutputStream(new File(outputFile));

	                FileWriter writer = new FileWriter(outputFile);
	                writer.write("0");
	                writer.close();
	            }
	            catch (FileNotFoundException e)
	            {
	                System.out.println(e.getMessage());
	            }
	            catch (IOException e)
	            {
	                e.printStackTrace();
	            }
	        }
	        String tempp = null;
	        try
	        {
	            FileReader red = new FileReader(new File(outputFile));
	            BufferedReader textreader = new BufferedReader(red);
	            tempp = textreader.readLine();

	            red.close();
	        }
	        catch (Exception e)
	        {
	            e.printStackTrace();
	        }
	        return tempp;
	    }
		
		//write Challan Number
		
		public void writeChallanNumber (String challanNum)
	    {
	        String path = System.getProperty("user.dir")+"/src/test/java/TestData/";
	        System.out.println(path);

	        File theDir = new File(path);
	        if (!theDir.exists()) {
	            boolean result = false;
	            try {
	                theDir.mkdirs();
	                result = true;
	            } catch (SecurityException localSecurityException) {
	            }
	        }
	        String outputFile = path + "/" + "Challan_Number" + ".txt";
	        try {
	            FileWriter writer = new FileWriter(new File(outputFile));
	            writer.write(challanNum);
	            writer.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

		
	public void Enter(By ele)
	{
		try
		{
	        Actions actions = new Actions(driver);
	        actions.sendKeys(Keys.ENTER).build().perform();
   
		}
		catch(Exception e){
			e.getStackTrace();
		}
	}
	
	public void SelectdropdownusingAction()
	{
		try
		{
	        Actions actions = new Actions(driver);
	        actions.sendKeys(Keys.ARROW_DOWN).build().perform();
	        actions.sendKeys(Keys.ENTER).build().perform();
	        try {
				Thread.sleep(2000);
			}
			catch(InterruptedException e)
			{
				
			}
   
		}
		catch(Exception e){
			e.getStackTrace();
		}
	}
	
    public void takeSnapShot() throws Exception{

        //Convert web driver object to TakeScreenshot

        TakesScreenshot scrShot =((TakesScreenshot)driver);

        //Call getScreenshotAs method to create image file

                File SrcFile=scrShot.getScreenshotAs(OutputType.FILE);

            //Move image file to new destination
                String path = System.getProperty("user.dir")+"/src/test/java/TestData/Screenshot.png";

                File DestFile=new File(path);

                //Copy file at destination

                FileUtils.copyFile(SrcFile, DestFile);

    }
	
	public void PressRightEnter(By ele)
	{
		try
		{
	        Actions actions = new Actions(driver);
	        actions.sendKeys(Keys.ARROW_RIGHT).build().perform();
	        actions.sendKeys(Keys.ENTER).build().perform();

		}
		catch(Exception e){
			e.getStackTrace();
		}
	}
	
	public void enterUsingRobot()
	{
		try {
			Robot robot = new Robot();
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_TAB);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_TAB);
			robot.delay(4000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	public void clicksikuli() throws FindFailed, InterruptedException {

	 Screen s = new Screen();
	 System.out.print("okkkkkk");
     Pattern openButton = new Pattern("/Users/macbook/Desktop/option.png");
     Pattern openButton1 = new Pattern("/Users/macbook/Desktop/photos.png");
     Thread.sleep(5000L);
     System.out.print("okkkkkk");
     s.wait(openButton, 20);
     s.click(openButton);
     System.out.print("Letttttt");
     s.wait(openButton1, 20);
     s.click(openButton1);
	
	}
	
	public boolean isdisplay(By ele,String description) {
		boolean display=false;
		try {
			
			 display=waitMax().until(ExpectedConditions.visibilityOfElementLocated(ele)).isDisplayed();

		} catch (Exception e) {
			e.getStackTrace();
			Log.failure(e.getMessage(), description);

			display=false;
		}
		return display;
	}
	
	public boolean isEnabled(By ele,String description) {
		boolean display=false;
		try {
			
			 display=waitMax().until(ExpectedConditions.elementToBeClickable(ele)).isDisplayed();
			System.out.println("1"+""+display);

		} catch (Exception e) {
			e.getStackTrace();
			System.out.println("fail");
			Log.failure(e.getMessage(), description);
			System.out.println("2"+""+display);

			display=false;
		}
		return display;
	}
	
	
	//Is selected
	public boolean isselected(By ele,String description) {
	boolean display=false;
	try {
		
		 display=waitMax().until(ExpectedConditions.visibilityOfElementLocated(ele)).isSelected();
		System.out.println(ele+""+display);

	} catch (Exception e) {
		e.getStackTrace();
		System.out.println("fail");
		Log.failure(e.getMessage(), description);
		System.out.println("2"+""+display);

		display=false;
	}
	return display;
}

	public void enterData(By byElem, String value, String description) {
		try {

			boolean elemVal = wait_long_element_visib(byElem, "Element visibility");
			if (elemVal) {
				driver.findElement(byElem).click();
				driver.findElement(byElem).clear();
				driver.findElement(byElem).sendKeys(value);
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	

	public void OnlyenterData(By byElem, String value, String description) {
		try {

			boolean elemVal = wait_long_element_visib(byElem, "Element visibility");
			if (elemVal) {
			System.out.print("Innnnnn");
				driver.findElement(byElem).sendKeys(value);
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}


	public void uploadData1(By byElem, String value, String description) {
		try {
			waitMax().until(ExpectedConditions.visibilityOfElementLocated(byElem));
			WebElement elem = driver.findElement(byElem);
			elem.sendKeys(value);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	


	public void uploadData(By byElem, String value, String description) {
		try {
			
			//clicksikuli();
			Robot robot = new Robot();
			File file = new File(value);
			StringSelection stringSelection = new StringSelection(file.getAbsolutePath());

			Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
			robot.delay(5000);
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_TAB);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_TAB);
			robot.delay(1000);
	
			// Open Goto window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_G);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_G);
			robot.delay(1000);

			// Clear Search Window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_DELETE);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_DELETE);
			robot.delay(1000);

			// Paste the clipboard value
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_V);
			robot.delay(1000);

			// Press Enter key to close the Goto window and Upload window
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			
			
		
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	public void uploadfile(By byElem,By byElem1, String blank, String blankDiffrent,String maxSize,String Description) {
		try {
			
			Robot robot = new Robot();
			
			clickElement(byElem, "");
			File file1 = new File(blank);
			StringSelection stringSelection1 = new StringSelection(file1.getAbsolutePath());

			Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection1, null);
			robot.delay(5000);
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_TAB);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_TAB);
			robot.delay(1000);
		
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_G);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_G);
			robot.delay(1000);

			// Clear Search Window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_DELETE);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_DELETE);
			robot.delay(1000);

			// Paste the clipboard value
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_V);
			robot.delay(1000);

			// Press Enter key to close the Goto window and Upload window
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(5000);
			
			clickElement(byElem1, "");
			File file3 = new File(blank);
			StringSelection stringSelection3 = new StringSelection(file3.getAbsolutePath());

			Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection3, null);
			robot.delay(5000);
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_G);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_G);
			robot.delay(1000);

			// Clear Search Window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_DELETE);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_DELETE);
			robot.delay(1000);

			// Paste the clipboard value
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_V);
			robot.delay(1000);

			// Press Enter key to close the Goto window and Upload window
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(5000);
			
			
			clickElement(byElem1, "");
			File file4 = new File(blankDiffrent);
			StringSelection stringSelection4 = new StringSelection(file4.getAbsolutePath());

			Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection4, null);
			robot.delay(5000);
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_G);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_G);
			robot.delay(1000);

			// Clear Search Window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_DELETE);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_DELETE);
			robot.delay(1000);

			// Paste the clipboard value
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_V);
			robot.delay(1000);

			// Press Enter key to close the Goto window and Upload window
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(5000);
			
			clickElement(locator.deleteiamgeicon(), "Wait for element");
			clickElement(byElem1, "");
			File file = new File(maxSize);
			StringSelection stringSelection = new StringSelection(file.getAbsolutePath());

			Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
			robot.delay(5000);

			// Open Goto window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_G);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_G);
			robot.delay(1000);

			// Clear Search Window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_DELETE);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_DELETE);
			robot.delay(1000);

			// Paste the clipboard value
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_V);
			robot.delay(1000);

			// Press Enter key to close the Goto window and Upload window
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			
			
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	

	public void uploadData2(By byElem, String value, String description) {
		try {
			Robot robot = new Robot();
			File file = new File(value);
			StringSelection stringSelection = new StringSelection(file.getAbsolutePath());

			Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
//			robot.keyPress(KeyEvent.VK_META);
//			robot.keyPress(KeyEvent.VK_TAB);
//			robot.keyRelease(KeyEvent.VK_META);
//			robot.keyRelease(KeyEvent.VK_TAB);
//			robot.delay(1000);

			// Open Goto window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_G);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_G);
			robot.delay(1000);

			// Clear Search Window
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_SHIFT);
			robot.keyPress(KeyEvent.VK_DELETE);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_SHIFT);
			robot.keyRelease(KeyEvent.VK_DELETE);
			robot.delay(1000);

			// Paste the clipboard value
			robot.keyPress(KeyEvent.VK_META);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_META);
			robot.keyRelease(KeyEvent.VK_V);
			robot.delay(1000);

			// Press Enter key to close the Goto window and Upload window
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
			robot.delay(1000);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	public void clickElement(By byElem, String description) {
		boolean clickelem = true;
		try {
			waitMax().until(ExpectedConditions.elementToBeClickable(byElem));
			driver.findElement(byElem).click();
		} catch (Exception e) {
			e.getStackTrace();
			clickelem = false;

		}

	}

	
	//CLick short 
	public void clickElementShort(By byElem, String description) {
		boolean clickelem = true;
		try {
			driver.findElement(byElem).click();
		} catch (Exception e) {
			e.getStackTrace();
			clickelem = false;

		}

	}
	
	public void clickChoose(By byElem, String value, String description) {
		boolean clickelem = true;
		try {
			driver.findElement(byElem).sendKeys(value);
		} catch (Exception e) {
			e.getStackTrace();
			clickelem = false;

		}

	}
	
	///

	public int listofElem(By byElem, String description) {
		boolean clickelem = true;
		int count = 0;
		try {
			waitMax().until(ExpectedConditions.elementToBeClickable(byElem));
			count = driver.findElements(byElem).size();
		} catch (Exception e) {
			e.getStackTrace();
			clickelem = false;
		}
		return count;

	}

	/**
	 * 
	 * @param byElem
	 * @param expectedVal
	 * @param description
	 * @throws InterruptedException
	 */
	public boolean IteratAndFind(By byElem, String expectedVal, String description) throws InterruptedException {
		boolean result = false;
		try {
			int i = 1;
			List<WebElement> allOptions = driver.findElements(byElem);
			for (WebElement we : allOptions) {
				js.executeScript("window.scrollBy(0,50)", "");
				if (we.getText().contains(expectedVal)) {
					we.click();
					result=true;
					break;
				} else if (i == allOptions.size()) {
					act.sendKeys(Keys.TAB).perform();
				} else {
				}
				i++;
			}
		} catch (Exception e) {
		}
		return result;
	}

	/**
	 * 
	 * @param byElem
	 * @param expectedVal
	 * @param description
	 * @return
	 * @throws InterruptedException
	 */
	public boolean IteratAndFindRadio(String byElem, String expectedVal, String description)
			throws InterruptedException {
		boolean val = true;
		try {
			wait_short_element_visib(By.xpath(byElem), "Parent Elemt of Radio button");
			List<WebElement> allOptions = driver.findElements(By.xpath(byElem));
			if (allOptions.size() > 1) {
				for (int k = 1; k <= allOptions.size(); k++) {
					if (driver.findElements(By.xpath(byElem + "[" + k + "]/label")).size() > 0) {
						String radioVal = driver.findElement(By.xpath(byElem + "[" + k + "]/label")).getText();
						if (radioVal.contains(expectedVal)) {
							val = true;
							driver.findElement(By.xpath(byElem + "[" + k + "]/span")).click();
							break;
						} else {
							val = false;
							scrollPageUp();
						}
					} else {
						val = false;
						break;
					}
				}
			} else {
				val = false;
			}
		} catch (Exception e) {
			val = false;
		}
		return val;
	}

	/**
	 * 
	 * @param byElem
	 * @param expectedVal
	 * @param description
	 * @return
	 * @throws InterruptedException
	 */
	public boolean IteratAndFindRadioNew(String byElem, String expectedVal, String description)
			throws InterruptedException {
		boolean val = true;
		try {
			boolean elemVal = wait_for_element(By.xpath(byElem), "Field visibility");
			if (elemVal) {
				List<WebElement> allOptions = driver.findElements(By.xpath(byElem));
				
				for (int k = 1; k <= allOptions.size(); k++) {
					if (driver.findElements(By.xpath(byElem + "[" + k + "]/label")).size() > 0) {
						String radioVal = driver.findElement(By.xpath(byElem + "[" + k + "]/label")).getText();
						if (radioVal.contains(expectedVal)) {
							val = true;
							driver.findElement(By.xpath(byElem + "[" + k + "]/span")).click();
							break;
						} else {
							val = false;
							scrollPageUp();
						}
					} else {
						val = false;
						break;
					}
				}
			} else {
				val = false;
			}
		} catch (Exception e) {
			val = false;
		}
		return val;
	}

	public boolean IteratAndFindCheckbox(String byElem, String expectedVal, String description)
			throws InterruptedException {
		boolean val = true;
		try {
			boolean elemVal = wait_for_element(By.xpath(byElem), "Field visibility");
			if (elemVal) {
				List<WebElement> allOptions = driver.findElements(By.xpath(byElem));
				for (int k = 1; k <= allOptions.size(); k++) {
					if (driver.findElements(By.xpath(byElem + "[" + k + "]/p")).size() > 0) {
						String checkBoxFrame = byElem + "[" + k + "]/p";
						scrollToElement(By.xpath(checkBoxFrame));
						String radioVal = getElementText(By.xpath(checkBoxFrame), "Check the checkbox in the screen");
						if (radioVal.contains(expectedVal)) {
							val = true;
							String checkBoxClick = byElem + "[" + k + "]/div/input";
							driver.findElement(By.xpath(checkBoxClick)).click();
							break;
						} else {
							val = false;
							scrollPageUp();
						}
					} else {
						val = false;
					}
				}
			} else {
				val = false;
			}
		} catch (Exception e) {
			val = false;
		}
		return val;
	}

	public boolean IteratAndFindField(String byElem, String expectedVal, String testData, String description)
			throws InterruptedException {
		boolean val = true;
		try {
			waitMax().until(ExpectedConditions.visibilityOfElementLocated(By.xpath(byElem)));
			List<WebElement> allOptions = driver.findElements(By.xpath(byElem));
			for (int k = 1; k <= allOptions.size(); k++) {
				String radioVal = driver.findElement(By.xpath(byElem + "[" + k + "]/label")).getText();

				if (radioVal.contains(expectedVal)) {
					val = true;
					WebElement elemVal = driver.findElement(By.xpath(byElem + "[" + k + "]/h2"));
					elemVal.click();
					elemVal.clear();
					elemVal.sendKeys(testData);
					break;
				} else {
					val = false;
				}
			}
		} catch (Exception e) {
			val = false;
		}
		return val;
	}

	public boolean pickDDVal(By showDDElem, By pickDDVal, String expectedVal, String description) {
		boolean dropRes = false;
		try {
			clickElement(showDDElem, "Click on Dropdown field");
			implicitWait(2, "Wait before Click on D");
			dropRes = IteratAndFind(pickDDVal, expectedVal, "Select expected Value from Property Type Category dropdown");
		} catch (Exception e) {
			e.getStackTrace();
		}
		return dropRes;
	}

	public void pickdropdownVal(By showDDElem, By pickDDVal, String expectedVal, String description) {
		try {
			clickElement(showDDElem, "Click on Dropdown field");
			implicitWait(2, "Wait before Click on D");

			IteratAndFind(pickDDVal, expectedVal, "Select expected Value from Property Type Category dropdown");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	public void pickRadioVal(By showDDElem, By pickDDVal, String expectedVal, String description) {
		try {
			clickElement(showDDElem, "Click on Property Type");
			IteratAndFind(pickDDVal, expectedVal, "Select expected Value from Property Type Category dropdown");
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	public void iterateAndFind(int count, String expectedVal, String description) {

		try {
			for (int i = count; i <= count; i++) {
				WebElement elem = driver.findElement(By.xpath("//div[@role='option'][" + i + "]"));
				String val = elem.getText();
				if (val.contains(expectedVal)) {
					elem.click();
					break;
				}
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	public int iterateClickLong(By byElem, String description) {
		boolean clickelem = true;
		int count = 0;
		try {
			waitMax().until(ExpectedConditions.elementToBeClickable(byElem));
			act.clickAndHold(driver.findElement(byElem));
			act.perform();
			Thread.sleep(5000);
		} catch (Exception e) {
			e.getStackTrace();
			clickelem = false;
		}
		return count;

	}

	public void clickLongAtElement(By byElem, String description) {
		boolean clickelem = true;
		try {
			waitMax().until(ExpectedConditions.elementToBeClickable(byElem));
			act.clickAndHold(driver.findElement(byElem));
			act.perform();
		} catch (Exception e) {
			e.getStackTrace();
			clickelem = false;
		}

	}

	public void cleartext(By byElem, String description) {
		try {
			waitMax().until(ExpectedConditions.visibilityOfElementLocated(byElem));
			driver.findElement(byElem).clear(); 
			
		} catch (Exception e) {
			e.getStackTrace();
			System.out.print(description);
			//Log.Comment(description + " --Element Clickable:--\t" + clickelem);

		}

	}
	public boolean verify(By by, String description) {
		boolean visibleStatus;
		try {
			visibleStatus = waitMax().until(ExpectedConditions.visibilityOfElementLocated(by)).isDisplayed();

			//Log.Comment(description + "\t::Waited Element::\t" + visibleStatus);
		} catch (Exception e) {
			e.getStackTrace();
			visibleStatus = false;
			//Log.Comment(description + " --Waited Element:--\t" + visibleStatus);
		}
		return visibleStatus;
	}
	
	
	public String getElementText(By byElem, String description) {
		String text = null;
		try {
			boolean elemVal = wait_long_element_visib(byElem, "Element visibility");
			if (elemVal) {
				text = driver.findElement(byElem).getText();
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return text;

	}
	
	
	
	public String elementisNotPresnet(By byElem, String description) {
		String	element=null;
		try
		{
		element = waitMin().until(ExpectedConditions.presenceOfElementLocated(byElem)).getText();
		

		}
		catch(Exception e)
		{
			System.out.println("IN catch"+element);
			
		}
		return element;

	}
	
	
	
	public void assertbyboolean(boolean actual, boolean expected, String description) {
		try {
			Assert.assertEquals(actual, expected, description);
		} catch (Exception e) {
			System.out.print("ddddddddddddd");
			Log.Comment("Assertion failed-->\t" + e.getMessage());
		
		}
	}

	public String getFieldText(By byElem, String description) {
		String text = null;
		boolean elemVal;
		try {
			text = null;
			elemVal = wait_for_element(byElem, "Field visibility");
			if (elemVal) {
				waitMax().until(ExpectedConditions.visibilityOfElementLocated(byElem));
				text = driver.findElement(byElem).getText();
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
		}
		return text;

	}

	public int elementCount(By byElem, String description) {
		boolean textElem = true;
		int count = 0;
		try {
			waitMax().until(ExpectedConditions.visibilityOfElementLocated(byElem));
			count = driver.findElements(byElem).size();
		} catch (Exception e) {
			e.getStackTrace();
			textElem = false;
		}
		return count;

	}
	
	
	
	

	public String textFieldCase(By byElem, String description) {
		String typeText = null;
		boolean elemVal = true;
		try {
			elemVal = wait_short_element_visib(byElem, "Element visibility");
			if (elemVal) {
				typeText = getElementText(byElem, "Text of Type Field");
			} else {
			}
		} catch (Exception e) {
			e.getStackTrace();
			elemVal = false;
			typeText = null;
		}
		return typeText;
	}

	public boolean wait_short_element_visib(By byElem, String description) {
		boolean contentAvail = true;
		try {
			waitMin().until(ExpectedConditions.visibilityOfElementLocated(byElem));
			contentAvail = driver.findElements(byElem).size() > 0;
		} catch (Exception e) {
			e.getStackTrace();
			contentAvail = false;
		}
		return contentAvail;
	}
	
	public boolean wait_Custom_short_element_visible(By byElem, String description) {
		boolean contentAvail = true;
		
			contentAvail = driver.findElements(byElem).size() > 0;
		
		return contentAvail;
	}

	public boolean No_wait_element_visib(By byElem, String description) {
		boolean contentAvail = true;
		try {
			contentAvail = driver.findElements(byElem).size() > 0;
		} catch (Exception e) {
			e.getStackTrace();
			contentAvail = false;
		}
		return contentAvail;
	}

	
	public boolean wait_long_element_visib(By byElem, String description) {
		boolean contentAvail = true;
		try {
			waitMax().until(ExpectedConditions.visibilityOfElementLocated(byElem));
			contentAvail = driver.findElements(byElem).size() > 0;
		} catch (Exception e) {
			e.getStackTrace();
			contentAvail = false;
		}
		return contentAvail;
	}

	
	public void darg_drop(By byElem, int x, int y) {
		waitMax().until(ExpectedConditions.elementToBeClickable(byElem));
		element = driver.findElement(byElem);
		act.clickAndHold(element).moveByOffset(0, 0).moveByOffset(x, y).release().build().perform();
	}
	
	public void refreshPage() {
		driver.navigate().refresh();
		
	}
	public boolean wait_for_element(By by, String description) {
		boolean visibleStatus = true;
		try {
			driver.manage().timeouts().implicitlyWait(1, TimeUnit.SECONDS);
			visibleStatus = driver.findElement(by).isDisplayed();
			driver.manage().timeouts().implicitlyWait(1, TimeUnit.SECONDS);
		} catch (Exception e) {
			e.getStackTrace();
			visibleStatus = false;
		}
		return visibleStatus;
	}

	public void scrollPage() {
		js.executeScript("window.scrollBy(0,1000)");
	}

	public void scrollpagewithpixel(int a,int b) {
		js.executeScript("window.scrollBy("+a+","+b+")");
	}

	public void scrollPageUp() {
		JavascriptExecutor js = (JavascriptExecutor) driver;
	       js.executeScript("window.scrollBy(0,-400)", "");
	}

	public boolean wait_for_text(By by, String expectedText) {
		boolean visibleStatus = true;
		try {
			visibleStatus = waitMax().until(ExpectedConditions.textToBePresentInElementLocated(by, expectedText));
		} catch (Exception e) {
			e.getStackTrace();
			visibleStatus = false;
		}
		return visibleStatus;
	}

	public void implicitWait(int seconds, String description) {
		try {
			driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
		} catch (Exception e) {
			e.getStackTrace();
		}

	}

	
	
	public WebElement return_element(By by, String description) {
		boolean visibleStatus = true;
		try {
			element = waitMax().until(ExpectedConditions.visibilityOfElementLocated(by));

		} catch (Exception e) {
			e.getStackTrace();
			visibleStatus = false;
		}
		return element;
	}

	public boolean wait_for_element_to_click(By by, String description) {
		boolean visibleStatus = true;
		try {
			element = waitMax().until(ExpectedConditions.elementToBeClickable(by));
		} catch (Exception e) {
			e.getStackTrace();
			visibleStatus = false;
		}
		return visibleStatus;
	}
	
	public void deleteAllCookies()
	{
		driver.manage().deleteAllCookies();	  
		
	}
	public String getSource() throws InterruptedException {
		Thread.sleep(5000);
		return driver.getPageSource();
	}

	public void setRuntimeProps(String key, String value) {
		try {
			System.setProperty(key, value);
		} catch (Exception e) {
			e.getMessage();
		}
	}

	public String getRuntimeProps(String key) {
		return System.getProperty(key);
	}

	public void getCloseApp() {
	//	driver.close();
		driver.quit();
	}
	
	public String infoMsg(String radioName, String info) {
		String msg = null;
		if(radioName.equals("Residential") && info.equals("Info")) {
			msg = "Application process will take a minute to complete."
					+ " It might cost around Rs.1000-1500 for cleaning your septic"
					+ " tank and there are concessed rates for people living in slum areas";
		}
		if(radioName.equals("Commercial") && info.equals("Info")) {
			msg = "Application process will take a minute to complete." 
					+ " It might cost around Rs.2000-5000 for cleaning your septic" 
					+ " tank and there are concessed rates for people living in slum areas";
		}
		if(radioName.equals("Institutional") && info.equals("Info")) {
			msg = "Application process will take a minute to complete." 
					+ " It might cost around Rs.1000-3000 for cleaning your septic" 
					+ " tank and there are concessed rates for people living in slum areas";
		}
		return msg;
	}
	
	public void SelectfromDropdown(By by, String value) {
		
		Select val = new Select(driver.findElement(by));
		val.selectByVisibleText(value);
	}
}
