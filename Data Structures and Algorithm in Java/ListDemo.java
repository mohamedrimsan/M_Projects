public class ListDemo   {

    public static void main(String[] args) {
        LinkedList list = new LinkedList();
        list.insertAtBeginning(9);
        list.insertAtBeginning(8);
        list.insertAtBeginning(7);
        list.display();

        System.out.println(" ");
        list.insertAtPosition(6,10);
        list.display();

        list.deleteAtposition(3);
        list.display();
    }
}
