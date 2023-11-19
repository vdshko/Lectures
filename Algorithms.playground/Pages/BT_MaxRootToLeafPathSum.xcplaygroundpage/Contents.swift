import Foundation

func makeDepthFirstMaxRootToLeafPathSumIterative(root: Node<Int>) -> Int {
    var maxSum: Int = 0
    var stack: [(node: Node, currentSum: Int)] = [(root, 0)]
    while !stack.isEmpty {
        let topValues: (node: Node, currentSum: Int) = stack.removeLast()
        let currentSum: Int = topValues.node.value + topValues.currentSum
        let content: [(node: Node, currentSum: Int)] = [topValues.node.right, topValues.node.left]
            .compactMap { $0 }
            .map { ($0, currentSum) }
        if topValues.node.left == nil, topValues.node.right == nil {
            maxSum = max(maxSum, currentSum)
        }
        stack.append(contentsOf: content)
    }

    return maxSum
}

func makeDepthFirstMaxRootToLeafPathSumRecursive(root: Node<Int>?) -> Int {
    guard let root else { return 0 }
    return root.value + max(makeDepthFirstMaxRootToLeafPathSumRecursive(root: root.left), makeDepthFirstMaxRootToLeafPathSumRecursive(root: root.right))
}

func makeBreadthFirstTreeMinValueIterative(root: Node<Int>) -> Int {
    var maxSum: Int = 0
    var queue: [(node: Node, currentSum: Int)] = [(root, 0)]
    while !queue.isEmpty {
        let topValues: (node: Node, currentSum: Int) = queue.removeLast()
        let currentSum: Int = topValues.node.value + topValues.currentSum
        if topValues.node.left == nil, topValues.node.right == nil {
            maxSum = max(maxSum, currentSum)
        }
        [topValues.node.left, topValues.node.right]
            .compactMap { $0 }
            .map { ($0, currentSum) }
            .forEach { queue.insert($0, at: 0) }
    }

    return maxSum
}

print("DepthFirstMaxRootToLeafPathSumIterative:")
print(makeDepthFirstMaxRootToLeafPathSumIterative(root: BinaryTree.numbersTree))
print("\nDepthFirstMaxRootToLeafPathSumRecursive:")
print(makeDepthFirstMaxRootToLeafPathSumRecursive(root: BinaryTree.numbersTree))
print("\nBreadthFirstTreeMinValueIterative:")
print(makeBreadthFirstTreeMinValueIterative(root: BinaryTree.numbersTree))
