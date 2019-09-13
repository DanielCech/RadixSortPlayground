import Foundation

////////////////////////////////////////////////

public class Node<T> {
  var value: T
  var next: Node<T>?
  weak var previous: Node<T>?

  init(value: T) {
    self.value = value
  }
}

public class LinkedList<T> {
  fileprivate var head: Node<T>?
  private var tail: Node<T>?

  public var isEmpty: Bool {
    return head == nil
  }

  public var first: Node<T>? {
    return head
  }

  public var last: Node<T>? {
    return tail
  }

  public func append(value: T) {
    let newNode = Node(value: value)
    if let tailNode = tail {
      newNode.previous = tailNode
      tailNode.next = newNode
    } else {
      head = newNode
    }
    tail = newNode
  }

  public func nodeAt(index: Int) -> Node<T>? {
    if index >= 0 {
      var node = head
      var i = index
      while node != nil {
        if i == 0 { return node }
        i -= 1
        node = node!.next
      }
    }
    return nil
  }

  public func removeAll() {
    head = nil
    tail = nil
  }

  public func remove(node: Node<T>) -> T {
    let prev = node.previous
    let next = node.next

    if let prev = prev {
      prev.next = next
    } else {
      head = next
    }
    next?.previous = prev

    if next == nil {
      tail = prev
    }

    node.previous = nil
    node.next = nil
    
    return node.value
  }
}

extension LinkedList: CustomStringConvertible {
  public var description: String {
    var text = "["
    var node = head

    while node != nil {
      text += "\(node!.value)"
      node = node!.next
      if node != nil { text += ", " }
    }
    return text + "]"
  }
}

////////////////////////////////////////////////

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

////////////////////////////////////////////////

func radixSort(numbers: [Int]) -> [Int] {
    var inArray = [LinkedList<Int>]()
    for _ in 0 ... 9 {
        inArray.append(LinkedList<Int>())
    }
    
    var outArray = [LinkedList<Int>]()

    numbers.forEach { number in
        let index = number % 10
        inArray[index].append(value: number)
    }

    var digit = 2
    var finishCondition = true
    
    while finishCondition {
        
        outArray = [LinkedList<Int>]()
        for _ in 0 ... 9 {
            outArray.append(LinkedList<Int>())
        }
        
        finishCondition = false
        
        for listIndex in 0 ... 9 {
        
            var node: Node<Int>? = inArray[listIndex].first
            while node != nil {
                let number = node!.value
                let index = (number % 10^^digit) / 10^^(digit - 1)
                
                if index > 0 {
                    finishCondition = true
                }

                outArray[index].append(value: number)
                node = node?.next
            }
        }

        inArray = outArray
        digit += 1
    }
    
    var output = [Int]()
    for listIndex in 0 ... 9 {
        var node: Node<Int>? = outArray[listIndex].first
        while node != nil {
            let number = node!.value
            output.append(number)
            node = node?.next
        }
    }
    
    return output
}


////////////////////////////////////////////////

var numbers = [Int]()
for _ in 1 ... 1000 {
    numbers.append(Int.random(in: 0 ... 99))
}

let sorted = radixSort(numbers: numbers)
print(sorted)



