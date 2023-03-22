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
    
    public func append(data: T) {
        let newNode = Node(data: data)
        if let last {
            last.next = newNode
        } else {
            head = newNode
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
    
    public func makeIterator() -> LinkedListIterator<T> {
        LinkedListIterator(head: head)
    }
    
    /*
    public func makeIterator() -> some IteratorProtocol {
        LinkedListIterator(head: head)
    }
     */
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

extension LinkedList where T:Hashable {
    
    func removeDuplicates() {
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
    
    func removeDuplicates2() {
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
