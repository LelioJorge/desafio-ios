//
//  seila.swift
//  desafio_ios
//
//  Created by Lelio Jorge on 31/03/21.
//

import Foundation
import UIKit

class NasaCell: UICollectionViewCell {

    static var identifier: String = "NasaCell"

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var nasa: Nasa? {
        didSet {
            downloadImage?()
        }
    }
    var downloadImage: (() -> ())?
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        imageView.image = nil
    }
    func populate(with image: UIImage?){
        DispatchQueue.main.async {
            guard let img = image else {return}
            self.imageView.image = img
            self.setupView()
        }
        
    }

}

extension NasaCell: ViewCoding {
    
    func buildViewHierarchy() {
        self.addSubview(imageView)
    }
    
    func setupConstraints() {
        self.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
    }
    
    
}
