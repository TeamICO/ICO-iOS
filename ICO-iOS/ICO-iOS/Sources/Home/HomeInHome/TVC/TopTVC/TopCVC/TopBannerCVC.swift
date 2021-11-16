//
//  TopBannerCVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/05.
//

import UIKit

class TopBannerCVC: UICollectionViewCell {
    static let identifier = "TopBannerCVC"
    
    @IBOutlet weak var bannerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImage.image = nil
    }
    func setImage(url : String){
        DispatchQueue.global().async {
            guard let url = URL(string: url)  else{
                return
            }
                let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, _ in
                    guard let data = data else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.bannerImage.image = UIImage(data: data)
                    }
                }
                task.resume()
        }
    }
}
