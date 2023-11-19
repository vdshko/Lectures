import Foundation

let graph: [Character: [Character]] = [
    "a": ["b", "c"],
    "b": ["d"],
    "c": ["e"],
    "d": ["f"],
    "e": [],
    "f": [],
]

func makeDepthFirstSearchIterative(for graph: [Character: [Character]], node: Character) {
    var stack: [Character] = [node]
    while !stack.isEmpty {
        let topNode: Character = stack.removeLast()
        print(topNode)
        stack.append(contentsOf: graph[topNode, default: []])
    }
}

func makeDepthFirstSearchRecursive(for graph: [Character: [Character]], node: Character) {
    print(node)
    graph[node]?.forEach { makeDepthFirstSearchRecursive(for: graph, node: $0) }
}

print("Iterative:")
makeDepthFirstSearchIterative(for: graph, node: "a")
print("\nRecursive:")
makeDepthFirstSearchRecursive(for: graph, node: "a")
