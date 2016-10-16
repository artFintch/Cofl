//
//  main.swift
//  Cofl
//
//  Created by Vyacheslav Khorkov on 15/10/2016.
//  Copyright © 2016 Vyacheslav Khorkov. All rights reserved.
//

import Foundation
import XcodeEditor

let projectPath = StringOption(shortFlag: "p", longFlag: "project", required: true, helpMessage: "Path to the project file.")
let compilerFlags = MultiStringOption(shortFlag: "f", longFlag: "flag", required: true, helpMessage: "Compile flags without -.")
let sourceFiles = MultiStringOption(shortFlag: "s", longFlag: "sources", required: true, helpMessage: "Source files.")
let help = BoolOption(shortFlag: "h", longFlag: "help", helpMessage: "Prints a help message.")

let commandLine = CommandLine()
commandLine.addOptions(projectPath, compilerFlags, sourceFiles, help)

do {
    try commandLine.parse()
} catch {
    let arguments = Swift.CommandLine.arguments
    if arguments.contains("-help") || arguments.contains("-h") {
        commandLine.printUsage()
    }
    else {
        commandLine.printUsage(error)
    }
    exit(EX_USAGE)
}

let filePathOutput = "File path: "
var separatorString = ""
for _ in 0...(projectPath.value!.characters.count + filePathOutput.characters.count) {
    separatorString += "-"
}

print(separatorString)

// All required options are not equal nil
print(filePathOutput, projectPath.value!)

print("Compiler flags:")
for compilerFlag in compilerFlags.value! {
    print("\t* -\(compilerFlag)")
}

print("Source files:")
for sourceFile in sourceFiles.value! {
    print("\t* \(sourceFile)")
}

print(separatorString)

guard let project = XCProject(filePath: projectPath.value!) else {
    exit(EX_NOINPUT)
}

var projectWasChanged: Bool = false
var compilerFlagsInLine = ""
for compilerFlag in compilerFlags.value! {
    if !compilerFlagsInLine.isEmpty {
        compilerFlagsInLine += " "
    }
    compilerFlagsInLine += "-" + compilerFlag
}

for sourceFile in sourceFiles.value! {
    if let file = project.file(withName: sourceFile) {
        file.setCompilerFlags(compilerFlagsInLine)
        projectWasChanged = true
    }
}

if projectWasChanged {
    project.save()
}
