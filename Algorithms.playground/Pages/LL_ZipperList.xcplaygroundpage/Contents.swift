import Foundation

func makeLinkedListZipperListIterative(head1: Node<Character>, head2: Node<Character>) -> Node<Character>? {
    var current1: Node? = head1
    var current2: Node? = head2
    var isEvenNumber: Bool = false
    var next: Node? = current1
    while next != nil {
        if isEvenNumber {
            next = current2?.next
            current2?.next = current1
            current2 = next
        } else {
            next = current1?.next
            current1?.next = current2
            current1 = next
        }
        isEvenNumber.toggle()
    }

    if isEvenNumber {
        current1?.next = current2
    } else {
        current2?.next = current1
    }

    return head1
}

func makeLinkedListZipperListRecursive(head1: Node<Character>?, head2: Node<Character>?, isEvenNumber: Bool = false) -> Node<Character>? {
    guard head1 != nil, head2 != nil else { return isEvenNumber ? head2 : head1 }
    var next: Node<Character>?
    if isEvenNumber {
        next = head2?.next
        head2?.next = head1
        makeLinkedListZipperListRecursive(head1: head1, head2: next, isEvenNumber: !isEvenNumber)
    } else {
        next = head1?.next
        head1?.next = head2
        makeLinkedListZipperListRecursive(head1: next, head2: head2, isEvenNumber: !isEvenNumber)
    }

    return head1
}

func traversal(head: Node<Character>?) {
    guard let head else { return }
    print(#function, head.value)
    traversal(head: head.next)
}

print("makeLinkedListZipperListIterative:")
let iterative: Node? = makeLinkedListZipperListIterative(head1: LinkedList.charactersList, head2: LinkedList.charactersList2)
traversal(head: iterative)
print("\nLinkedListZipperListRecursive:")
let recursive: Node? = makeLinkedListZipperListRecursive(head1: LinkedList.charactersList, head2: LinkedList.charactersList2)
traversal(head: recursive)
