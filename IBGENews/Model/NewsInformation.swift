//
//  NewsInformation.swift
//  IBGENews
//
//  Created by Gustavo Carvalho on 12/04/22.
//

import Foundation

class NewsInformation: Decodable {
    var id: Int!
    var tipo: String!
    var titulo: String!
    var introducao: String!
    var data_publicacao: String!
    var produto_id: Int!
    var produtos: String!
    var editorias: String!
    var imagens: String!
    var produtos_relacionados: String!
    var destaque: Bool!
    var link: String!
}
