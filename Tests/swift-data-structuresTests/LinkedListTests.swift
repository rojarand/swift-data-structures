//
//  LinkedListTests.swift
//  
//
//  Created by Robert Andrzejczyk on 21/03/2023.
//

import XCTest

@testable import swift_data_structures

extension LinkedList where T:Hashable {
    
    func deDuplicate() -> Self {
        removeDuplicates()
        return self
    }
    
    func deDuplicate2() -> Self {
        removeDuplicates2()
        return self
    }
}

final class LinkedListTests: XCTestCase {

    func test_appends_to_singly_linked_list() {
        
        let list = LinkedList<Int>()
        
        XCTAssertEqual(list.count, 0)
        
        list.append(data: 2)
        list.append(data: 4)
        list.append(data: 6)
        
        XCTAssertEqual(list.count, 3)
    }
    
    func test_list_has_expected_elements() {
        
        let list = LinkedList(2, 4, 2, 3)
        XCTAssertEqual(list.map{ $0 }, [2, 4, 2, 3])
    }
    
    func test_remove_duplicates_from_singly_linked_list() {
        XCTAssertEqual(LinkedList(2, 4, 2, 6, 6, 6, 7).deDuplicate().map { $0 }, [2, 4, 6, 7])
        XCTAssertEqual(LinkedList(1, 2, 2, 2, 6).deDuplicate().map { $0 }, [1, 2, 6])
        XCTAssertEqual(LinkedList(1).deDuplicate().map { $0 }, [1])
        XCTAssertEqual(LinkedList<Int>().deDuplicate().map { $0 }, [])
    }
    
    func test_remove_duplicates_from_singly_linked_list2() {
        XCTAssertEqual(LinkedList(2, 4, 2, 6, 6, 6, 7).deDuplicate2().map { $0 }, [2, 4, 6, 7])
        XCTAssertEqual(LinkedList(1, 2, 2, 2, 6).deDuplicate2().map { $0 }, [1, 2, 6])
        XCTAssertEqual(LinkedList(1).deDuplicate2().map { $0 }, [1])
        XCTAssertEqual(LinkedList<Int>().deDuplicate2().map { $0 }, [])
    }
}
