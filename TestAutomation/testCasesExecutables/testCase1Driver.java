public class testCase1Driver {
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        System.out.println(testQueue.contains(args[0]));
    }
}