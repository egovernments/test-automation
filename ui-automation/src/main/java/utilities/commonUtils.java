package utilities;

import org.testng.Assert;

public class commonUtils {

	public void assertValues(String actual, String expected, String description) {
		try {
			Assert.assertEquals(actual, expected);
		} catch (Exception e) {
			Log.Comment("Assertion failed-->\t" + e.getMessage());
		}
	}

}
