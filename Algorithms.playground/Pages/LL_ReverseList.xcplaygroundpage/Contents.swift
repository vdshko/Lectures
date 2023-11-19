import Foundation

func makeLinkedListReverseListIterative(head: Node<Character>) -> Node<Character>? {
    var previous: Node<Character>?
    var current: Node? = head
    while current != nil {
        let next: Node? = current?.next
        current?.next = previous
        previous = current
        current = next
    }

    return previous
}

func makeLinkedListReverseListRecursive1(head: Node<Character>?, previous: Node<Character>? = nil) -> Node<Character>? {
    guard let head else { return previous }
    let next: Node? = head.next
    head.next = previous

    return makeLinkedListReverseListRecursive1(head: next, previous: head)
}

func makeLinkedListReverseListRecursive2(head: Node<Character>?) -> Node<Character>? {
    guard let head else { return nil }
    let next: Node? = head.next
    head.next = nil
    let result: Node? = makeLinkedListReverseListRecursive2(head: next) ?? head
    next?.next = head

    return result
}

func traversal(head: Node<Character>?) {
    guard let head else { return }
    print(#function, head.value)
    traversal(head: head.next)
}

print("makeLinkedListReverseListIterative:")
let iterative: Node? = makeLinkedListReverseListIterative(head: LinkedList.charactersList)
print(iterative?.value ?? "-")
traversal(head: iterative)
print("\nLinkedListReverseListRecursive1:")
let recursive: Node? = makeLinkedListReverseListRecursive1(head: LinkedList.charactersList)
print(recursive?.value ?? "-")
traversal(head: recursive)
print("\nLinkedListReverseListRecursive2:")
let recursive2: Node? = makeLinkedListReverseListRecursive2(head: LinkedList.charactersList)
print(recursive2?.value ?? "-")
traversal(head: recursive2)
