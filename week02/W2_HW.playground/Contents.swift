import Foundation

//Q1: project euler den 4,5,6. sorular swift kullanılarak çözülmeli

//Q2: Soru1: Verilen bir kelimenin veya sayının terstende aynı okunup okunmadığını kontrol eden bir swift programı     yazınız. Palindrome
      //Örnek : Ey Edip adanada pide ye, 9009

//Q3: Bir sayının asal sayı olup olmadığını anlamak için nasıl bir kod yazarsınız? (Karekök kullanın)

//Q4: Bir sınıfta en az bir yazılım dili bilenlerin sayısı 24, sadece swift bilenler 12, sadece kotlin bilenler 8      olduğuna göre her iki dili bilen kaç kişi vardır. (Sınıfta 24 kişi var, sadece swift ve kotlin bilinmekte.)

//Q5: Değer döndürmeyip print ile çıktı veren fonksiyon ile return ile değer döndüren fonksiyon kullanım tercihinizi neye göre belirlersiniz.

//Q6: HW: if let ve gurad let arasındaki farkı bir kaç cümle ile açıklayınız.

/* Q7: Fonksiyona parametre olarak verilen sayıya göre + - karakterlerini ekrana yazdıran bir fonksiyon yaınız.
       Örneğin 1 için sadece +, 2 için +-, 5 için +-+-+ şeklinde olmalıdır
 
   Q8: Fonksiyona parametre olarak verilen sayıyı en büyük yapacak şekilde 5 sayısını yanına koyunuz.
       Örneğin parametre 0 için çıktı 50 olmalıdır. Parametre 28 için 285, parametre 920 için 9520 olmalıdır
*/



//MARK: QUESTION 1: PROJECT EULER

/* EULER Q4
 Largest palindrome product:
 A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
 Find the largest palindrome made from the product of two 3-digit numbers.
 */

var answerEuler4 = 0
var k = 0
var stringNumber = ""
for i in (100...999) {
  for j in (100...i) {
    k = i * j
      stringNumber = String(k)
      if stringNumber == String(stringNumber.reversed()) && k > answerEuler4 {
          answerEuler4 = k
    }
  }
}

print("Answer for Euler 4: \(answerEuler4)")
 

/*
 EULER Q5
 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
 What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
*/


var answerEuler5 = 2520
while (answerEuler5 % 2 != 0 || answerEuler5 % 3 != 0 ||
       answerEuler5 % 4 != 0 || answerEuler5 % 5 != 0 ||
       answerEuler5 % 6 != 0 || answerEuler5 % 7 != 0 ||
       answerEuler5 % 8 != 0 || answerEuler5 % 9 != 0 ||
       answerEuler5 % 10 != 0 || answerEuler5 % 11 != 0 ||
       answerEuler5 % 12 != 0 || answerEuler5 % 13 != 0 ||
       answerEuler5 % 14 != 0 || answerEuler5 % 15 != 0 ||
       answerEuler5 % 16 != 0 || answerEuler5 % 17 != 0 ||
       answerEuler5 % 18 != 0 || answerEuler5 % 19 != 0 ||
       answerEuler5 % 20 != 0) {
    
    answerEuler5 += 2520
}
print("Answer for Euler 5: \(answerEuler5)")

/*
 EULER 6: Sum square difference
 */

var answerEuler6 = 0
var sumOfSquares = 0
var squareOfSums = 0

for i in 1...100{
    sumOfSquares += i*i
}

for j in 1...100{
    squareOfSums += j
}
squareOfSums *= squareOfSums
answerEuler6 = squareOfSums - sumOfSquares
print("Answer for Euler 6: \(answerEuler6)")


//MARK: QUESTION 2: PALINDROME CHECK


var isPalindrome = "Ey Edip pide ye"

func palindromeCheck(input: String){
    
    if(input.lowercased().elementsEqual(input.lowercased().reversed())){
        print("The input is palindrome")
    } else {
        print("The input is NOT palindrome")
    }
}
palindromeCheck(input: isPalindrome)



//MARK: QUESTION 3: KAREKÖK KULLANIMIYLA ASAL SAYI OLUP OLMADIĞINI BULMA

var isPrime = true
func isPrimeNumber(num: Int) -> Bool{
    let sqrtOfNum = sqrt(Double(num))
    for i in 2...Int(sqrtOfNum){
        if num % i == 0{
            isPrime = false
        }
    }
    return isPrime
    }

print("Given number is prime number? \(isPrimeNumber(num: 5))")

//MARK: Q4: Bir sınıfta en az bir yazılım dili bilenlerin sayısı 24, sadece swift bilenler 12, sadece kotlin bilenler 8 olduğuna göre her iki dili bilen kaç kişi vardır. (Sınıfta 24 kişi var, sadece swift ve kotlin bilinmekte.)

let onlySwift = 12
let onlyKotlin = 8
let wholeClass = 24
var both = 0
func findBoth(onlySwift: Int, onlyKotlin: Int, wholeClass: Int){
    both = wholeClass - (onlySwift + onlyKotlin)
    print("İki dili bilenlerin sayisi = \(both)")
}

findBoth(onlySwift: onlySwift, onlyKotlin: onlyKotlin, wholeClass: wholeClass)
//MARK: Q7: Fonksiyona parametre olarak verilen sayıya göre + - karakterlerini ekrana yazdıran bir fonksiyon yazınız. Örneğin 1 için sadece +, 2 için +-, 5 için +-+-+ şeklinde olmalıdır

var param = 1
var output = ""
func printMinusPlus(input: Int){
    for i in 1...input{
        if i % 2 != 0{
            output += "+"
        } else {
            output += "-"
        }
    }
    print(output)
    
}
printMinusPlus(input: param)

//MARK: Q8: Fonksiyona parametre olarak verilen sayıyı en büyük yapacak şekilde 5 sayısını yanına koyunuz. Örneğin parametre 0 için çıktı 50 olmalıdır. Parametre 28 için 285, parametre 920 için 9520 olmalıdır



