import java.util.Scanner;

public class GPACalculator {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the number of courses: ");
        int numCourses = scanner.nextInt();

        String[] courseNames = new String[numCourses];
        int[] creditHours = new int[numCourses];
        double[] fems = new double[numCourses];  // Final Examination Marks

        for (int i = 0; i < numCourses; i++) {
            System.out.println("\nEnter details for Course " + (i + 1) + ":");
            System.out.print("Course Name: ");
            courseNames[i] = scanner.next();
            System.out.print("Credit Hours: ");
            creditHours[i] = scanner.nextInt();
            System.out.print("Final Examination Mark (%): ");
            fems[i] = scanner.nextDouble();
        }

        double totalGradePoints = 0;
        int totalCredits = 0;
        for (int i = 0; i < numCourses; i++) {
            double fem = fems[i]; // Using only the final examination mark
            double gradePointValue;
            String overallGrade;
            // Determine Overall Grade and Grade Point Value based on Final Examination Mark
            if (fem >= 85) {
                overallGrade = "A+";
                gradePointValue = 4;
            } else if (fem >= 70) {
                overallGrade = "A";
                gradePointValue = 4;
            } else if (fem >= 65) {
                overallGrade = "A-";
                gradePointValue = 3.7;
            } else if (fem >= 60) {
                overallGrade = "B+";
                gradePointValue = 3.3;
            } else if (fem >= 55) {
                overallGrade = "B";
                gradePointValue = 3;
            } else if (fem >= 50) {
                overallGrade = "B-";
                gradePointValue = 2.7;
            } else if (fem >= 45) {
                overallGrade = "C+";
                gradePointValue = 2.3;
            } else if (fem >= 40) {
                overallGrade = "C";
                gradePointValue = 2;
            } else if (fem >= 35) {
                overallGrade = "C-";
                gradePointValue = 1.7;
            } else if (fem >= 30) {
                overallGrade = "D+";
                gradePointValue = 1.3;
            } else if (fem >= 20) {
                overallGrade = "D";
                gradePointValue = 1;
            } else {
                overallGrade = "E";
                gradePointValue = 0;
            }
            // Calculate credit-weighted Grade Point Value
            totalGradePoints += gradePointValue * creditHours[i];
            totalCredits += creditHours[i];
            System.out.println("Course: " + courseNames[i] + ", Grade: " + overallGrade + ", Credit Hours: " + creditHours[i]);
        }

        // Calculate GPA
        double gpa = totalGradePoints / totalCredits;
        System.out.println("\nYour GPA is: " + String.format("%.2f", gpa));

        scanner.close();
    }
}
