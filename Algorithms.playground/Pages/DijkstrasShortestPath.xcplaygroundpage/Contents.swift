import Foundation

let rootNode: Character = "A"
let destinationNode: Character = "C"

// (Neighbour left, Neighbour right, Distance)
let edges: [(Character, Character, Int)] = [
    ("A", "B", 2),
    ("A", "D", 8),
    ("B", "D", 5),
    ("B", "E", 6),
    ("D", "E", 3),
    ("D", "F", 2),
    ("E", "F", 1),
    ("E", "C", 9),
    ("F", "C", 3),
]

func makeGraph(from edges: [(Character, Character, Int)]) -> [Character: [(Character, Int)]] {
    return edges.reduce(into: [Character: [(Character, Int)]]()) {
        $0[$1.0, default: []].append(($1.1, $1.2))
        $0[$1.1, default: []].append(($1.0, $1.2))
    }
}

func makeBreadthFirstSearch(
    for graph: [Character: [(node: Character, value: Int)]],
    from rootNode: Character,
    to destinationNode: Character
) -> Int {
    var visitedList: Set<Character> = []
    var queue: [Character] = [rootNode]
    var table: [Character: (value: Int, node: Character)] = [rootNode: (0, "-")]
    while !queue.isEmpty {
        let topNode: Character = queue.removeLast()
        guard !visitedList.contains(topNode) else { continue }
        visitedList.insert(topNode)
        graph[topNode]?
            .filter { !visitedList.contains($0.node) }
            .forEach {
                let topNodeValues: (value: Int, node: Character) = table[topNode, default: (Int.max, "-")]
                let nextNodeValues: (value: Int, node: Character) = table[$0.node, default: (Int.max, "-")]
                let newValue: Int = $0.value + topNodeValues.value
                if newValue < nextNodeValues.value {
                    table[$0.node] = (newValue, topNode)
                }
                if !queue.contains($0.node) {
                    queue.insert($0.node, at: 0)
                }
            }
    }

    return table[destinationNode]?.value ?? 0
}

let graph: [Character: [(Character, Int)]] = makeGraph(from: edges)
graph.keys.sorted().forEach { print("\($0): \(graph[$0]!)") }

print("\nDijkstra Shortest Path [\(rootNode)] -> [\(destinationNode)]:")
print(makeBreadthFirstSearch(for: graph, from: rootNode, to: destinationNode))
