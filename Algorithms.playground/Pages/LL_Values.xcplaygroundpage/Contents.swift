import Foundation

func makeLinkedListValuesIterative(head: Node<Character>) -> [Character] {
    var current: Node? = head
    var result: [Character?] = []
    while current != nil {
        result.append(current?.value)
        current = current?.next
    }

    return result.compactMap { $0 }
}

func makeLinkedListValuesRecursive(head: Node<Character>?) -> [Character] {
    guard let head else { return [] }
    return [head.value] + makeLinkedListValuesRecursive(head: head.next)
}

print("LinkedListValuesIterative:")
print(makeLinkedListValuesIterative(head: LinkedList.charactersList))
print("\nLinkedListValuesRecursive:")
print(makeLinkedListValuesRecursive(head: LinkedList.charactersList))
