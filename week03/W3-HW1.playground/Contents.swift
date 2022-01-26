import UIKit

//MARK: HW1, Prime Number Extension

extension Int{
    func isPrime() -> Bool{
        var isPrime = true
        let sqrtOfNum = sqrt(Double(self))
        for i in 2...Int(sqrtOfNum){
            if self % i == 0{
                isPrime = false
            }
        }
        return isPrime
    }
}

13.isPrime()
15.isPrime()



//MARK: HW2, İki parametreli ve FARKLI tipli bir generic örneği yapınız (T,U)

func toString<T: Numeric, U>(number: T, word: U) -> String{
    let myString = "\(word) \(number + 1)"
    return myString
}
var myString: String = toString(number: 5, word: "deneme")



//MARK: HW3 EULER-7: What is the 10 001st prime number?

var counter = 1
var primeNumber = 2
while counter <= 10001{
    if primeNumber == 3 || primeNumber == 2{
        counter += 1
        primeNumber += 1
    }else if primeNumber.isPrime() {
        counter += 1
        primeNumber += 1
    } else {
        primeNumber += 1
    }
    
}
primeNumber -= 1
print("10001st prime number = \(primeNumber)")



