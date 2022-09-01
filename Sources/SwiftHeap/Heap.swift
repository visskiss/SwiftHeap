
import Foundation

public struct Heap<T:Equatable> {
    
    /**
        Generalized Heap Struct for swift.
     */

    private var _heap: [T]
    private let compare: (T, T) -> Bool

    /**
     Init Function. Heaps are initialized with a comparator function for ascending or descending heaps (or you could get creative)
     
     '''
     var heap = Heap(<)
     '''
     will create a new ascending order heap while
     
     '''
     var heap = Heap(>)
     '''
     would create a descending order heap
     
     - Parameter _: The comparison function to use for the heap ('<' for ascending, '>' for descending)
     */
    public init(_ compare: @escaping (T, T) -> Bool) {
        _heap = []
        self.compare = compare
    }
    
    /**
     Push a new element on to the heap
     
     - Parameter _: the new element to push
     */
    mutating public func push(_ newElement: T) {
        _heap.append(newElement)
        siftUp(_heap.endIndex - 1)
    }
    
    /**
     Pop the first element from  the heap
     
     - Returns : the first element in the heap
     */
    mutating public func pop() -> T? {
        if _heap.count == 0 {
            return nil
        }
        if _heap.count == 1 {
            return _heap.removeLast()
        }
        _heap.swapAt(0, _heap.endIndex - 1)
        let pop = _heap.removeLast()
        siftDown(0)
        return pop
    }
    
    public func peak() -> T? {
        if _heap.count == 0 {
            return nil
        }
        return _heap[0]
    }

    mutating private func siftDown(_ index: Int) {
        var current = index
        var smallest = current
        while current < heap.count {
            let left = current * 2 + 1
            let right = current * 2 + 2
            if left < _heap.count && compare(_heap[left], _heap[smallest]) {
                smallest = left
            }
            if right < _heap.count && compare(_heap[right], _heap[smallest]) {
                smallest = right
            }
            if current != smallest {
                _heap.swapAt(current, smallest)
                current = smallest
            } else {
                break
            }
        }
    }

    mutating private func siftUp(_ index: Int)  {
        var current = index
        while current > 0 {
            let parent = (current - 1) >> 1
            if compare(_heap[current], _heap[parent]) {
                _heap.swapAt(current, parent)
                current = parent
            } else {
                break
            }
        }
    }
}

extension Heap {
    public var count: Int {
        return _heap.count
    }

    public var isEmpty: Bool {
        return _heap.isEmpty
    }
    
    /**
     Update the priorit of the  element on  the heap. Used for classes/structs where priority can be updated.
     
     - Returns : the updated element
     */
    mutating public func update(_ element: T) -> T?  {
        for (index, item) in _heap.enumerated() {
            if item == element {
                _heap[index] = element
                siftDown(index)
                siftUp(index)
                return item
            }
        }
        return nil
    }

    
    /**
     Remove an  element on  the heap.
     
     - Parameter _ : the  element to be removed
     */
    mutating public func remove(_ element: T) -> T?  {
        for (index, item) in _heap.enumerated() {
            if item == element {
                _heap.swapAt(index, _heap.endIndex - 1)
                _heap.removeLast()
                siftDown(index)
                return item
            }
        }
        return nil
    }

    public var heap: [T] {
        return _heap
    }

    mutating public func removeAll() {
        _heap.removeAll()
    }
}

extension Heap: IteratorProtocol {
    public typealias Element = T
    mutating public func next() -> Element? {
        return pop()
    }
}

extension Heap: Sequence {
    public typealias Generator = Self
    public func generate() -> Generator {
        return self
    }
}

