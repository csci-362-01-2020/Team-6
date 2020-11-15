public class testCase6Driver {
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        System.out.println(testQueue.add(Integer.parseInt(args[0])));
    }
}
