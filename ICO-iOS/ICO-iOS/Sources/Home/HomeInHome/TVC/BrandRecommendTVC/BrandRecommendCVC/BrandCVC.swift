//
//  BrandCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/03.
//

import UIKit

class BrandCVC: UICollectionViewCell {
    static let identifier = "BrandCVC"
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var gradientView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientView.setGradient(color1: UIColor.white.withAlphaComponent(0.01), color2: .white)

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        productImage.image = nil
        productName.text = nil
    }

    func configure(with viewModel : BrandCVCViewModel){
        self.productName.text = viewModel.productName

        guard let url = URL(string: viewModel.productUrl) else{
                return
            }
        setImage(url: url, imageV: self.productImage)
        
        
    }
    func setImage(url : URL,imageV : UIImageView){
        DispatchQueue.global().async {
                let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        imageV.image = UIImage(data: data)
                    }
                }
                task.resume()
        }
    }
}

struct BrandCVCViewModel {
    let productUrl : String
    let productName : String
    init(with model : HomeInHomeBrand){
        self.productUrl = model.imageURL
        self.productName = model.name
    }
}
