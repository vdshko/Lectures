import Foundation

func makeBreadthFirstTraversalIterative(root: Node<Character>) {
    var queue: [Node] = [root]
    while !queue.isEmpty {
        let topNode: Node = queue.removeLast()
        print(topNode.value)
        [topNode.left, topNode.right].compactMap { $0 }.forEach { queue.insert($0, at: 0) }
    }
}

print("BreadthFirstTraversalIterative:")
makeBreadthFirstTraversalIterative(root: BinaryTree.charactersTree)
