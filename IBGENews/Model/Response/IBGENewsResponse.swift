//
//  IBGENewsResponse.swift
//  IBGENews
//
//  Created by Gustavo Carvalho on 12/04/22.
//

import Foundation

class IBGENewsResponse: Decodable {
    var totalPages: Int!
    var nextPage: Int!
    var items: [NewsInformation]!
}
