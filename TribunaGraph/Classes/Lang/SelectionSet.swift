//
//  SelectionSet.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class SelectionSet: GraphQLNode {

    let fields: [Field]

    init(fields: [Field]) {
        self.fields = fields
    }

    override func toString(format: PrintFormat, previousLevel: Int) -> String {
        let nl = format.getNewLineString()
        level = format == PrintFormat.pretty ? previousLevel + 1 : 0
        // swiftlint:disable line_length
        let fieldStr = fields.map { "\(level.getIndentString())\($0.toString(format: format, previousLevel: level))" }
            .joined(separator: nl)

        return "{\( nl + fieldStr + nl + previousLevel.getIndentString() )}"
    }

}
