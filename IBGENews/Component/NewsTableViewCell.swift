//
//  NewsCellSourceHelper.swift
//  IBGENews
//
//  Created by Gustavo Carvalho on 12/04/22.
//

import Foundation
import UIKit
import SwiftDate

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var resume: UILabel!
    @IBOutlet weak var postDate: UILabel!

    func updateCellData(_ data: NewsInformation) throws {
        title.text = data.titulo
        resume.text = data.introducao
        
        let pubDate = data.data_publicacao!.toDate("dd/MM/yyyy HH:mm:ss")
        postDate.text = pubDate?.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.portugueseBrazil)
        
        let decoder = JSONDecoder()
        let images = try decoder.decode(NewsMedia.self, from: data.imagens.data(using: .utf8)!)
        
        let imageUrl = URL(string: "https://agenciadenoticias.ibge.gov.br/\(images.image_intro ?? "")")!
        
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: imageUrl) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    self.thumbnail.image = UIImage(data: data)
                }
            }
        }
        
    }

}
