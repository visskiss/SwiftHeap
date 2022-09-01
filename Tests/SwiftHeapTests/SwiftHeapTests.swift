import XCTest
@testable import SwiftHeap

final class HeapTests: XCTestCase {
 
    func testSimple() {
        var heap = Heap<Int>(<)
        heap.push(10)
        heap.push(2)
        heap.push(3)
        heap.push(1)
        heap.push(2)
        heap.push(3)
        heap.push(9)
        heap.push(5)

        XCTAssertEqual(1, heap.next()!)
        XCTAssertEqual(2, heap.next()!)
        XCTAssertEqual(2, heap.next()!)
        XCTAssertEqual(3, heap.next()!)
        XCTAssertEqual(3, heap.next()!)
        XCTAssertEqual(5, heap.next()!)
        XCTAssertEqual(9, heap.next()!)
        XCTAssertEqual(10, heap.next()!)
        XCTAssertTrue(heap.next() == nil)

        heap.push(11)
       // XCTAssertEqual(11, heap.remove(11) ?? -1)
      //  XCTAssertNil(heap.remove(11))
    }

    func testRandom() {
        var heap = Heap<UInt32>(<)
        var compArray = [UInt32]()
        for _ in 0..<10000 {
            let new = arc4random()
            heap.push(new)
            compArray.append(new)
        }
        compArray.sort()
        for val in compArray {
            XCTAssertTrue(val == heap.pop())
        }
        var current: UInt32 = 0
        for item in heap {
            XCTAssertGreaterThanOrEqual(item, current)
            current = item
        }
    }

    func testUpdate() {
        var heap = Heap<Item>({ $0.priority < $1.priority })
        let items = [
            Item(priority: 1),
            Item(priority: 2),
            Item(priority: 3),
            Item(priority: 4),
        ]
        _ = items.map { heap.push($0) }
        items[3].priority = 0
        XCTAssertTrue(heap.update(items[3]) == items[3])
        XCTAssertEqual(Array(heap), [items[3], items[0], items[1], items[2]])

        heap.removeAll()
        _ = items.map { heap.push($0) }
        items[3].priority = 5
        XCTAssertTrue(heap.update(items[3]) == items[3])
        XCTAssertEqual(Array(heap), [items[0], items[1], items[2], items[3]])
        items[0].priority = 6
        XCTAssertTrue(heap.update(items[0]) == items[0])
        XCTAssertEqual(Array(heap), [items[1], items[2], items[3],items[0] ])
    }
 
    func testRemoveClasses() {
        var heap = Heap<Item>({ $0.priority < $1.priority })
        let items = [
            Item(priority: 1),
            Item(priority: 2),
            Item(priority: 3),
            Item(priority: 4),
        ]
        _ = items.map { heap.push($0) }
        XCTAssertTrue(heap.remove(items[3]) == items[3])
        XCTAssertEqual(Array(heap), [items[0], items[1], items[2]])
        
        heap.removeAll()
        _ = items.map { heap.push($0) }
        XCTAssertTrue(heap.remove(items[0]) == items[0])
        XCTAssertEqual(Array(heap), [items[1], items[2], items[3]])
        heap.push(items[0])
        XCTAssertEqual(Array(heap), [items[0], items[1], items[2],items[3]])
    }
    
    func testRemove() {
        var heap = Heap<Int>(<)
        _ = (1...7).map { heap.push($0) }
        XCTAssertTrue(heap.remove(3) == 3)
        XCTAssertEqual(Array(heap), [1,2,4,5,6,7])
    }

    func testPushPerformance() {
        measureMetrics(Self.defaultPerformanceMetrics, automaticallyStartMeasuring:false) {
            var heap = Heap<UInt32>(<)
            self.startMeasuring()
            for _ in 0..<10000 {
                heap.push(arc4random())
            }
            self.stopMeasuring()
        }
    }

    func testPopPerformance() {
        measureMetrics(Self.defaultPerformanceMetrics, automaticallyStartMeasuring:false) {
            var heap = Heap<UInt32>(<)
            for _ in 0..<1000 {
                heap.push(arc4random())
            }

            self.startMeasuring()
            for _ in heap {}
            self.stopMeasuring()
        }
    }
}

private class Item {
    var priority: Int
    init(priority: Int) {
        self.priority = priority
    }
}

extension Item: Equatable {
}

private func == (lhs: Item, rhs: Item) -> Bool {
    return lhs === rhs
}
