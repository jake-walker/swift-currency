//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftCurrency open source project
//
// Copyright (c) 2024 SwiftCurrency project authors
// Licensed under MIT License
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftCurrency project authors
//
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

import Foundation

let arguments = ProcessInfo.processInfo.arguments
guard (3...5).contains(arguments.count) else {
  FileHandle.standardError.write(Data("""
  Usage:
    ISOStandardCodegen <ISO4217.json> <supported-currencies.swift>
    ISOStandardCodegen <ISO4217.json> <definitions.swift> <lookup.swift> [<supported-currencies.swift>]

  """.utf8))
  exit(65)
}

let isoStandardDefinitions = try parseDefinitions(at: URL(fileURLWithPath: arguments[1]))

if arguments.count == 3 {
  try makeSupportedCurrenciesFile(at: URL(fileURLWithPath: arguments[2]), from: isoStandardDefinitions)
} else {
  try makeISOCurrencyDefinitionFile(at: URL(fileURLWithPath: arguments[2]), from: isoStandardDefinitions)
  try makeMintISOCurrencySupportCodeFile(at: URL(fileURLWithPath: arguments[3]), from: isoStandardDefinitions)
  if arguments.count == 5 {
    try makeSupportedCurrenciesFile(at: URL(fileURLWithPath: arguments[4]), from: isoStandardDefinitions)
  }
}
