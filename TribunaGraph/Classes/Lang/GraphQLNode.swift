//
//  GraphQLNode.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

class GraphQLNode {

    var level = 0

    func toString(format: PrintFormat, previousLevel: Int) -> String { return "" }

    func print(value: [String: Any?], format: PrintFormat) -> String {
        return value
            .compactMap { "\($0.key): \(Utils.convertToDataEntry(value: $0.value).toString(format: format))"
            }
            .joined(separator: ", ")
    }

    private func convertToArrayData(value: [Any]) -> ArrayData {
        return ArrayData(value.map { Utils.convertToDataEntry(value: $0) })
    }

    private func convertToObjectData(map: [(key: String, value: Any)]) -> ObjectData {
        return ObjectData(map.map { (key: $0.key, value: Utils.convertToDataEntry(value: $0.value)) })
    }

}

extension String {

    func wrappedWithQuotes(shouldBeEscaped: Bool) -> String {
        if shouldBeEscaped {
            return "\"\(self)\""
        } else {
            return "\\\"\(self)\\\""
        }
    }

}

extension Int {

    func getIndentString() -> String {
        return String(repeating: "  ", count: self)
    }

}

enum PrintFormat {
    case normal
    case pretty
    case json

    func getNewLineString() -> String {
        return self == PrintFormat.pretty ? "\n" : " "
    }
}
