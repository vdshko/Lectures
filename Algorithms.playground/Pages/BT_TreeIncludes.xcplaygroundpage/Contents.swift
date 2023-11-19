import Foundation

func makeDepthFirstTreeIncludesIterative(root: Node<Character>, target: Character) -> Bool {
    var stack: [Node] = [root]
    while !stack.isEmpty {
        let topNode: Node = stack.removeLast()
        guard topNode.value != target else { return true }
        stack.append(contentsOf: [topNode.right, topNode.left].compactMap { $0 })
    }

    return false
}

func makeDepthFirstTreeIncludesRecursive(root: Node<Character>?, target: Character) -> Bool {
    guard let root else { return false }
    guard root.value != target else { return true }
    return makeDepthFirstTreeIncludesRecursive(root: root.left, target: target) || makeDepthFirstTreeIncludesRecursive(root: root.right, target: target)
}

func makeBreadthFirstTreeIncludesIterative(root: Node<Character>, target: Character) -> Bool {
    var queue: [Node] = [root]
    while !queue.isEmpty {
        let topNode: Node = queue.removeLast()
        guard topNode.value != target else { return true }
        [topNode.left, topNode.right].compactMap { $0 }.forEach { queue.insert($0, at: 0) }
    }

    return false
}

print("DepthFirstTreeIncludesIterative:")
print(makeDepthFirstTreeIncludesIterative(root: BinaryTree.charactersTree, target: "E"))
print("\nDepthFirstTreeIncludesRecursive:")
print(makeDepthFirstTreeIncludesRecursive(root: BinaryTree.charactersTree, target: "E"))
print("\nBreadthFirstTreeIncludesIterative:")
print(makeBreadthFirstTreeIncludesIterative(root: BinaryTree.charactersTree, target: "E"))
