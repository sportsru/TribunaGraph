//
//  Exception.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 23/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

enum Exception: Error {
    case noFieldsInSelectionSet(_ message: String)
    case noSuchFragment(_ message: String)
    case illegalArgument(_ message: String)
    case cannotCreate(_ fieldName: String)
}
