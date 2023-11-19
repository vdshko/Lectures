import Foundation

let grid: [[Character]] = [
    ["W", "L", "W", "W", "W"],
    ["W", "L", "W", "W", "W"],
    ["W", "W", "W", "L", "W"],
    ["W", "W", "L", "L", "W"],
    ["L", "W", "W", "L", "L"],
    ["L", "L", "W", "W", "W"],
]

func makeDepthFirstSearchIterative(for grid: [[Character]], from rootNode: (row: Int, column: Int), with visitedList: inout Set<[Int]>) -> Int {
    var stack: [(row: Int, column: Int)] = [rootNode]
    var size: Int = 0
    while !stack.isEmpty {
        let topNode: (row: Int, column: Int) = stack.removeLast()
        guard !visitedList.contains([topNode.row, topNode.column]) else { continue }
        visitedList.insert([topNode.row, topNode.column])
        size += 1
        stack.append(contentsOf: nextNodes(in: grid, for: topNode).filter { !visitedList.contains([$0.0, $0.1]) })
    }

    return size
}

func makeDepthFirstSearchRecursive(for grid: [[Character]], from rootNode: (row: Int, column: Int), with visitedList: inout Set<[Int]>) -> Int {
    var size: Int = 0
    guard !visitedList.contains([rootNode.row, rootNode.column]) else { return 0 }
    visitedList.insert([rootNode.row, rootNode.column])
    size += 1
    return nextNodes(in: grid, for: rootNode)
        .filter { !visitedList.contains([$0.0, $0.1]) }
        .reduce(size) { return $0 + makeDepthFirstSearchRecursive(for: grid, from: $1, with: &visitedList) }
}

func makeBreadthFirstSearch(for grid: [[Character]], from rootNode: (row: Int, column: Int), with visitedList: inout Set<[Int]>) -> Int {
    var queue: [(row: Int, column: Int)] = [rootNode]
    var size: Int = 0
    while !queue.isEmpty {
        let topNode: (row: Int, column: Int) = queue.removeLast()
        guard !visitedList.contains([topNode.row, topNode.column]) else { continue }
        visitedList.insert([topNode.row, topNode.column])
        size += 1
        nextNodes(in: grid, for: topNode)
            .filter { !visitedList.contains([$0.0, $0.1]) }
            .forEach { queue.insert($0, at: 0) }
    }

    return size
}

func nextNodes(in grid: [[Character]], for rootNode: (row: Int, column: Int)) -> [(Int, Int)] {
    return [
        (rootNode.row - 1, rootNode.column), // UP (row - 1)
        (rootNode.row + 1, rootNode.column), // Down (row + 1)
        (rootNode.row, rootNode.column - 1), // Left (column - 1)
        (rootNode.row, rootNode.column + 1), // Right (column + 1)
    ].filter { $0.0 >= 0 && $0.0 < grid.count }
        .filter { $0.1 >= 0 && $0.1 < grid[rootNode.row].count }
        .filter { rc -> Bool in grid[rc.0][rc.1] == "L" }
}

func cycleThrough(_ grid: [[Character]]) {
    var visitedList: Set<[Int]> = []
    var minSize: Int = Int.max
    print("\nDepthFirstSearch_Iterative:")
    for row in grid.indices {
        for column in grid[row].indices {
            guard !visitedList.contains([row, column]) else { continue }
            if grid[row][column] == "W" {
                visitedList.insert([row, column])
                continue
            }
            minSize = min(minSize, makeDepthFirstSearchIterative(for: grid, from: (row, column), with: &visitedList))
        }
    }
    print(minSize)

    visitedList = []
    minSize = Int.max
    print("\nDepthFirstSearch_Recursive:")
    for row in grid.indices {
        for column in grid[row].indices {
            guard !visitedList.contains([row, column]) else { continue }
            if grid[row][column] == "W" {
                visitedList.insert([row, column])
                continue
            }
            minSize = min(minSize, makeDepthFirstSearchRecursive(for: grid, from: (row, column), with: &visitedList))
        }
    }
    print(minSize)

    visitedList = []
    minSize = Int.max
    print("\nBreadthFirstSearchIterative:")
    for row in grid.indices {
        for column in grid[row].indices {
            guard !visitedList.contains([row, column]) else { continue }
            if grid[row][column] == "W" {
                visitedList.insert([row, column])
                continue
            }
            minSize = min(minSize, makeBreadthFirstSearch(for: grid, from: (row, column), with: &visitedList))
        }
    }
    print(minSize)
}

cycleThrough(grid)
