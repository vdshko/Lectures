import Foundation

func makeDepthFirstValuesIterative(root: Node<Character>) -> [Character] {
    var result: [Character] = []
    var stack: [Node] = [root]
    while !stack.isEmpty {
        let topNode: Node = stack.removeLast()
        result.append(topNode.value)
        stack.append(contentsOf: [topNode.right, topNode.left].compactMap { $0 })
    }

    return result
}

func makeDepthFirstValuesRecursive(root: Node<Character>?) -> [Character] {
    guard let root else { return [] }
    return [root.value] + makeDepthFirstValuesRecursive(root: root.left) + makeDepthFirstValuesRecursive(root: root.right)
}

print("DepthFirstValuesIterative:")
print(makeDepthFirstValuesIterative(root: BinaryTree.charactersTree))
print("\nDepthFirstValuesRecursive:")
print(makeDepthFirstValuesRecursive(root: BinaryTree.charactersTree))
