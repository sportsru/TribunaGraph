//
//  DataEntry.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

protocol DataEntry {
    func toString(format: PrintFormat) -> String
}

class NonDecimalNumberData: DataEntry {

    private let value: Int

    init(_ value: Int) {
        self.value = value
    }

    func toString(format: PrintFormat) -> String {
        return String(value)
    }
}

class DecimalNumberData: DataEntry {

    private let value: Double

    init(_ value: Double) {
        self.value = value
    }

    func toString(format: PrintFormat) -> String {
        return String(value)
    }
}

class BooleanData: DataEntry {

    private let value: Bool

    init(_ value: Bool) {
        self.value = value
    }

    func toString(format: PrintFormat) -> String {
        return String(value)
    }
}

class VariableData: DataEntry {

    private let value: GraphVariable

    init(_ value: GraphVariable) {
        self.value = value
    }

    func toString(format: PrintFormat) -> String {
        return String(value.dollarName)
    }
}

class VariableType: DataEntry {

    private let value: GraphVariableType

    init(_ value: GraphVariableType) {
        self.value = value
    }

    func toString(format: PrintFormat) -> String {
        return String(value.value)
    }
}

class StringData: DataEntry {

    private let value: String

    init(_ value: String) {
        let eventData = try? JSONSerialization.data(withJSONObject: [value], options: [])
        var string = String(data: eventData ?? Data(), encoding: .utf8) ?? ""
        string.removeLast(2)
        string.removeFirst(2)
        self.value = string
    }

    func toString(format: PrintFormat) -> String {
        if format == .json {
            return "\\\"\(value)\\\""
        } else {
            return "\"\(value)\""
        }
    }
}

class ArrayData: DataEntry {

    private let values: [DataEntry]

    init(_ values: [DataEntry]) {
        self.values = values
    }

    func toString(format: PrintFormat) -> String {
        let joined = values
            .compactMap { $0.toString(format: format) }
            .joined(separator: ", ")
        return "[\(joined)]"
    }
}

class ObjectData: DataEntry {

    private let values: [(key: String, value: DataEntry)]

    init(_ values: [(key: String, value: DataEntry)]) {
        self.values = values
    }

    func toString(format: PrintFormat) -> String {
        let joined = values
            .compactMap { "\($0.key): \($0.value.toString(format: format))" }
            .joined(separator: ",")
        return "[\(joined)]"
    }
}

class AnyData: DataEntry {

    private let value: Any

    init(_ value: Any) {
        if let array = value as? [Any] {
            self.value = ArrayData(array.map { AnyData($0) })
        } else {
            self.value = value
        }
    }

    func toString(format: PrintFormat) -> String {
        if let arrayData = value as? ArrayData {
            return arrayData.toString(format: format)
        }
        let dataEntry = Utils.convertToDataEntry(value: value)
        if dataEntry is AnyData {
            return "\(value)"
        }
        return dataEntry.toString(format: format)
    }

}

class DictionaryData: DataEntry {

    private let value: [String: Any]

    init(_ value: [String: Any]) {
        self.value = value
    }

    func toString(format: PrintFormat) -> String {
        let joined = value
            .compactMap { "\($0.key): \(Utils.convertToDataEntry(value: $0.value).toString(format: format))" }
            .joined(separator: ",")
        return "{\(joined)}"
    }

}
