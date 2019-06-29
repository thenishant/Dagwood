package pages;

import io.appium.java_client.AppiumDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

class BasePage {
    private WebDriverWait wait;

    BasePage(AppiumDriver driver) {
        wait = new WebDriverWait(driver, 30);
    }

    protected void waitForElementsToBeVisible(WebElement element) {
        wait.until(ExpectedConditions.visibilityOf(element));
    }
}
