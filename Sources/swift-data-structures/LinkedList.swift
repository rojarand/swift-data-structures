//
//  LinkedList.swift
//  
//
//  Created by Robert Andrzejczyk on 21/03/2023.
//

class Node<T> {
    let data: T
    var next: Node<T>?
    
    init(data: T, next: Node<T>? = nil) {
        self.data = data
        self.next = next
    }
}

public class LinkedList<T> {
    
    var head: Node<T>?
    
    init(_ elements : T...) {
        if let first = elements.first {
            var last = Node(data: first)
            head = last
            elements.dropFirst(1).forEach { element in
                let next = Node(data: element)
                last.next = next
                last = next
            }
        }
    }
    
    internal init(head: Node<T>?) {
        self.head = head
    }
    
    public func append(data: T) {
        let next = Node(data: data)
        if let last {
            last.next = next
        } else {
            head = next
        }
    }
    
    public var count: UInt {
        var runner = head
        var count: UInt = 0
        while let node = runner {
            count += 1
            runner = node.next
        }
        return count
    }
    
    private var last: Node<T>? {
        if var runner = head {
            while let next = runner.next {
                runner = next
            }
            return runner
        }
        return nil
    }
}


@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
extension LinkedList: Sequence {
    
    public func makeIterator() -> some IteratorProtocol<T> {
        LinkedListIterator(head: head)
    }
}

public struct LinkedListIterator<T>: IteratorProtocol {
    
    private var currentNode: Node<T>?
    
    init(head: Node<T>? = nil) {
        self.currentNode = head
    }
    
    public mutating func next() -> T? {
        if let node = currentNode {
            currentNode = node.next
            return node.data
        } else {
            return nil
        }
    }
}

extension LinkedList where T:Comparable {
    
    func removeDuplicates() {
        var runner1 = head
        while let r1 = runner1 {
            var runner2: Node<T>? = r1
            while let r2 = runner2, let next = r2.next {
                if r1.data == next.data {
                    r2.next = next.next
                } else {
                    runner2 = r2.next
                }
            }
            runner1 = r1.next
        }
    }
}

extension LinkedList where T:Hashable {
    
    func removeDuplicates2() {
        var elements: Set<T> = []
        if let head {
            elements.insert(head.data)
        }
        var runner = head
        while let r = runner {
            if let next = r.next {
                if elements.contains(next.data) {
                    r.next = next.next
                } else {
                    elements.insert(next.data)
                    runner = r.next
                }
            } else {
                runner = nil
            }
        }
    }
}

extension LinkedList {
    
    func remove(kthFromEnd k: UInt) {
        let count = count
        guard count > 0, k < count else { return }
        let n = count - k - 1
        if n == 0 {
            head = head?.next
        } else {
            var index = 0
            var runner = head
            while let r = runner, let next = r.next {
                if index+1 == n {
                    r.next = next.next
                    return
                } else {
                    index += 1
                    runner = next
                }
            }
        }
    }
    
    func remove2(kthFromEnd k: UInt) {
        var nodes: [Node<T>] = []
        var runner = head
        while let current = runner {
            nodes.append(current)
            runner = current.next
        }
        let index: Int = nodes.count - Int(k) - 1
        guard index >= 0 else { return }
        if index == 0 {
            head = head?.next
        } else {
            let prev = nodes[index-1]
            prev.next = prev.next?.next
        }
    }
}

extension LinkedList {
    
    /// Removes an element placed in the middle of the list.
    ///
    /// If number of elements in the list is not greater than 2 then nothing is removed.
    /// If number of elements is even then element with index = (count/2)-1 is the middle element.
    ///
    ///     let list = LinkedList(1, 2, 3, 4)
    ///     list.removeMiddle()
    ///     // Contains: 1, 3, 4
    ///     list.removeMiddle()
    ///     // Contains: 1, 4
    ///     list.removeMiddle()
    ///     // Contains: 1, 4
    ///
    /// - Complexity: time - O(n) where n is the number of elements, space - O(1)
    ///
    func removeMiddle() {
        let count = count
        guard count > 2 else { return }
        let indexToRemove = ((count%2 == 0) ? count-1 : count) / 2
        
        var runner = head
        var index = 0
        while let r = runner {
            index += 1
            if index == indexToRemove {
                r.next = r.next?.next
                return
            } else {
                runner = r.next
            }
        }
    }
}

extension LinkedList where T: Comparable {
    
    func partition(around data: T) -> LinkedList<T> {
        var head1: Node<T>?
        var tail1: Node<T>?
        var head2: Node<T>?
        var tail2: Node<T>?
        
        var runner = head
        while let current = runner {
            runner = current.next
            current.next = nil
            if current.data < data {
                if head1 == nil {
                    head1 = current
                    tail1 = head1
                } else {
                    tail1?.next = current
                    tail1 = tail1?.next
                }
            } else {
                if head2 == nil {
                    head2 = current
                    tail2 = head2
                } else {
                    tail2?.next = current
                    tail2 = tail2?.next
                }
            }
        }
        head = head1
        return LinkedList(head: head2)
    }
}
