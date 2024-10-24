
public class LinkedList {
    Node head;

    static class Node {
        int data;
        Node next;

        Node(int val) {
            data = val;
            next = null;
        }
    }

    LinkedList() {
        head = null;
    }

    public void insertAtBeginning(int val) {
        Node newNode = new Node(val);

        if(head == null) {
            head = newNode;
        }else{
            newNode.next = head;
            head = newNode;
        }
    }

    public void display(){
        Node temp = head;
        while(temp != null) {
            System.out.print(temp.data + " ");
            temp = temp.next;
        }
    }

    public void insertAtPosition(int pos,int val) {
        if (pos==0){
            insertAtBeginning(val);
            return;
        }

        Node newNode = new Node(val);
        Node temp = head;
        for( int i=1; i<pos; i++) {
            temp = temp.next;
            if(temp == null) {
                System.out.println("Error");
                return;
            }
        }
        newNode.next = temp.next;
        temp.next = newNode;
    }

    public void deleteAtposition(int pos) {
        Node temp = head;
        Node prev = null;

        for(int i=1; i<=pos; i++){
            prev = temp;
            temp = temp.next;
        }
        prev.next = temp.next;
    }
}
