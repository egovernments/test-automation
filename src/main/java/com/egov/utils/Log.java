package com.egov.utils;

public class Log {

	public static void Comment(String message, String color) {
		try {
			logToStandard(message);

		} catch (Exception e) {
		}
	}

	/**
	 * 
	 * @param message
	 * @param testConfig
	 * @author i0465
	 */
	public static void Comment(String message) {
		Comment(message, "Black");
	}

	private static void logToStandard(String message) {
		System.out.println(message);
	}
}
