import Foundation

struct CSVImportFile: ImportFile {
  let type: ImportFileType = .csv
  let headers: [String]
  let rows: [[String]]
}

struct CSVImportFileParser: ImportFileParser {
  
  func parse(url: URL) throws -> ImportFile {
    let fileContents = try String(contentsOf: url)

    var headers = [String]()
    var rows = [[String]]()
    fileContents.split(whereSeparator: \.isNewline).enumerated().forEach { index, row in
      let fields = row.split(separator: ";").map(String.init)
      if index == 0 {
        headers = fields
      } else {
        rows.append(fields)
      }
    }

    return CSVImportFile(headers: headers, rows: rows)
  }
}
