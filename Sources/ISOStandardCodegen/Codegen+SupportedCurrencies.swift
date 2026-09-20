//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftCurrency open source project
//
// Copyright (c) 2026 SwiftCurrency project authors
// Licensed under MIT License
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftCurrency project authors
//
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

import Foundation

func makeSupportedCurrenciesFile(at destinationURL: URL, from currencies: [CurrencyDefinition]) throws {
  let entries = currencies
    .sorted { $0.identifiers.alphabetic < $1.identifiers.alphabetic }
    .map { "      \($0.identifiers.alphabetic).self," }
    .joined(separator: "\n")

  let fileContent = """
  \(makeFileHeader())

  extension CurrencyMint {
    /// All ISO currencies supported by this package, sorted by alphabetic code.
    ///
    /// Includes special-purpose ISO entries, such as XTS and XXX, but excludes
    /// custom currencies supplied through a mint's fallback lookup.
    public static var supportedCurrencies: [any CurrencyDescriptor.Type] {
      [
  \(entries)
      ]
    }
  }

  """

  try fileContent.write(to: destinationURL, atomically: true, encoding: .utf8)
}
