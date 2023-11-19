import Foundation

func makeLinkedListTraversalIterative(head: Node<Character>) {
    var currentNode: Node? = head
    while currentNode != nil {
        print(currentNode?.value ?? "-")
        currentNode = currentNode?.next
    }
}

func makeLinkedListTraversalRecursive(head: Node<Character>?) {
    guard let head else { return }
    print(head.value)
    makeLinkedListTraversalRecursive(head: head.next)
}

print("LinkedListTraversalIterative:")
makeLinkedListTraversalIterative(head: LinkedList.charactersList)
print("\nLinkedListTraversalRecursive:")
makeLinkedListTraversalRecursive(head: LinkedList.charactersList)
