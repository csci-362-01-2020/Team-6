//driver for method: contains
//The contains method takes in an Object o. If the object is null, the method returns false. Otherwise, another method, internalContains, is called on Object o, and the boolean returned by this function call is returned for the method contains. The method internalContains checks if Object o is equal to any element in the elements array (the elements array is defined elsewhere in the code). If equal, true is returned. Otherwise, false.

import java.util.*;

public class containsTestDriver {
    public static void main(String[] args)
    {
        //create instance of the class ThreadSafeCircularFifoQueue of type Integer
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();

        int startArg = 0;
        int endArg;


        //create integer array to hold the values passed in from the test case arguments
        //args1 corresponds with the elements list used in the internalContains method, which is called by the contains method
        ArrayList<Integer> args1 = new ArrayList<Integer>();

        //args2 corresponds with the contains method argument
        Object args2;

        //refers to the first argument
        boolean first = true;

        //loop through test case arguments
        for(int i = 0; i < args.length; i++) {
            //aka if the "elements list" is null, then make args1 = null
            if(args[i].contains("null") && first) {
                args1 = null;
                first = false;
                //startArg is initially set to 0
                startArg++;

                /////////////////////////////////////////////////////////////
                //could add a function call or thrown exception if args1 is
                //null, though not absolutely necessary for these particular
                //test cases
                /////////////////////////////////////////////////////////////
            }
            //else if the second argument is null, then set args2 to equal null
            else if(args[i].contains("null") && !first) {
                args2 = null;

                //contains should return false if its input is null, no matter what args1 is
                System.out.println(testQueue.contains(args2));
                
                //no need to go futher --> end main method here for this test case
                //System.exit(i);
                //break;
            }
            //if you reach the end of the first argument list
            else if(args[i].contains("}") && first) {
                first = false;
                //endArg = last index of the first argument string
                endArg = i;
                while(startArg <= endArg) {
                    //formatting args1
                    args1.add(Integer.parseInt(args[startArg].replace("{", "").replace(",", "").replace("}", "")));
                    
                    startArg++;

                }

                                
                //second argument then comes after the end of the first
                args2 = args[endArg + 1];

                ////////////////DELETE ME/////////////////////////
                //System.out.println("args1 formatting: " + args1);
                //System.out.println("args2: " + args2);
                //////////////////////////////////////////////////
                
                //add contents of args1 to testQueue
                testQueue.addAll(args1);

                ///////////////////////TESTING PURPOSES;DELETE ME///////////////////////////
                ////////////////////////////////////////////////////////////////////////////
                //System.out.println("testQueue contents : " + testQueue);

                //for(Integer item:testQueue)
                //{
                  //  System.out.println(item);
                //}
                ////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////


                
                //////////////////////////////////////////////////////////////////////////////////////////////
                //NOTE: A SPACE AT THE END OF THE TEST DATA LINE IN EACH TEST CASE FILE MAKES A DIFFERENCE
                //IN THE FUNCTIONING OF THE BELOW CODE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                //////////////////////////////////////////////////////////////////////////////////////////////

                try 
                {
                    //need to pass in an Integer type, instead of String
                    int containsArg = Integer.parseInt(args[endArg + 1]);

                    //need to make args2 an Integer type, instead of Object
                    //int containsArg = (Integer) args2;
                    //int containsArg = (int) args2;

                    //call the contains method with given test case argument to get test results
                    System.out.println(testQueue.contains(containsArg));

                } //end of try block
                
                catch (Exception e) {
                    //TODO: handle exception
                    //possible NumberFormatException?
                    //System.out.println("Error");

                    //if the value cannot be converted to an Integer, then pass the value into contains as is
                    System.out.println(testQueue.contains(args[endArg + 1]));

                }//end of catch block



            }
            
           
        

        }//end of for loop

    
    }//end of main 
}//end of class
