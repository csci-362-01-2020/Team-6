import java.util.*;
public class testCase21Driver {
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        int startArg = 0;
        int endArg;
        ArrayList<Integer> args1 = new ArrayList<Integer>();
        ArrayList<Integer> args2 = new ArrayList<Integer>();
        boolean first = true;

        for(int i = 0; i < args.length; i++) {
            if(args[i].contains("null") && first) {
                args1 = null;
                first = false;
                startArg++;
            }
            else if(args[i].contains("null") && !first) {
                args2 = null;
            }
            else if(args[i].contains("}") && first) {
                first = false;
                endArg = i;
                while(startArg <= endArg) {
                    args1.add(Integer.parseInt(args[startArg].replace("{", "").replace(",", "").replace("}", "")));
                    startArg++;
                }
            }
            else if(args[i].contains("}") && !first) {
                endArg = i;
                while(startArg <= endArg) {
                    args2.add(Integer.parseInt(args[startArg].replace("{", "").replace(",", "").replace("}", "")));
                    startArg++;
                }
            }
        }

        if(args1 != null) {
            testQueue.addAll(args1);
        }

        System.out.println(testQueue.containsAll(args2));
    
    }
    
}
