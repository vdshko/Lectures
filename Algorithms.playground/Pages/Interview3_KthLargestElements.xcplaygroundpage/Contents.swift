import Foundation

// O(n*k)
func kLargestElements(_ arr: [Int], k: Int) -> [Int] {
    guard arr.count >= k else { return [] }
    var result: [Int] = [Int](repeating: 0, count: k)
    arr.forEach {
        var value: Int = $0
        for index in result.indices {
            if value > result[index] {
                (value, result[index]) = (result[index], value)
            }
        }
    }

    return result
}

// O(k + n*log n)
func kLargestElements2(_ arr: [Int], k: Int) -> [Int] {
    return arr.count >= k ? arr.sorted().suffix(k) : []
}


print(kLargestElements([4, 2, 9, 7, 5, 6, 7, 1, 3], k: 4))
print(kLargestElements([4, 2, 9, 7, 5, 6, 7, 1, 3], k: 20))
print(kLargestElements([1, 3, 2], k: 3))
print("\n2:")
print(kLargestElements2([4, 2, 9, 7, 5, 6, 7, 1, 3], k: 4))
print(kLargestElements2([4, 2, 9, 7, 5, 6, 7, 1, 3], k: 20))
print(kLargestElements2([1, 3, 2], k: 3))
