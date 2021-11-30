package yamlPojo;

import java.util.Map;

public class LogConfiguration {

	/**
	 * private Map<String, String> titlename; private String packagePrefix;
	 * 
	 * public Map<String, String> getTitlename() { return titlename; }
	 * 
	 * public void setTitlename(Map<String, String> paths) { this.titlename = paths;
	 * }
	 * 
	 * public String getPackagePrefix() { return packagePrefix; }
	 * 
	 * public void setPackagePrefix(String packagePrefix) { this.packagePrefix =
	 * packagePrefix; }
	 * 
	 * @Override public String toString() { return "LogConfiguration [paths=" +
	 *           titlename + "]"; }
	 **/

	private Location[] location;

	public Location[] getLocation() {
		return location;
	}

	public void setLocation(Location[] value) {
		this.location = value;
	}
//
//	@Override
//	public String toString() {
//		return "LogConfiguration [paths=" + location + "]";
//	}

}