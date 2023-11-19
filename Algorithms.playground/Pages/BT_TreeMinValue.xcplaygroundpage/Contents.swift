import Foundation

func makeDepthFirstTreeMinValueIterative(root: Node<Int>) -> Int {
    var minValue: Int = Int.max
    var stack: [Node] = [root]
    while !stack.isEmpty {
        let topNode: Node = stack.removeLast()
        minValue = min(minValue, topNode.value)
        stack.append(contentsOf: [topNode.right, topNode.left].compactMap { $0 })
    }

    return minValue
}

func makeDepthFirstTreeMinValueRecursive(root: Node<Int>?) -> Int {
    guard let root else { return Int.max }
    return min(root.value, min(makeDepthFirstTreeMinValueRecursive(root: root.left), makeDepthFirstTreeMinValueRecursive(root: root.right)))
}

func makeBreadthFirstTreeMinValueIterative(root: Node<Int>) -> Int {
    var minValue: Int = Int.max
    var queue: [Node] = [root]
    while !queue.isEmpty {
        let topNode: Node = queue.removeLast()
        minValue = min(minValue, topNode.value)
        [topNode.left, topNode.right].compactMap { $0 }.forEach { queue.insert($0, at: 0) }
    }

    return minValue
}

print("DepthFirstTreeMinValueIterative:")
print(makeDepthFirstTreeMinValueIterative(root: BinaryTree.numbersTree))
print("\nDepthFirstTreeMinValueRecursive:")
print(makeDepthFirstTreeMinValueRecursive(root: BinaryTree.numbersTree))
print("\nBreadthFirstTreeMinValueIterative:")
print(makeBreadthFirstTreeMinValueIterative(root: BinaryTree.numbersTree))
