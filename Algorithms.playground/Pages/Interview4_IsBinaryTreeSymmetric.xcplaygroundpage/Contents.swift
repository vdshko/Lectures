import Foundation

// O(n)
func IsBinaryTreeSymmetric(root: Node<Int>) -> Bool {
    func IsBinaryTreeSymmetricInside(root1: Node<Int>?, root2: Node<Int>?) -> Bool {
        if root1 != nil, root2 == nil
            || root1 == nil, root2 != nil { return false }
        guard let root1, let root2 else { return true }
        guard root1.value == root2.value else { return false }
        return IsBinaryTreeSymmetricInside(root1: root1.left, root2: root2.right) && IsBinaryTreeSymmetricInside(root1: root1.right, root2: root2.left)
    }

    return IsBinaryTreeSymmetricInside(root1: root.left, root2: root.right)
}

print(IsBinaryTreeSymmetric(root: BinaryTree.numbersTree))
print(IsBinaryTreeSymmetric(root: BinaryTree.numbersTreeSymmetric))
