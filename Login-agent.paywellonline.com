import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;

public class LaunchBrowser {
	
	public static WebDriver driver = null;
	
	public static void main(String[] args) throws InterruptedException{
		System.setProperty("webdriver.chrome.driver", "D:\\Java_Pro\\FirstProject\\Driver\\chromedriver.exe");
		driver = new ChromeDriver();
		driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
		
		driver.navigate().to("https://www.paywellonline.com/");
		driver.manage().window().maximize();
		String title = driver.getTitle();
		
		if(title.equalsIgnoreCase("Amazon.in"))
			System.out.println("Title Matches!");
		else
			System.out.println(title);
		
        driver.findElement(By.xpath("//*[@id=\"navbarSupportedContent\"]/ul/li[7]/a")).click();
        driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
        
        driver.findElement(By.xpath("//*[@id=\"phone\"]")).sendKeys("mahin.islam");
        driver.findElement(By.xpath("//*[@id=\"pin\"]")).sendKeys("1234");
        
        String tagname = " ";
        tagname = driver.findElement(By.xpath("//*[@id=\"login-form\"]/div/div[4]/label")).getText();
        System.out.println(tagname);
        
        char[] ch = new char[tagname.length()];
        int x=0;
        int y=0;
        
        for (int i = 20; i < 21; i++) {
        	ch[i] = tagname.charAt(i);
             x = Integer.parseInt(String.valueOf(ch[20]));
            System.out.println(x);
        }
        
        for (int j = 22; j < 23; j++) {
        	ch[j] = tagname.charAt(j);
            y = Integer.parseInt(String.valueOf(ch[22]));
            System.out.println(y);
        }
        
        int z= x+y; 
        System.out.println(z);
        
        driver.findElement(By.xpath("//*[@id=\"securityAnswer\"]")).sendKeys(String.valueOf(z));
        driver.findElement(By.xpath("//*[@id=\"btnLogin\"]")).click();

	}

}
