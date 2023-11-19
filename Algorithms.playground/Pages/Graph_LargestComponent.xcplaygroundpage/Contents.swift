import Foundation

let graph: [Int: [Int]] = [
    0: [8, 1, 5],
    1: [0],
    5: [0, 8],
    8: [0, 5],
    2: [3, 4],
    3: [2, 4],
    4: [3, 2],
]

func makeDepthFirstSearchIterative(for graph: [Int: [Int]], from rootNode: Int, with visitedList: inout Set<Int>) {
    var stack: [Int] = [rootNode]
    while !stack.isEmpty {
        let topNode: Int = stack.removeLast()
        guard !visitedList.contains(topNode) else { continue }
        visitedList.insert(topNode)
        stack.append(contentsOf: graph[topNode, default: []].filter { !visitedList.contains($0) })
    }
}

func makeDepthFirstSearchRecursive(for graph: [Int: [Int]], from rootNode: Int, with visitedList: inout Set<Int>) {
    guard !visitedList.contains(rootNode) else { return }
    visitedList.insert(rootNode)
    graph[rootNode]?
        .filter { !visitedList.contains($0) }
        .forEach { makeDepthFirstSearchRecursive(for: graph, from: $0, with: &visitedList) }
}

func makeBreadthFirstSearch(for graph: [Int: [Int]], from rootNode: Int, with visitedList: inout Set<Int>) {
    var queue: [Int] = [rootNode]
    while !queue.isEmpty {
        let topNode: Int = queue.removeLast()
        guard !visitedList.contains(topNode) else { continue }
        visitedList.insert(topNode)
        graph[topNode]?
            .filter { !visitedList.contains($0) }
            .forEach { queue.insert($0, at: 0) }
    }
}

func cycleThrough(_ graph: [Int: [Int]]) {
    var visitedList: Set<Int> = []
    var counts: [Int] = []
    print("DepthFirstSearch_Iterative:")
    for node in graph.keys {
        guard !visitedList.contains(node) else { continue }
        makeDepthFirstSearchIterative(for: graph, from: node, with: &visitedList)
        counts.append(visitedList.count - counts.reduce(0, +))
    }
    print(counts.max() ?? 0)

    print("\nDepthFirstSearch_Recursive:")
    visitedList = []
    counts = []
    for node in graph.keys {
        guard !visitedList.contains(node) else { continue }
        makeDepthFirstSearchRecursive(for: graph, from: node, with: &visitedList)
        counts.append(visitedList.count - counts.reduce(0, +))
    }
    print(counts.max() ?? 0)

    print("\nBreadthFirstSearchIterative:")
    visitedList = []
    counts = []
    for node in graph.keys {
        guard !visitedList.contains(node) else { continue }
        makeBreadthFirstSearch(for: graph, from: node, with: &visitedList)
        counts.append(visitedList.count - counts.reduce(0, +))
    }
    print(counts.max() ?? 0)
}

cycleThrough(graph)
