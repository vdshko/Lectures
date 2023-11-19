import Foundation

public enum BinaryTree {

    public static var charactersTree: Node<Character> {
        return makeTree(for: ["A", "B", "C", "D", "E", "F"])
    }

    public static var charactersTree2: Node<Character> {
        return makeTree(for: ["1", "2", "3"])
    }

    public static var numbersTree: Node<Int> {
        return makeTree(for: [5, 11, 3, 4, 2, 1])
    }

    public static var numbersTree2: Node<Int> {
        return makeTree(for: [5, 12, 4, 5, 3, 2])
    }

    private static func makeTree<T>(for array: [T]) -> Node<T> {
        let array: [Node<T>] = array.map(Node<T>.init)
        var tuple: (index: Int, isLeft: Bool) = (0, true)
        for index in 1..<array.count {
            if tuple.isLeft {
                array[tuple.index].left = array[index]
            } else {
                array[tuple.index].right = array[index]
            }

            tuple.isLeft.toggle()
            if tuple.isLeft {
                tuple.index += 1
            }
        }

        return array[0]
    }
}
