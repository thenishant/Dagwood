package tests;

import org.testng.annotations.Test;
import pages.LoginPage;

public class SearchItemTest extends BaseTest {

    SearchItemTest() {
    }

    @Test
    public void skipLoginTest() {
        new LoginPage(driver).skipLogin();
    }
}