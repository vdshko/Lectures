import Foundation

let rootNode: Character = "f"
let destinationNode: Character = "k"
let graph: [Character: [Character]] = [
    "f": ["g", "i"],
    "g": ["h"],
    "h": [],
    "i": ["g", "k"],
    "j": ["i"],
    "k": [],
]

func makeDepthFirstSearchIterative(
    for graph: [Character: [Character]],
    from rootNode: Character,
    to destinationNode: Character
) -> Bool {
    var stack: [Character] = [rootNode]
    while !stack.isEmpty {
        let topNode: Character = stack.removeLast()
        guard topNode != destinationNode else { return true }
        stack.append(contentsOf: graph[topNode, default: []])
    }

    return false
}

func makeDepthFirstSearchRecursive(
    for graph: [Character: [Character]],
    from rootNode: Character,
    to destinationNode: Character
) -> Bool {
    guard rootNode != destinationNode else { return true }
    for node in graph[rootNode, default: []] {
        if makeDepthFirstSearchRecursive(for: graph, from: node, to: destinationNode) {
            return true
        }
    }

    return false
}

func makeBreadthFirstSearch(
    for graph: [Character: [Character]],
    from rootNode: Character,
    to destinationNode: Character
) -> Bool {
    var queue: [Character] = [rootNode]
    while !queue.isEmpty {
        let topNode: Character = queue.removeLast()
        guard topNode != destinationNode else { return true }
        graph[topNode]?.forEach { queue.insert($0, at: 0) }
    }

    return false
}

print("DepthFirstSearch_Iterative:")
print(makeDepthFirstSearchIterative(for: graph, from: rootNode, to: destinationNode))
print("\nDepthFirstSearch_Recursive:")
print(makeDepthFirstSearchRecursive(for: graph, from: rootNode, to: destinationNode))
print("\nBreadthFirstSearchIterative:")
print(makeBreadthFirstSearch(for: graph, from: rootNode, to: destinationNode))
