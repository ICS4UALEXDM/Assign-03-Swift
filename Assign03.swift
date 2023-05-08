import Foundation
import Glibc
//
//  FileIO.swift
//
//  Created by Alex De Meo
//  Created on 2023/02/11
//  Version 1.0
//  Copyright (c) 2023 Alex De Meo. All rights reserved.
//
// This program calculates reverses a string

// creating constants and variables
var errorMessage = ""

// Defining the file paths
let inputFile = "input.txt"
let outputFile = "output.txt"

// opening the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFile) else {
    print("Error: Cannot open input file.")
    exit(1)
}

// opening the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFile) else {
    print("Error: Cannot open output file.")
    exit(1)
}

// Reading contents of input file
let inputData = input.readDataToEndOfFile()

// Converting data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: Cannot convert data to string.")
    exit(1)
}

// Splitting string into separate lines
let lines = inputString.components(separatedBy: .newlines)
var outputData = "Output for the recIsPalindrome() function\n\n"
output.write(outputData.data(using: .utf8)!)
for line in lines{
    if (line.count != 0) {
        let isPal = recIsPalindrome(line, 0, line.count - 1)
        if (isPal) {
            outputData = String("\(line) is a palindrome!\n")
        } else {
            outputData = String("\(line) is not a palindrome!\n")
        }
        output.write(outputData.data(using: .utf8)!)
    } else {
        outputData = "Empty line is a palindrome!\n"
        output.write(outputData.data(using: .utf8)!)
    }
}

outputData = "\nOutput for the recCalcSum() function\n\n"
output.write(outputData.data(using: .utf8)!)
for line in lines {
    if (line.count == 0) {
        outputData = "ERROR: Empty line\n"
        output.write(outputData.data(using: .utf8)!)
    } else {
        if let number = Int(line) {
            outputData = String("The triangular number of \(line) is \(recCalcSum(number))\n")
            output.write(outputData.data(using: .utf8)!)
        } else {
            outputData = "ERROR: Not a valid number\n"
            output.write(outputData.data(using: .utf8)!)
        }
    }
}

outputData = "\nOutput for the depthOfPalindrome() function\n\n"
output.write(outputData.data(using: .utf8)!)
for line in lines {
    if (line.count == 0) {
        outputData = "ERROR: Empty line \n"
        output.write(outputData.data(using: .utf8)!)
    } else {
        if let aNum = Int(line) {
            outputData = "The Depth for palindrome of \(line) is \(depthOfPalindrome(aNum))\n"
            output.write(outputData.data(using: .utf8)!)
        } else {
            outputData = "ERROR: Not a valid number \n"
            output.write(outputData.data(using: .utf8)!)
        }
    }
}

// This function checks to see if the inputted line is a palindrome or not
func recIsPalindrome(_ line: String, _ start: Int, _ end: Int) -> Bool {
    if (start == end) {
        return true
    } else if (end < start) {
        return true
        // Checking to see if the start and end letter are the same, if not, then the string can not beb a palindrome.
    } else if (line[line.index(line.startIndex, offsetBy: start)] != line[line.index(line.startIndex, offsetBy: end)]) {
        return false
    } else {
        return recIsPalindrome(line, start + 1, end - 1)
    }
}

// This function reverses the number
func recReverse(_ line: String) -> String {
    if line.isEmpty {
        return line
    } else {
        return String(line.last!) + recReverse(String(line.dropLast())) 
    }
}

// This function calculates the triangular number of a number, the sum of all
// the numbers leading up to said number.
func recCalcSum(_ number: Int) -> Int{
    if (number <= 1) {
        return number
    } else {
        return recCalcSum(number - 1) + number
    }
}

func depthOfPalindrome(_ number: Int) -> Int{
    if (recIsPalindrome(String(number), 0, String(number).count - 1)) {
        return 0
    } else {
        let newNum = Int(recReverse(String(number)))
        return depthOfPalindrome(number + newNum!) + 1
    }
}