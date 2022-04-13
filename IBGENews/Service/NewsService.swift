//
//  NewsService.swift
//  IBGENews
//
//  Created by Gustavo Carvalho on 12/04/22.
//

import Foundation
import Alamofire

class NewsService {
    
    func getNews(completion: @escaping (IBGENewsResponse) -> Void) {
        let params: Parameters = [
            "qtd": 10
        ]
        
        AF.request(
            "https://servicodados.ibge.gov.br/api/v3/noticias",
            method: .get,
            parameters: params
        ).responseDecodable(of: IBGENewsResponse.self) { response in
            completion(response.value!)
        }
    }
}
