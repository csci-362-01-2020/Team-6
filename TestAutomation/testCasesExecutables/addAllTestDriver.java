import java.util.*;
public class addAllTestDriver {
    
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        
        //Holding array to pass into the arrayList
        int[] vals = new int[args.length];

        //Extracting the integer values from the input String
        int lastComma = 1;
        int arrayPos = 0;

        //Parsing through the string, finding the numerical values to
        //add into the arrayList
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
        
        //Loop to declare and instantiate values in the arrayList
        Collection<Integer> values = new ArrayList<Integer>() {{
            for(int i = 0; i < vals.length; i++) {
                add(vals[i]);
            }                  
        }};

        System.out.println(testQueue.addAll(values));
    }
}
