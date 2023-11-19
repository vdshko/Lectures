import Foundation

func makeLinkedListFindIterative(head: Node<Character>, target: Character) -> Bool {
    var current: Node? = head
    while current != nil {
        guard current?.value != target else { return true }
        current = current?.next
    }

    return false
}

func makeLinkedListFindRecursive(head: Node<Character>?, target: Character) -> Bool {
    guard let head else { return false }
    guard head.value != target else { return true }
    return makeLinkedListFindRecursive(head: head.next, target: target)
}

print("makeLinkedListFindIterative:")
print(makeLinkedListFindIterative(head: LinkedList.charactersList, target: "C"))
print("\nLinkedListFindRecursive:")
print(makeLinkedListFindRecursive(head: LinkedList.charactersList, target: "C"))
