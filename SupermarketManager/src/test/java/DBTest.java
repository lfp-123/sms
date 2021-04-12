import java.io.IOException;

public class DBTest {
    public static void main(String[] args) throws IOException {
        StringBuilder codeNum = new StringBuilder(Integer.toString(1));
        int codeLength = codeNum.length();
        for (int i = 4; i > codeLength; i--) {
            codeNum.insert(0, "0");
        }
        System.out.println(codeNum.toString());
    }
}
