import java.util.Scanner;

public class Emc {
    static String doc1 = ("Dr.MHM.Sabir");
   static String doc2 = ("Dr.AAM.Anfas");
   static String doc3 = ("Dr.AAM.Fuhaim");
   static String doc4 = ("Dr.Nasmi");
   static String doc5 = ("Dr.Sangeetha");
   static String doc6 = ("Dr.Raseen");
   static String doc7 = ("Dr.Sameem");
   static String doc8 = ("Dr.Kalaventhan");

    public static void main(String[] args){
        Scanner scanner = new Scanner(System.in);
        System.out.println("Welcome to Eastern Medical Center");
        System.out.print("Enter your Employee ID: ");
        String userId = scanner.nextLine();

        System.out.print("Enter your Password: ");
        String password = scanner.nextLine();

        boolean authorized = false; // to access the main menu by authorized person only

        if (userId.equals("Admin") && password.equals(userId)){
            System.out.println("Welcome " + userId);
            authorized = true;
        } else if (userId.equals("User") && password.equals(userId)) {
            authorized = true;
        } else{
            System.out.println("Sorry! You are not an authorized person");
        }

        if (authorized){ // if the user is authorized to use main menu
            boolean exit = false;

            while(!exit){
                System.out.println("\nMain Menu: ");
                System.out.println("1.Book Doctor");
                System.out.println("2.Doctors List");
                System.out.println("3.Doctors Schedule");
                System.out.println("4.Print Receipt");
                System.out.println("5.Exit");

                System.out.print("Enter Your Choice: ");
                int choice = scanner.nextInt();

                switch (choice){
                    case 1:
                        bookDoctor(scanner);
                        break;
                    case 2:
                        doctorsList();
                        break;
                    case 3:
                        doctorsSchedule(scanner);
                        break;
                    case 4:
                        printReceipt();
                        break;
                    case 5:
                       exit = true;
                       System.out.println("Thank you for choosing Eastern Medical Center " + userId);
                        break;
                    default:
                        System.out.println("Invalid Choice Try Again " + userId);
                        break;
                }
            }

        }

scanner.close();

    }

    public static void bookDoctor(Scanner scanner){
        System.out.print("Enter Patient Name: ");
        scanner.nextLine();
        String patientName = scanner.nextLine();

        System.out.print("Male/Female: ");
        String gender = scanner.nextLine();

        System.out.print("Enter the patient's Age: ");
        int patientAge = Integer.parseInt(scanner.nextLine());

        System.out.print("Enter the Doctor Name: ");
        String doctorName = scanner.nextLine();
        
        if (doctorName.equals(doc1)){
            System.out.println(doc1);
        } else if (doctorName.equals(doc2)) {
            System.out.println(doc2);
        } else if (doctorName.equals(doc3)) {
            System.out.println(doc3);
        } else if (doctorName.equals(doc4)) {
            System.out.println(doc4);
        } else if (doctorName.equals(doc5)) {
            System.out.println(doc5);
        } else if (doctorName.equals(doc6)) {
            System.out.println(doc6);
        } else if (doctorName.equals(doc7)) {
            System.out.println(doc7);
        } else if (doctorName.equals(doc8)) {
            System.out.println(doc8);
        }else {
            System.out.println("Sorry! there no Doctors under this name " + doctorName);
        }

        System.out.print("Confirm your booking! Y/N?: ");
        char confirmation = scanner.next().charAt(0);
        confirmation = Character.toUpperCase(confirmation);

        if (confirmation == 'Y'){
            System.out.println("Your Booking Successful " + patientName);
        } else {
            System.out.println("Your Booking Unsuccessful " + patientName);
        }

    }

    public static void doctorsList(){
        System.out.println("1. OPD: " + doc1);
        System.out.println("2. Consultant General Physician: " + doc2);
        System.out.println("3. Consultant Sports and Exercise Medicine: " + doc3);
        System.out.println("4. Consultant Pediatrician: " + doc4);
        System.out.println("5. Consultant Radiologist: " + doc5);
        System.out.println("6. Consultant Gynaecologist: " + doc6);
        System.out.println("7. Consultant General Surgeon: " + doc7);
        System.out.println("8. Consultant Orthopaedic Surgeon: " + doc8);
        
    }
    public static void doctorsSchedule(Scanner Scanner){
        System.out.println("\nDoctor's are Usually visit between 4.30Pm to 9.30Pm");

        System.out.print("Enter the Preferred Day: ");
        Scanner.nextLine();
        String prefDay = Scanner.nextLine();

        switch (prefDay){
            case "Monday":
                System.out.println("24/7 Out Patient Division Available: " + doc1);
                System.out.println("1. Consultant General Physician: " + doc2);
                System.out.println("2. Consultant Pediatrician: " + doc4);
                System.out.println("3. Consultant Gynaecologist: " + doc6);
                break;

            case "Tuesday":
                System.out.println("24/7 Out Patient Division Available: " + doc1);
                System.out.println("1. Consultant Sports and Exercise Medicine: " + doc3);
                System.out.println("2. Consultant Radiologist: " + doc5);
                System.out.println("3. Consultant General Surgeon: " + doc7);
                break;

            case "Wednesday":
                System.out.println("24/7 Out Patient Division Available: " + doc1);
                System.out.println("1. Consultant Orthopaedic Surgeon: " + doc8);
                System.out.println("2. Consultant Pediatrician: " + doc4);
                System.out.println("3. Consultant General Physician: " + doc2);
                break;

            case "Thursday":
                System.out.println("24/7 Out Patient Division Available: " + doc1);
                System.out.println("1. Consultant Radiologist: " + doc5);
                System.out.println("2. Consultant Gynaecologist: " + doc6);
                System.out.println("3. Consultant Sports and Exercise Medicine: " + doc3);
                break;

            case "Friday":
                System.out.println("24/7 Out Patient Division Available: " + doc1);
                System.out.println("1. Consultant Orthopaedic Surgeon: " + doc8);
                System.out.println("2. Consultant General Surgeon: " + doc7);
                System.out.println("3. Consultant Pediatrician: " + doc4);
                break;

            case "Saturday":
                System.out.println("24/7 Out Patient Division Available: " + doc1);
                System.out.println("1. Consultant General Physician: " + doc2);
                System.out.println("2. Consultant Orthopaedic Surgeon: " + doc8);
                System.out.println("3. Consultant Pediatrician: " + doc4);
                break;

            case "Sunday":
                System.out.println("24/7 Out Patient Division Available: " + doc1);
                System.out.println("1. Consultant Radiologist: " + doc5);
                System.out.println("2. Consultant Orthopaedic Surgeon: " + doc8);
                System.out.println("3. Consultant General Surgeon: " + doc7);
                break;

            default:
                System.out.println("If you have any further inquiries, Don't Hesitate to ask Receptionist");
        }
    }
    public static void printReceipt(){
        System.out.println("Your Receipt Printed Successfully");
        System.out.println("Have a Nice Day");
    }
}
