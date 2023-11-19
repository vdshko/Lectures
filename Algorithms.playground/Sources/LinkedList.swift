import Foundation

public enum LinkedList {

    public static var charactersList: Node<Character> {
        return makeList(for: ["A", "B", "C", "D", "E", "F"])
    }

    public static var charactersList2: Node<Character> {
        return makeList(for: ["1", "2", "3"])
    }

    public static var numbersList: Node<Int> {
        return makeList(for: [2, 8, 3, -1, 7])
    }

    private static func makeList<T>(for array: [T]) -> Node<T> {
        let array: [Node<T>] = array.map(Node<T>.init)
        for index in (1..<array.count).reversed() {
            array[index - 1].next = array[index]
        }

        return array[0]
    }
}
