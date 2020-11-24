import java.util.*;
public class addTestDriver {
    public static void main(String[] args) {
        ArrayList<Integer> existList = new ArrayList<Integer>();
        for(int i = 0; i < args.length - 1; i++) {
            existList.add(Integer.parseInt(args[i].replace("{", "").replace(",", "").replace("}", "")));
        }
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>(existList);
        if(args[args.length - 1] != "null") {
            testQueue.add(Integer.parseInt(args[args.length - 1]));
        }
        System.out.println(testQueue);
    }
}
