
import java.util.Scanner;

class DynamicArray{
    private static final int initialCapacity = 16;
    private int[] arr;
    private int size;
    private int capacity;

    DynamicArray(){
        arr = new int[initialCapacity];
        size = 0;
        capacity = initialCapacity;
    }
    public void add(int val){
        if(size == capacity)
            expandArray();

        arr[size] = val;
        size++;
    }
    private void expandArray(){
        capacity *= 2;
        arr = java.util.Arrays.copyOf(arr, capacity);
    }

    public void display(){
        for(int i=0;i<size;i++)
            System.out.print(arr[i]+" ");
    }

    public void insertAtPos(int pos, int val){
        if(size == capacity)
            expandArray();
        for(int i=size-1; i>pos; i--)
            arr[i+1] = arr[i];
        arr[pos] = val;
        size++;
    }

    public void deleteAtPos(int pos){
        for(int i=pos+1;i<size;i++)
            arr[i-1] = arr[i];
    }
}

public class DynamicArrayDemo {
    public static void main(String[] args){
        int val;
        int pos;
        Scanner scanner = new Scanner(System.in);
        DynamicArray list = new DynamicArray();
        while(true){
            System.out.println("\n ---------------- List Menu ----------------\n");
            System.out.println("1. Insert at End \n");
            System.out.println("2. Display the list \n");
            System.out.println("3. Insert at Specified position \n");
            System.out.println("4. Delete from specified position \n");
            System.out.println("5. Exit \n");
            System.out.println("\n --------------------------------\n");
            System.out.println("Enter your choice: \t");

            int choice = scanner.nextInt();
            switch(choice){
                case 1: System.out.println("Enter the Data:  ");

                    val = scanner.nextInt();
                    list.add(val);
                    break;
                case 2:list.display();
                    break;
                case 3: System.out.println("Enter the Position:  ");
                    pos = scanner.nextInt();
                    if(pos<0){
                        System.out.println("Invalid Position");
                    }
                    System.out.println("Enter the Data:  ");
                    val = scanner.nextInt();
                    list.insertAtPos(pos,val);
                    break;
                case 4: System.out.println("Enter the Position:  ");
                    pos = scanner.nextInt();
                    if(pos<0){
                        System.out.println("Invalid Position");
                    }
                    list.deleteAtPos(pos);
                    break;
                case 5: System.exit(0);
                default:
                    System.out.println("Invalid choice");
            }
        }

    }
}
