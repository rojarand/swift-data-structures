//
//  LinkedList.swift
//  
//
//  Created by Robert Andrzejczyk on 21/03/2023.
//

public class SinglyLinkedList<T> {
    
    public var head: Node<T>?
    
    public func append(data: T) {
        let newNode = Node(data: data)
        if let last {
            last.next = newNode
        } else {
            head = newNode
        }
    }
    
    public var count: UInt {
        if var runner = head {
            var count: UInt = 1
            while let next = runner.next {
                count += 1
                runner = next
            }
            return count
        } else {
            return 0
        }
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

public class Node<T> {
    public let data: T
    public var next: Node<T>?
    
    init(data: T, next: Node<T>? = nil) {
        self.data = data
        self.next = next
    }
}
