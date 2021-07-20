package com.egov.utils;

import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class NavigateMethods extends SelectElementByType implements BaseTests {
	// SelectElementByType eleType= new SelectElementByType();
	private WebElement element = null;
	private String old_win = null;
	private String lastWinHandle;
	WebDriverWait wait = new WebDriverWait(driver, 30);
	Actions act = new Actions(driver);
	JavascriptExecutor js = (JavascriptExecutor) driver;

	/**
	 * Method to open link
	 * 
	 * @param url : String : URL for navigation
	 */
	public void navigateTo(String url) {
		driver.get(url);
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
	 * Method to zoom in/out page
	 * 
	 * @param inOut : String : Zoom in or out
	 */
	public void zoomInOut(String inOut) {
		WebElement Sel = driver.findElement(getelementbytype("tagName", "html"));
		if (inOut.equals("ADD"))
			Sel.sendKeys(Keys.chord(getKey(), Keys.ADD));
		else if (inOut.equals("SUBTRACT"))
			Sel.sendKeys(Keys.chord(getKey(), Keys.SUBTRACT));
		else if (inOut.equals("reset"))
			Sel.sendKeys(Keys.chord(getKey(), Keys.NUMPAD0));
	}

	/**
	 * Method to zoom in/out web page until web element displays
	 * 
	 * @param accessType : String : Locator type (id, name, class, xpath, css)
	 * @param inOut      : String : Zoom in or out
	 * @param accessName : String : Locator value
	 */
	public void zoomInOutTillElementDisplay(String accessType, String inOut, String accessName) {
		Actions action = new Actions(driver);
		element = wait.until(ExpectedConditions.presenceOfElementLocated(getelementbytype(accessType, accessName)));
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
	 * Method to hover on element
	 * 
	 * @param accessType : String : Locator type (id, name, class, xpath, css)
	 * @param accessName : String : Locator value
	 */
	public void hoverOverElement(String accessType, String accessName) {
		Actions action = new Actions(driver);
		element = wait.until(ExpectedConditions.presenceOfElementLocated(getelementbytype(accessType, accessName)));
		action.moveToElement(element).perform();
	}

	/**
	 * Method to scroll page to particular element
	 * 
	 * @param accessType : String : Locator type (id, name, class, xpath, css)
	 * @param accessName : String : Locator value
	 */
	// public void scrollToElement(String accessType, String accessName, By byElem)
	// {
	// element =
	// wait.until(ExpectedConditions.presenceOfElementLocated(getelementbytype(accessType,
	// accessName)));
	public void scrollToElement(By byElem) {
		element = wait.until(ExpectedConditions.presenceOfElementLocated(byElem));
		JavascriptExecutor executor = (JavascriptExecutor) driver;
		executor.executeScript("arguments[0].scrollIntoView();", element);
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
		driver.switchTo().window(old_win);
	}

	/**
	 * Method to switch to window by title
	 * 
	 * @param windowTitle : String : Name of window title to switch
	 * @throws Exception
	 */
	public void switchToWindowByTitle(String windowTitle) throws Exception {
		// Log.Comment("++"+windowTitle+"++");
		old_win = driver.getWindowHandle();
		boolean winFound = false;
		for (String winHandle : driver.getWindowHandles()) {
			String str = driver.switchTo().window(winHandle).getTitle();
			// Log.Comment("**"+str+"**");
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
	public void switchFrame(String accessType, String accessName) {
		if (accessType.equalsIgnoreCase("index"))
			driver.switchTo().frame(accessName);
		else {
			element = wait.until(ExpectedConditions.presenceOfElementLocated(getelementbytype(accessType, accessName)));
			driver.switchTo().frame(element);
		}
	}

	/** method to switch to default content */
	public void switchToDefaultContent() {
		driver.switchTo().defaultContent();
	}

	public void openEmpx() {
		driver.get("https://live2.empxtrack.com");
	}

	public void enterData(By byElem, String value, String description) {
		try {
			wait.until(ExpectedConditions.visibilityOfElementLocated(byElem));
			driver.findElement(byElem).click();
			driver.findElement(byElem).clear();
			driver.findElement(byElem).sendKeys(value);
		} catch (Exception e) {
			Log.Comment("-->\t" + description);
		}
	}

	public void uploadData1(By byElem, String value, String description) {
		try {
			wait.until(ExpectedConditions.visibilityOfElementLocated(byElem));
			WebElement elem = driver.findElement(byElem);
			elem.sendKeys(value);
		} catch (Exception e) {
			Log.Comment("Fail to Upload-->\t" + description);
		}
	}

	public void uploadData(By byElem, String value, String description) {
		try {
			Robot robot = new Robot();
			File file = new File(value);
			StringSelection stringSelection = new StringSelection(file.getAbsolutePath());

			Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
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
			Log.Comment("Fail to Upload-->\t" + description);
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
			Log.Comment("Fail to Upload-->\t" + description);
		}
	}

	public void clickElement(By byElem, String description) {
		boolean clickelem = true;
		try {
			wait.until(ExpectedConditions.elementToBeClickable(byElem));
			driver.findElement(byElem).click();
		} catch (Exception e) {
			clickelem = false;
			Log.Comment(description + " --Element Clickable:--\t" + clickelem);
		}

	}

	public int listofElem(By byElem, String description) {
		boolean clickelem = true;
		int count = 0;
		try {
			wait.until(ExpectedConditions.elementToBeClickable(byElem));
			count = driver.findElements(byElem).size();
			Log.Comment("Count:\t" + count);
		} catch (Exception e) {
			clickelem = false;
			Log.Comment(description + " --Element Clickable:--\t" + clickelem);
		}
		return count;

	}

	public int iterateClickLong(By byElem, String description) {
		boolean clickelem = true;
		int count = 0;
		try {
			wait.until(ExpectedConditions.elementToBeClickable(byElem));
			Log.Comment("Element:\t" + byElem.toString());
			act.clickAndHold(driver.findElement(byElem));
			act.perform();
			Thread.sleep(5000);
		} catch (Exception e) {
			clickelem = false;
			Log.Comment(description + " --Element Clickable:--\t" + clickelem);
			Log.Comment("Element Missing:--\t" + byElem);
		}
		return count;

	}

	public void clickLongAtElement(By byElem, String description) {
		boolean clickelem = true;
		try {
			wait.until(ExpectedConditions.elementToBeClickable(byElem));
			act.clickAndHold(driver.findElement(byElem));
			act.perform();
		} catch (Exception e) {
			clickelem = false;
			Log.Comment(description + " --Element Clickable:--\t" + clickelem);
		}

	}

	public String getElementText(By byElem, String description) {
		boolean textElem = true;
		String text = null;
		try {
			wait.until(ExpectedConditions.visibilityOfElementLocated(byElem));
			text = driver.findElement(byElem).getText();
		} catch (Exception e) {
			textElem = false;
			Log.Comment(description + " --Text Element:--\t" + textElem);
		}
		Log.Comment("Element Text is:\t" + text);
		return text;

	}

	public void darg_drop(By byElem, int x, int y) {
		wait.until(ExpectedConditions.elementToBeClickable(byElem));
		element = driver.findElement(byElem);
		act.clickAndHold(element).moveByOffset(0, 0).moveByOffset(x, y).release().build().perform();
	}

	public boolean wait_for_element(By by, String description) {
		boolean visibleStatus = true;
		try {
			element = wait.until(ExpectedConditions.visibilityOfElementLocated(by));

			Log.Comment(description + "\t::Waited Element::\t" + visibleStatus);
		} catch (Exception e) {
			visibleStatus = false;
			Log.Comment(description + " --Waited Element:--\t" + visibleStatus);
		}
		return visibleStatus;
	}

	public void scrollPage() {
		js.executeScript("window.scrollBy(0,1000)");
	}

	public boolean wait_for_text(By by, String expectedText) {
		boolean visibleStatus = true;
		try {
			visibleStatus = wait.until(ExpectedConditions.textToBePresentInElementLocated(by, expectedText));
			Log.Comment(expectedText + "\t::Waited for text in Element::\t" + visibleStatus);
		} catch (Exception e) {
			visibleStatus = false;
			Log.Comment(expectedText + " --Waited for text in Element:--\t" + visibleStatus);
		}
		return visibleStatus;
	}

	public void implicitWait(int seconds, String description) {
		try {
			driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
		}catch (Exception e) {
			Log.Comment(description + "Failed");
		}
		

	}
	public WebElement return_element(By by, String description) {
		boolean visibleStatus = true;
		try {
			element = wait.until(ExpectedConditions.visibilityOfElementLocated(by));

			Log.Comment(description + "\t::Waited Element::\t" + visibleStatus);
		} catch (Exception e) {
			visibleStatus = false;
			Log.Comment(description + " --Waited Element:--\t" + visibleStatus);
		}
		return element;
	}

	public boolean wait_for_element_to_click(By by, String description) {
		boolean visibleStatus = true;
		try {
			element = wait.until(ExpectedConditions.elementToBeClickable(by));
			Log.Comment(description + "\t::Waited Element To Clickable::\t" + visibleStatus);
		} catch (Exception e) {
			visibleStatus = false;
			Log.Comment(description + " --Waited Element To Clickable:--\t" + visibleStatus);
		}
		return visibleStatus;
	}

	public String getSource() throws InterruptedException {
		Thread.sleep(5000);
		return driver.getPageSource();
	}

	public BufferedImage compareImage(BufferedImage img1, BufferedImage img2) throws InterruptedException {
		int width1 = img1.getWidth(); // Change - getWidth() and getHeight() for BufferedImage
		int width2 = img2.getWidth(); // take no arguments
		int height1 = img1.getHeight();
		int height2 = img2.getHeight();
//	    Log.Comment("width1:\t"+width1);
//	    Log.Comment("width2:\t"+width2);
//	    Log.Comment("height1:\t"+height1);
//	    Log.Comment("height2:\t"+height2);

		BufferedImage procImg1 = cropImage(img1, 0, 0, width2, height2);
		int Pwidth1 = procImg1.getWidth();
		int Pheight1 = procImg1.getHeight();
//	    Log.Comment("width1:\t"+Pwidth1);
//	    Log.Comment("width2:\t"+width2);
//	    Log.Comment("height1:\t"+Pheight1);
//	    Log.Comment("height2:\t"+height2);

		if ((width2 != Pwidth1) || (height2 != Pheight1)) {
			System.err.println("Error: Images dimensions mismatch");
			System.exit(1);
		}
		// NEW - Create output Buffered image of type RGB
		BufferedImage outImg = new BufferedImage(width1, height1, BufferedImage.TYPE_INT_RGB);

		// Modified - Changed to int as pixels are ints
		int diff;
		int result; // Stores output pixel
		for (int i = 0; i < height2; i++) {
			for (int j = 0; j < width1; j++) {
				int rgb1 = procImg1.getRGB(j, i);
				int rgb2 = img2.getRGB(j, i);
				int r1 = (rgb1 >> 0) & 0xff;
				int g1 = (rgb1 >> 0) & 0xff;
				int b1 = (rgb1) & 0xff;
				int r2 = (rgb2 >> 0) & 0xff;
				int g2 = (rgb2 >> 0) & 0xff;
				int b2 = (rgb2) & 0xff;
				diff = Math.abs(r1 - r2); // Change
				diff += Math.abs(g1 - g2);
				diff += Math.abs(b1 - b2);
				diff /= 3; // Change - Ensure result is between 0 - 255
				// Make the difference image gray scale
				// The RGB components are all the same
				result = (diff << 16) | (diff << 8) | diff;
				outImg.setRGB(j, i, result); // Set result
			}
		}

		// Now return
		return outImg;
	}

	public static BufferedImage cropImage(BufferedImage bufferedImage, int x, int y, int width, int height) {
		BufferedImage croppedImage = bufferedImage.getSubimage(x, y, width, height);
		return croppedImage;
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

		// driver.closeApp();
		driver.quit();
		// driver.resetApp();
	}

	public void getRelaunchApp() {

		// driver.launchApp();
	}
}
