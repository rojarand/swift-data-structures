//
//  LinkedListTests.swift
//  
//
//  Created by Robert Andrzejczyk on 21/03/2023.
//

import XCTest

@testable import swift_data_structures


extension LinkedList {
    
    func xcRemove(kthFromEnd k: UInt) -> Self {
        remove(kthFromEnd: k)
        return self
    }
    
    func xcRemove2(kthFromEnd k: UInt) -> Self {
        remove2(kthFromEnd: k)
        return self
    }
    
    func xcRemoveMiddle() -> Self {
        removeMiddle()
        return self
    }
}

extension LinkedList where T:Comparable {
    
    func xcRemoveDuplicates() -> Self {
        removeDuplicates()
        return self
    }
}

extension LinkedList where T:Hashable {
    
    func xcRemoveDuplicates2() -> Self {
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
        XCTAssertEqual(LinkedList(2, 4, 2, 6, 6, 6, 7).xcRemoveDuplicates().map { $0 }, [2, 4, 6, 7])
        XCTAssertEqual(LinkedList(1, 2, 2, 2, 6).xcRemoveDuplicates().map { $0 }, [1, 2, 6])
        XCTAssertEqual(LinkedList(1).xcRemoveDuplicates().map { $0 }, [1])
        XCTAssertEqual(LinkedList<Int>().xcRemoveDuplicates().map { $0 }, [])
    }
    
    func test_remove_duplicates_from_singly_linked_list2() {
        XCTAssertEqual(LinkedList(2, 4, 2, 6, 6, 6, 7).xcRemoveDuplicates2().map { $0 }, [2, 4, 6, 7])
        XCTAssertEqual(LinkedList(1, 2, 2, 2, 6).xcRemoveDuplicates2().map { $0 }, [1, 2, 6])
        XCTAssertEqual(LinkedList(1).xcRemoveDuplicates2().map { $0 }, [1])
        XCTAssertEqual(LinkedList<Int>().xcRemoveDuplicates2().map { $0 }, [])
    }
    
    
    func test_removes_kth_element_from_end() {
        XCTAssertEqual(LinkedList(1).xcRemove(kthFromEnd: 0).map { $0 }, [])
        XCTAssertEqual(LinkedList(1, 2).xcRemove(kthFromEnd: 1).map { $0 }, [2])
        XCTAssertEqual(LinkedList(1, 2, 3).xcRemove(kthFromEnd: 1).map { $0 }, [1, 3])
        XCTAssertEqual(LinkedList(1, 2, 3).xcRemove(kthFromEnd: 2).map { $0 }, [2, 3])
    }
    
    func test_removes_kth_element_from_end2() {
        XCTAssertEqual(LinkedList(1).xcRemove2(kthFromEnd: 0).map { $0 }, [])
        XCTAssertEqual(LinkedList(1, 2).xcRemove2(kthFromEnd: 1).map { $0 }, [2])
        XCTAssertEqual(LinkedList(1, 2, 3).xcRemove2(kthFromEnd: 1).map { $0 }, [1, 3])
        XCTAssertEqual(LinkedList(1, 2, 3).xcRemove2(kthFromEnd: 2).map { $0 }, [2, 3])
    }
    
    func test_removes_middle_element() {
        XCTAssertEqual(LinkedList<Int>().xcRemoveMiddle().map { $0 }, [])
        XCTAssertEqual(LinkedList(1).xcRemoveMiddle().map { $0 }, [1])
        XCTAssertEqual(LinkedList(1,2).xcRemoveMiddle().map { $0 }, [1,2])
        XCTAssertEqual(LinkedList(1,2,3).xcRemoveMiddle().map { $0 }, [1,3])
        XCTAssertEqual(LinkedList(1,2,3,4).xcRemoveMiddle().map { $0 }, [1,3,4])
    }
    
    func test_partitions_linked_list_with_many_elements_around_given_value() {
        let linkedList = LinkedList(3,5,8,5,10,2,1)
        let higherPart = linkedList.partition(around: 5)
        XCTAssertEqual(linkedList.map { $0 }, [3,2,1])
        XCTAssertEqual(higherPart.map { $0 }, [5,8,5,10])
    }
    
    func test_partitions_linked_list_with_two_elements_around_high_value() {
        let linkedList = LinkedList(3,5)
        let higherPart = linkedList.partition(around: 6)
        XCTAssertEqual(linkedList.map { $0 }, [3,5])
        XCTAssertEqual(higherPart.map { $0 }, [])
    }
    
    func test_partitions_linked_list_with_two_elements_around_low_value() {
        let linkedList = LinkedList(3,5)
        let higherPart = linkedList.partition(around: 0)
        XCTAssertEqual(linkedList.map { $0 }, [])
        XCTAssertEqual(higherPart.map { $0 }, [3,5])
    }
    
    func test_partitions_linked_list_with_one_element_around_low_value() {
        let linkedList = LinkedList(3)
        let otherPart = linkedList.partition(around: 0)
        XCTAssertEqual(linkedList.map { $0 }, [])
        XCTAssertEqual(otherPart.map { $0 }, [3])
    }
}
