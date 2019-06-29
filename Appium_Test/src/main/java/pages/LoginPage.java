package pages;

import io.appium.java_client.AppiumDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

public class LoginPage extends BasePage {

    @FindBy(id = "text_choose_location")
    private WebElement txtChooseLocation;

    public LoginPage(AppiumDriver driver) {
        super(driver);
        PageFactory.initElements(driver, this);
    }

    public void skipLogin() {
        waitForElementsToBeVisible(txtChooseLocation);
        txtChooseLocation.click();
    }
}