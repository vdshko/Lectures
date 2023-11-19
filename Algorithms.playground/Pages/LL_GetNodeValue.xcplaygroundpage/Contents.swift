import Foundation

func makeLinkedListGetNodeValueIterative(head: Node<Character>, target index: Int) -> Character? {
    var current: Node? = head
    var count: Int = 0
    while current != nil {
        guard count != index else { return current?.value }
        current = current?.next
        count += 1
    }

    return nil
}

func makeLinkedListGetNodeValueRecursive(head: Node<Character>?, target index: Int) -> Character? {
    guard let head else { return nil }
    guard index != 0 else { return head.value }
    return makeLinkedListGetNodeValueRecursive(head: head.next, target: index - 1)
}

print("makeLinkedListGetNodeValueIterative:")
print(makeLinkedListGetNodeValueIterative(head: LinkedList.charactersList, target: 2))
print("\nLinkedListGetNodeValueRecursive:")
print(makeLinkedListGetNodeValueRecursive(head: LinkedList.charactersList, target: 2))
