package it.polito.ixemlabs.ixemcam;

import java.io.IOException;
import java.util.Properties;

public class PropertyManager {

	public static String getProperty(String key) {
		try {
			Properties properties = new Properties();
			properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("ixemcam.properties"));
			
			return properties.getProperty(key);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
}
