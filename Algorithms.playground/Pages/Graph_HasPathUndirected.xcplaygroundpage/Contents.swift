import Foundation

let rootNode: Character = "j"
let destinationNode: Character = "m"
let edges: [[Character]] = [
    ["i", "j"],
    ["k", "i"],
    ["m", "k"],
    ["k", "l"],
    ["o", "n"],
]

func makeGraph(from edges: [[Character]]) -> [Character: [Character]] {
    return edges.reduce(into: [Character: [Character]]()) {
        $0[$1[0], default: []].append($1[1])
        $0[$1[1], default: []].append($1[0])
    }
}

func makeDepthFirstSearchIterative(
    for graph: [Character: [Character]],
    from rootNode: Character,
    to destinationNode: Character
) -> Bool {
    var stack: [Character] = [rootNode]
    var visitedList: Set<Character> = []
    while !stack.isEmpty {
        let topNode: Character = stack.removeLast()
        guard topNode != destinationNode else { return true }
        guard !visitedList.contains(topNode) else { continue }
        visitedList.insert(topNode)
        stack.append(contentsOf: graph[topNode, default: []].filter { !visitedList.contains($0) })
    }

    return false
}

func makeDepthFirstSearchRecursive(
    for graph: [Character: [Character]],
    from rootNode: Character,
    to destinationNode: Character,
    with visitedList: Set<Character> = []
) -> Bool {
    guard rootNode != destinationNode else { return true }
    var visitedList: Set<Character> = visitedList
    guard !visitedList.contains(rootNode) else { return false }
    visitedList.insert(rootNode)
    for nextNode in graph[rootNode, default: []].filter({ !visitedList.contains($0) }) {
        if makeDepthFirstSearchRecursive(for: graph, from: nextNode, to: destinationNode, with: visitedList) {
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
    var visitedList: Set<Character> = []
    while !queue.isEmpty {
        let topNode: Character = queue.removeLast()
        guard topNode != destinationNode else { return true }
        guard !visitedList.contains(topNode) else { continue }
        visitedList.insert(topNode)
        graph[topNode]?
            .filter { !visitedList.contains($0) }
            .forEach { queue.insert($0, at: 0) }
    }

    return false
}

print("Graph:")
let graph: [Character: [Character]] = makeGraph(from: edges)
graph.map { print("\($0.key): \($0.value)") }
print("\nDepthFirstSearch_Iterative:")
print(makeDepthFirstSearchIterative(for: graph, from: rootNode, to: destinationNode))
print("\nDepthFirstSearch_Recursive:")
print(makeDepthFirstSearchRecursive(for: graph, from: rootNode, to: destinationNode))
print("\nBreadthFirstSearchIterative:")
print(makeBreadthFirstSearch(for: graph, from: rootNode, to: destinationNode))
