import Foundation
import UIKit

enum ImportFileType: String {
  case csv
}

protocol ImportFile {
  var type: ImportFileType { get }
  var headers: [String] { get }
  var rows: [[String]] { get }
}

protocol ImportFileParser {
  func parse(url: URL) throws -> ImportFile
}

enum ImportManagerError: Error {
  case notSupported(String)
}

class ImportManager {
  private let router = ImportRouter()
  private let parsers: [String: ImportFileParser] = [
    ImportFileType.csv.rawValue: CSVImportFileParser()
  ]

  func open(url: URL) -> Bool {
    do {
      let file = try parse(url: url)
      router.present(file: file)
      return true
    } catch {
      router.present(error: error)
      return false
    }
  }

  private func isSupported(url: URL) -> Bool {
    parsers.keys.contains(url.pathExtension)
  }

  private func parse(url: URL) throws -> ImportFile {
    guard let parser = parsers[url.pathExtension] else {
      throw ImportManagerError.notSupported(url.pathExtension)
    }
    return try parser.parse(url: url)
  }
}
