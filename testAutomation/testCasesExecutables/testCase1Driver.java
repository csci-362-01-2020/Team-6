public class testCase1Driver {
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        testQueue.add(17);
        testQueue.add(21);
        System.out.println(testQueue);
    }
}
