import Foundation

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

////////////////////////////////////////////////

func radixSort(numbers: [Int]) -> [Int] {
    var inArray = [[Int]]()
    for _ in 0 ... 9 {
        inArray.append([Int]())
    }
    
    var outArray = [[Int]]()

    numbers.forEach { number in
        let index = number % 10
        inArray[index].append(number)
    }

    var digit = 2
    var finishCondition = true
    
    while finishCondition {
        
        outArray = [[Int]]()
        for _ in 0 ... 9 {
            outArray.append([])
        }
        
        finishCondition = false
        
        for listIndex in 0 ... 9 {
            for number in inArray[listIndex] {
                let index = (number % 10^^digit) / 10^^(digit - 1)
                
                if index > 0 {
                    finishCondition = true
                }

                outArray[index].append(number)
            }
        }

        inArray = outArray
        digit += 1
    }
    
    var output = [Int]()
    for listIndex in 0 ... 9 {
        for number in inArray[listIndex] {
            output.append(number)
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



