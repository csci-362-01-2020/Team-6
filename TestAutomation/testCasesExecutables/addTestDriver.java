import java.util.*;
public class addTestDriver {
    public static void main(String[] args) {

        //Array List to hold the list of arguments that represents the
        //list passed into the arguments.
        ArrayList<Integer> existList = new ArrayList<Integer>();
        for(int i = 0; i < args.length - 1; i++) {
            existList.add(Integer.parseInt(args[i].replace("{", "").replace(",", "").replace("}", "")));
        }
        
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>(existList);
        
        //Parsing the integer provided that there is an integer to begin with.
        //Potential problem if test case includes non-integer string but not null
        if(args[args.length - 1] != "null") {
            testQueue.add(Integer.parseInt(args[args.length - 1]));
        }
        System.out.println(testQueue);
    }
}
