import Foundation

func makeDepthFirstTraversalIterative(root: Node<Character>) {
    var stack: [Node] = [root]
    while !stack.isEmpty {
        let topNode: Node = stack.removeLast()
        print(topNode.value)
        stack.append(contentsOf: [topNode.right, topNode.left].compactMap { $0 })
    }
}

func makeDepthFirstTraversalRecursive(root: Node<Character>?) {
    guard let root else { return }
    print(root.value)
    makeDepthFirstTraversalRecursive(root: root.left)
    makeDepthFirstTraversalRecursive(root: root.right)
}

print("DepthFirstTraversalIterative:")
makeDepthFirstTraversalIterative(root: BinaryTree.charactersTree)
print("\nDepthFirstTraversalRecursive:")
makeDepthFirstTraversalRecursive(root: BinaryTree.charactersTree)
