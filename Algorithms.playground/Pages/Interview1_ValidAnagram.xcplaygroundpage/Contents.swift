import Foundation

func isValidAnagram(_ s1: String, _ s2: String) -> Bool {
    guard s1.count == s2.count else { return false }
    var hashMap: [Character: Int] = s1.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }
    for character in s2 {
        guard let value: Int = hashMap[character], value > 0 else { return false }
        hashMap[character, default: 0] -= 1
    }
    return true
}

print("isValidAnagram(\"\", \"\"):", isValidAnagram("", ""))
print("isValidAnagram(\"danger\", \"garden\"):", isValidAnagram("danger", "garden"))
print("isValidAnagram(\"danger\", \"gar\"):", isValidAnagram("danger", "gar"))
print("isValidAnagram(\"danger\", \"ggarden\"):", isValidAnagram("danger", "ggarden"))
print("isValidAnagram(\"danger1\", \"garden2\"):", isValidAnagram("danger1", "garden2"))
