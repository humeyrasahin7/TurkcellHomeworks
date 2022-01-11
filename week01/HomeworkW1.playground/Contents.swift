/*
 ÖDEVLER:
 1- Elimizde sadece harflerden oluşan (noktalama işareti veya sayılar yok) uzun stringler olsun. Bu stringler içinde bazı harflerin tekrar edeceğini düşünün. Mesela 'a' harfi 20 farklı yerde geçiyor olabilir. Bir fonksiyon ile verilen parametre değerine eşit ve daha fazla bulunan harfleri siliniz.Sonra geriye kalan stringi ekrana yazdırınız.
 
 Örnek string: "aaba kouq bux"
 Tekrar sayısı 2 verildiğinde : a,b,u silinmeli ve ekrana "koq x" yazılmalı
 Tekrar sayısı 3 verildiğinde : a silinmeli ve ekrana "b kouq bux"
 tekrar sayısı 4 verildiğinde : hiç bir harf silinmeyip aynı string yazılmalı
2- Elimizde uzun bir cümle olsun. Bazı kelimelerin tekrar ettiği bir cümle düşünün. İstediğimiz ise, hangi kelimeden kaç tane kullanıldığını bulmak.
 String = "Merhaba nasılsınız iyiyim siz nasılsınız bende iyiyim"
 Merhaba 1 kere, nasılsınız 2 kere iyiyim 2 kere
 
 3- Cuma akşamı anlatılan script örneğinin, isimlerin hepsini büyük harfle yazdırıp, Z-A ya olacak şekilde sıralamak
 
 4- Euler project (https://projecteuler.net/archives) sayfasındaki ilk 3 soru swift kullanılarak çözülmeli
 */

import UIKit

//MARK: QUESTION 1

let inputSentence = "merhaba benim adim humeyra tanistigimiza memnun oldum"
var lettersArray = [String]()
var repeatCount = 0
var outputSentence = inputSentence

func getRepeatedChars(sentence: String, inputCount: Int) -> String{
    for ch in sentence{
        lettersArray.append(String(ch))
    }
    let arrayCount = lettersArray.count
    for i in 0..<arrayCount{
        for j in 0..<arrayCount{
            if lettersArray[i].elementsEqual(lettersArray[j]) && lettersArray[i] != " " {
                repeatCount += 1
                if repeatCount >= inputCount{
                    outputSentence.removeAll(where: {String($0) == lettersArray[i]})
                }
            }
        }
        repeatCount = 0
    }
    return outputSentence
}
print("final:" + getRepeatedChars(sentence: inputSentence, inputCount: 5))



//MARK: QUESTION 2

let inputSentence2 = "merhaba nasilsiniz iyiyim siz nasilsiniz ben de iyiyim"
var splittedWords = [String.SubSequence]()
var repeatCount2 = 0
var wordsDict: [String.SubSequence : Int] = [:]
func repeatedWords(input: String){
    splittedWords = input.split(separator: " ")
    for i in 0..<splittedWords.count{
        for j in 0..<splittedWords.count{
            if splittedWords[i].elementsEqual(splittedWords[j]){
                repeatCount2 += 1
            }
        }
        if wordsDict[splittedWords[i]] == nil {
            wordsDict[splittedWords[i]] = repeatCount2
        }
        repeatCount2 = 0
    }
    print(wordsDict)
}

repeatedWords(input: inputSentence2)

