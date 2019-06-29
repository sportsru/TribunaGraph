//
//  CursorConnection.swift
//  Etalon2.0
//
//  Created by Решетников Святослав on 22/10/2018.
//  Copyright © 2018 Tribuna Digital. All rights reserved.
//

internal class CursorConnection: Field {
    init(name: String, argument: GraphArgument, selectionSet: SelectionSet) {
        super.init(name: name, arguments: argument, selectionSet: selectionSet)
    }
}

internal class Edges: Field {
    init(nodeSelectionSet: SelectionSet, additionalField: [Field] = []) {
        var fields = [Field(name: "node", arguments: nil, selectionSet: nodeSelectionSet)]
        fields.append(contentsOf: additionalField)
        super.init(name: "edges", arguments: nil, selectionSet: SelectionSet(fields: fields))
    }
}

internal class GraphCursorPageInfo: Field {
    init(pageSelectionSet: SelectionSet) {
        super.init(name: "pageInfo", arguments: nil, selectionSet: pageSelectionSet)
    }
}
