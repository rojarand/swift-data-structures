//
//  LinkedListTests.swift
//  
//
//  Created by Robert Andrzejczyk on 21/03/2023.
//

import XCTest

@testable import swift_data_structures

final class LinkedListTests: XCTestCase {

    func test_appends_to_singly_linked_list() throws {
        
        let list = SinglyLinkedList<Int>()
        
        XCTAssertEqual(list.count, 0)
        
        list.append(data: 2)
        list.append(data: 4)
        list.append(data: 6)
        
        XCTAssertEqual(list.count, 3)
    }
}
