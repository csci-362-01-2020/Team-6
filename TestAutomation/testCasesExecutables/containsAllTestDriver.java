import java.util.*;
public class containsAllTestDriver {
    public static void main(String[] args) {
        ThreadSafeCircularFifoQueue<Integer> testQueue = new ThreadSafeCircularFifoQueue<Integer>();
        //Parsing the arguments passed in through the command line
        int startArg = 0;
        int endArg;
        ArrayList<Integer> args1 = new ArrayList<Integer>();
        ArrayList<Integer> args2 = new ArrayList<Integer>();
        
        //First to determine which arrayList to use for arguments
        boolean first = true;

        /*
        Methodology for the for loop:

        The argument list will be constructed as followed:

        Some string consisting of two pairs of braces with some number 
        of values between each pair of braces with each value ending in 
        either a comma or a right brace.
        Some string consisting of one pair of braces with some number 
        of values between the first pair with each value ending in either
        a comma or a right brace, which is then followed by the string 
        "null"
        The string "null" followed by a pair of braces with some number
        of values between the pair of braces with each value ending in
        either a comma or a right brace.
        The string "null" followed by the string "null"

        Thus, each argument ends in either ",", "}" or "null," the latter
        two are delimiters. In the instance where the argument ends with 
        null, the corresponding list is set to null and the next argument
        begins. In the instance where the argument ends with }, each value
        is parsed and added to the list, at the end of which is then 
        the beginning of the next argument.

        */
        for(int i = 0; i < args.length; i++) {

            //Option for checking against a null list
            if(args[i].contains("null") && first) {
                args1 = null;
                first = false;
                startArg++;
            }

            //Option for checking for null within a list
            else if(args[i].contains("null") && !first) {
                args2 = null;
            }

            //Option for populating the first argument 
            else if(args[i].contains("}") && first) {
                first = false;
                endArg = i;
                while(startArg <= endArg) {
                    args1.add(Integer.parseInt(args[startArg].replace("{", "").replace(",", "").replace("}", "")));
                    startArg++;
                }
            }

            //Second argument list construction
            else if(args[i].contains("}") && !first) {
                endArg = i;
                while(startArg <= endArg) {
                    args2.add(Integer.parseInt(args[startArg].replace("{", "").replace(",", "").replace("}", "")));
                    startArg++;
                }
            }
        }

        //Adding non-null arguments to the Queue
        if(args1 != null) {
            testQueue.addAll(args1);
        }

        System.out.println(testQueue.containsAll(args2));
    }
    
}
