#!/usr/bin/env swift
import Foundation

var names = ["Mert","Eren","Yusuf","Ali","Zeynep"]
var sortedUppercasedNames = [String]()

print("** names before regularization: **")
for name in names {
 print(name)
}

for i in 0..<names.count{
    sortedUppercasedNames.append(names[i].uppercased())
}
sortedUppercasedNames = sortedUppercasedNames.sorted(by: >)

print("** names after regularization **")
for name in sortedUppercasedNames {
    print(name)
}

