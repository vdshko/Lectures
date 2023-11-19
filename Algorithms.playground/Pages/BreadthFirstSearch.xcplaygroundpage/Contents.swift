import Foundation

let graph: [Character: [Character]] = [
    "a": ["b", "c"],
    "b": ["d"],
    "c": ["e"],
    "d": ["f"],
    "e": [],
    "f": [],
]

func makeBreadthFirstSearch(for graph: [Character: [Character]], node: Character) {
    var queue: [Character] = [node]
    while !queue.isEmpty {
        let topNode: Character = queue.removeLast()
        print(topNode)
        graph[topNode]?.forEach { queue.insert($0, at: 0) }
    }
}

print("Iterative:")
makeBreadthFirstSearch(for: graph, node: "a")
print("\nRecursive: Impossible")
