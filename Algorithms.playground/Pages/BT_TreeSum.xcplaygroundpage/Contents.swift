import Foundation

func makeDepthFirstTreeSumIterative(root: Node<Int>) -> Int {
    var result: Int = 0
    var stack: [Node] = [root]
    while !stack.isEmpty {
        let topNode: Node = stack.removeLast()
        result += topNode.value
        stack.append(contentsOf: [topNode.right, topNode.left].compactMap { $0 })
    }

    return result
}

func makeDepthFirstTreeSumRecursive(root: Node<Int>?) -> Int {
    guard let root else { return 0 }
    return root.value + makeDepthFirstTreeSumRecursive(root: root.left) + makeDepthFirstTreeSumRecursive(root: root.right)
}

func makeBreadthFirstTreeSumIterative(root: Node<Int>) -> Int {
    var result: Int = 0
    var queue: [Node] = [root]
    while !queue.isEmpty {
        let topNode: Node = queue.removeLast()
        result += topNode.value
        [topNode.left, topNode.right].compactMap { $0 }.forEach { queue.insert($0, at: 0) }
    }

    return result
}

print("DepthFirstTreeSumIterative:")
print(makeDepthFirstTreeSumIterative(root: BinaryTree.numbersTree))
print("\nDepthFirstTreeSumRecursive:")
print(makeDepthFirstTreeSumRecursive(root: BinaryTree.numbersTree))
print("\nBreadthFirstTreeSumIterative:")
print(makeBreadthFirstTreeSumIterative(root: BinaryTree.numbersTree))
