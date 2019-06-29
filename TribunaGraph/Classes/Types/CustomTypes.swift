//
//  CustomTypes.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

struct GraphVariableType {
    let value: String
}

struct GraphVariable {
    let name: String
    let type: GraphVariableType
    let jsonValue: String
    var dollarName: String {
        return "$\(self.name)"
    }
}
