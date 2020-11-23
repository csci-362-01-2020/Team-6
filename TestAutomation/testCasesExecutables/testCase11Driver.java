public class testCase11Driver {
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        
        //toArray method requires a destination array which is here
        Object[] solutionArray = new Integer[args.length];
        try {
            for(int i = 0; i < args.length; i++) {
                String rawVal = args[i];
                rawVal = rawVal.replace(",", "");
                testQueue.add(Integer.parseInt(rawVal));
            }
        }
        catch (Exception e) {
            System.out.println("Error");
        }
        solutionArray = testQueue.toArray();
        String outString = "{";
        for(int i = 0; i < solutionArray.length - 1; i++) {
            //System.out.println(solutionArray[i]);
            outString += solutionArray[i];
            outString += ", ";
        }
        System.out.println(outString + solutionArray[solutionArray.length - 1] + "}");
    }
}
