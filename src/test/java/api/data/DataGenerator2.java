package api.data;

import java.util.Random;

public class DataGenerator2 {
	
	public static String getLicensePlate() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        int count = 4;
        for (int i = 0; i < count; i++) {
        int randomIndex = random.nextInt(letters.length());
        char randomChar = letters.charAt(randomIndex);
        sb.append(randomChar);
        }
        for (int i = 0; i < 4; i++) {
            int randomDigit = (int) (Math.random() * 10);
            sb.append(randomDigit);
        }
        return sb.toString();
    }
}
