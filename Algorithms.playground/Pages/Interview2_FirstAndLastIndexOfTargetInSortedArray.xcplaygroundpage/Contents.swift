import Foundation

// O(n)
func firstAndLastIndexOfTargetInSortedArray(_ arr: [Int], target: Int) -> [Int] {
    guard !arr.isEmpty,
          let firstIndex: Int = arr.firstIndex(where: { $0 == target })
    else { return [-1, -1] }
    var result = [firstIndex, firstIndex]
    for value in arr.suffix(arr.count - 1 - firstIndex) {
        guard value == target else { return result }
        result[1] = result[1] + 1
    }
    return result
}

// O(log n)
func firstAndLastIndexOfTargetInSortedArrayBinarySearch(_ arr: [Int], target: Int) -> [Int] {
    guard !arr.isEmpty else { return [-1, -1] }
    var result: [Int] = [-1, -1]
    var leftPointer: Int = 0
    var rightPointer: Int = arr.count - 1
    var midPointer: Int = (leftPointer + rightPointer) / 2
    binarySearchMainPart()

    func binarySearchMainPart() {
        while leftPointer <= rightPointer {
            if arr[midPointer] != target {
                if arr[midPointer] > target {
                    rightPointer = midPointer - 1
                } else {
                    leftPointer = midPointer + 1
                }
                midPointer = (leftPointer + rightPointer) / 2
                continue
            }

            result = [midPointer, midPointer]

            let tempMidPointer: Int = midPointer
            let tempRightPointer: Int = rightPointer
            rightPointer = tempMidPointer - 1
            binarySearchLeftSide()

            leftPointer = tempMidPointer + 1
            rightPointer = tempRightPointer
            binarySearchRightSide()

            break
        }
    }

    func binarySearchLeftSide() {
        midPointer = (leftPointer + rightPointer) / 2
        while leftPointer <= rightPointer {
            if arr[midPointer] == target {
                result[0] = midPointer
                rightPointer = midPointer - 1
            } else {
                leftPointer = midPointer + 1
            }
            midPointer = (leftPointer + rightPointer) / 2
        }
    }

    func binarySearchRightSide() {
        midPointer = (leftPointer + rightPointer) / 2
        while leftPointer <= rightPointer {
            if arr[midPointer] == target {
                result[1] = midPointer
                leftPointer = midPointer + 1
            } else {
                rightPointer = midPointer - 1
            }
            midPointer = (leftPointer + rightPointer) / 2
        }
    }

    return result
}

print(firstAndLastIndexOfTargetInSortedArray([], target: 1))
print(firstAndLastIndexOfTargetInSortedArray([1,2,3], target: 2))
print(firstAndLastIndexOfTargetInSortedArray([1,2,2,2,3], target: 2))
print(firstAndLastIndexOfTargetInSortedArray([2,2,2,2,2], target: 2))
print(firstAndLastIndexOfTargetInSortedArray([1,2,2,2,3], target: 4))

print("\nBinary Search:")
print(firstAndLastIndexOfTargetInSortedArrayBinarySearch([], target: 1))
print(firstAndLastIndexOfTargetInSortedArrayBinarySearch([1,2,3], target: 2))
print(firstAndLastIndexOfTargetInSortedArrayBinarySearch([1,2,2,2,3], target: 2))
print(firstAndLastIndexOfTargetInSortedArrayBinarySearch([2,2,2,2,2], target: 2))
print(firstAndLastIndexOfTargetInSortedArrayBinarySearch([1,2,2,2,3], target: 4))
