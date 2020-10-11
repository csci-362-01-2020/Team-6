import org.openmrs.User;

public class testCase1Driver extends User {
    public static void main(String[] args) {
        Role testRole = new Role("Doctor");
        User testUser = new User();
        testUser.addRole(testRole);
        testUser.addRole(SUPERUSER);
        boolean testOut = testUser.hasRole(args[0], args[1]);
        if(testOut) {
            System.out.println("true");
        }
        else {
            System.out.println("false");
        }
    }
}