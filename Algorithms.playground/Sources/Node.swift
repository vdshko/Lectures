import Foundation

public final class Node<T: Any> {

    public var value: T
    
    /// Next node for LinkedList
    public var next: Node?

    /// Left node for the Binary Tree
    public var left: Node?
    /// Right node for the Binary Tree
    public var right: Node? {
        get { return next }
        set { next = newValue }
    }

    public init(value: T) {
        self.value = value
    }
}
