//
//  ViewController.swift
//  TribunaGraph
//
//  Created by svyatoslav-reshetnikov on 06/29/2019.
//  Copyright (c) 2019 svyatoslav-reshetnikov. All rights reserved.
//

import UIKit
import TribunaGraph

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let request = makeRequest(by: "sports.ru")
        print(request)
    }

    private func makeRequest(by id: String) -> String {
        let request = Graph { graph in
            graph.request(type: .query) {
                makeQuery($0, by: id)
            }
        }

        return request.queryString
    }

    private func makeQuery(_ builder: Graph.FieldBuilder, by id: String) {
        let args: [String: Any] = ["id": id]

        builder.fieldObject("news", args: args) {
            $0.field("id")
            $0.field("title")
            $0.field("description")
            $0.field("published")
            $0.field("publishedISO8601")
            $0.field("author")
            $0.field("source")
            $0.field("advertisement")
            $0.field("isUGC")
            $0.field("UGCType")
            $0.field("isEditorial")
            $0.field("likesCount")
            $0.field("url")
            $0.field("isLikedByUser")
            $0.fieldObject("tags") {
                $0.field("id")
                $0.field("title")
            }
        }
    }

}

