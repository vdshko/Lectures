import Foundation

// O(n * 2^n)
func generateParentheses(combinationCount: Int) -> [String] {
    guard combinationCount > 0 else { return [] }
    var combinations: [String] = []
    
    func backtracking(n: Int, difference: Int, combination: String) {
        guard difference >= 0, difference <= n else { return }
        if n == 0, difference == 0 {
            combinations.append(combination)
            return
        }
        backtracking(n: n - 1, difference: difference + 1, combination: combination + "(")
        backtracking(n: n - 1, difference: difference - 1, combination: combination + ")")
    }

    backtracking(n: combinationCount * 2, difference: 0, combination: "")

    return combinations
}

print(generateParentheses(combinationCount: 3))
print(generateParentheses(combinationCount: 4))
print(generateParentheses(combinationCount: 5))
