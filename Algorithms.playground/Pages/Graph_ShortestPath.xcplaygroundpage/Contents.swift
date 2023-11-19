import Foundation

let rootNode: Character = "w"
let destinationNode: Character = "z"
let edges: [[Character]] = [
    ["w", "x"],
    ["x", "y"],
    ["z", "y"],
    ["z", "v"],
    ["w", "v"],
]

func makeGraph(from edges: [[Character]]) -> [Character: [Character]] {
    return edges.reduce(into: [Character: [Character]]()) {
        $0[$1[0], default: []].append($1[1])
        $0[$1[1], default: []].append($1[0])
    }
}

func makeBreadthFirstSearch(
    for graph: [Character: [Character]],
    from rootNode: Character,
    to destinationNode: Character
) -> Int {
    var visitedList: Set<Character> = []
    var queue: [(Character, Int)] = [(rootNode, 0)]
    while !queue.isEmpty {
        let topNode: (Character, Int) = queue.removeLast()
        guard !visitedList.contains(topNode.0) else { continue }
        visitedList.insert(topNode.0)
        guard topNode.0 != destinationNode else { return topNode.1 }
        graph[topNode.0]?
            .filter { !visitedList.contains($0) }
            .forEach { queue.insert(($0, topNode.1 + 1), at: 0) }
    }

    return -1
}

print("Graph:")
let graph: [Character: [Character]] = makeGraph(from: edges)
graph.map { print("\($0.key): \($0.value)") }
print("\nBreadthFirstSearchIterative:")
print(makeBreadthFirstSearch(for: graph, from: rootNode, to: destinationNode))
