//
//  Node.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 23/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class Node: Field {

    init(name: String, additionalFields: inout [Field]) {
        additionalFields.insert(Field(name: "id", arguments: nil, selectionSet: nil), at: 0)
        let selectionSet = SelectionSet(fields: additionalFields)
        super.init(name: name, arguments: nil, selectionSet: selectionSet)
    }

}
