import Foundation

// O(n)
func gasStation(gas: [Int], cost: [Int]) -> Int {
    var remaining: Int = 0
    var preRemaining: Int = 0
    var candidate: Int = 0
    for index in gas.indices {
        remaining += gas[index] - cost[index]
        if remaining < 0 {
            candidate = index + 1
            preRemaining += remaining
            remaining = 0
        }
    }
    return candidate == gas.count || remaining + preRemaining < 0 ? -1 : candidate
}

print(gasStation(gas: [1, 5, 3, 3, 5, 3, 1, 3, 4, 5], cost: [5, 2, 2, 8, 2, 4, 2, 5, 1, 2]))
