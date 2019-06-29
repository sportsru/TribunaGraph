//
//  Utils.swift
//  Etalon2.0
//
//  Created by Олег Синев on 30/11/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

import Foundation

class Utils {

    static func convertToDataEntry(value: Any?) -> DataEntry {
        if let value = value as? String {
            return StringData(value)
        } else if let value = value as? Int {
            return NonDecimalNumberData(value)
        } else if let value = value as? Float {
            return DecimalNumberData(Double(value))
        } else if let value = value as? Bool {
            return BooleanData(value)
        } else if let value = value as? Double {
            return DecimalNumberData(value)
        } else if let value = value as? GraphVariable {
            return VariableData(value)
        } else if let value = value as? GraphVariableType {
            return VariableType(value)
        } else if let value = value as? [DataEntry] {
            return ArrayData(value)
        } else if let value = value as? [(key: String, value: DataEntry)] {
            return ObjectData(value)
        } else if let value = value as? [String: Any] {
            return DictionaryData(value)
        } else if let value = value {
            return AnyData(value)
        } else {
            fatalError("You've set the nil type")
        }
    }

}
