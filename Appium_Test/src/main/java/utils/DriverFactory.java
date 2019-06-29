package utils;

import io.appium.java_client.android.AndroidDriver;
import io.appium.java_client.remote.AndroidMobileCapabilityType;
import io.appium.java_client.remote.MobileCapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeClass;

import java.net.MalformedURLException;
import java.net.URL;

public class DriverFactory {

    private static AndroidDriver driver;

    public DriverFactory() {
        setUp();
    }

    @BeforeClass(alwaysRun = true)
    public static void setUp() {
        initDriver();
    }

    private static void initDriver() {
        DesiredCapabilities capabilities = new DesiredCapabilities();
        capabilities.setCapability(MobileCapabilityType.PLATFORM_NAME, "Android");
        capabilities.setCapability(MobileCapabilityType.DEVICE_NAME, "device");
        capabilities.setCapability(MobileCapabilityType.FULL_RESET, false);
        capabilities.setCapability(AndroidMobileCapabilityType.APP_ACTIVITY, "com.bigbasket.mobileapp.activity.SplashActivity");
        capabilities.setCapability(AndroidMobileCapabilityType.APP_PACKAGE, "com.bigbasket.mobileapp");

        /* Location of the apk inside the docker*/
        capabilities.setCapability(MobileCapabilityType.APP, "/opt/bigbasket.apk");
        try {
            driver = new AndroidDriver(new URL("http://172.16.157.129:4723/wd/hub"), capabilities);

        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
    }

    @AfterMethod
    public void tearDown() {
        if (driver != null) {
            driver.quit();
        }
    }

    public AndroidDriver getDriver() {
        return driver;
    }
}