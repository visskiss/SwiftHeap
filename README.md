# SwiftHeap

When included as a framework, import it as any other framework:

```swift
import Heap
```

The heap is defined as a generic and initialized with a comparison 
callback, like  `Heap<T>((T, T) -> Bool)`. For example, it can 
operate on characters like this:

```swift
var characters = Heap<Character>(<)
characters.push("C")
characters.push("B")
characters.push("A")

println("Characters:")
for p in characters {
    println(" * \(p)")
}
println()
```

This would print:

     * A
     * B
     * C

A more real-world use-case would operate on structs or classes, like this:

```swift
struct Node {
    let priority: Int
}

var nodes = Heap<Node>({ $0.priority < $1.priority })
nodes.push(Node(priority: 4))
nodes.push(Node(priority: 5))
nodes.push(Node(priority: 3))
nodes.push(Node(priority: 1))

println("Nodes:")
for node in nodes {
    println(" * Node(priority: \(node.priority))")
}
println()
```

This would print:

    Nodes:
    * Node(priority: 1)
    * Node(priority: 3)
    * Node(priority: 4)
    * Node(priority: 5)

## Removing items

```swift
var ints = Heap<Int>(<)
ints.push(3)
ints.remove(3)  // Returns 3
ints.remove(3)  // Returns nil
```

## Peaking

```swift
ints.push(5)
ints.push(4)
ints.peak  // Returns 4
```

## Inspecting the heap

```swift
ints.push(5)
ints.push(4)
ints.heap  // Returns [4, 5]
```

## Credits

This library was written by Daniel Kanaan based on an original version by Bouke Haarsma.
