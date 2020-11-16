public class testCase11Driver {
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        for(int i = 0; i < args.length; i++) {
            System.out.println(args[i]);
        }
        //System.out.println(testQueue.toArray(args[0]));
    }
}
