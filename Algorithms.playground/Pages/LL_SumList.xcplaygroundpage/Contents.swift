import Foundation

func makeLinkedListSumListIterative(head: Node<Int>) -> Int {
    var current: Node? = head
    var result: Int = 0
    while current != nil {
        result += current?.value ?? 0
        current = current?.next
    }

    return result
}

func makeLinkedListSumListRecursive(head: Node<Int>?) -> Int {
    guard let head else { return 0 }
    return head.value + makeLinkedListSumListRecursive(head: head.next)
}

print("makeLinkedListSumListIterative:")
print(makeLinkedListSumListIterative(head: LinkedList.numbersList))
print("\nLinkedListSumListRecursive:")
print(makeLinkedListSumListRecursive(head: LinkedList.numbersList))
