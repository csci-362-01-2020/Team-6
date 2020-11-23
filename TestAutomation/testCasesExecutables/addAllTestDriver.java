import java.util.*;
public class addAllTestDriver {
    
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        int[] vals = new int[10];
        int lastComma = 1;
        int arrayPos = 0;
        try {
        for(int i = 0; i < args[0].length(); i++) {
            if(args[0].charAt(i) == ',') {
                vals[arrayPos] = Integer.parseInt(args[0].substring(lastComma, i));
                arrayPos++;
                lastComma = i;
                }
            }
        }
        catch (Exception e) {
            System.out.println("Error");
        }
        Collection<Integer> values = new ArrayList<Integer>() {{
            for(int i = 0; i < vals.length; i++) {
                add(vals[i]);
            }                  
        }};
        System.out.println(testQueue.addAll(values));
    }
}
