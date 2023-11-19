import Foundation

func makeBreadthFirstValuesIterative(root: Node<Character>) -> [Character] {
    var result: [Character] = []
    var queue: [Node] = [root]
    while !queue.isEmpty {
        let topNode: Node = queue.removeLast()
        result.append(topNode.value)
        [topNode.left, topNode.right].compactMap { $0 }.forEach { queue.insert($0, at: 0) }
    }

    return result
}

print("BreadthFirstValuesIterative:")
print(makeBreadthFirstValuesIterative(root: BinaryTree.charactersTree))
