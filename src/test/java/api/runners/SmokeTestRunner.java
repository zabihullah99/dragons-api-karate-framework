package api.runners;

import com.intuit.karate.junit5.Karate;

public class SmokeTestRunner {

	@Karate.Test 
	public Karate runTests(){
		// run() method required path to feature files.
		// you can use tags() method to specify the Tag
		return Karate.run("classpath:features")
				.tags("somke");
	}
}
