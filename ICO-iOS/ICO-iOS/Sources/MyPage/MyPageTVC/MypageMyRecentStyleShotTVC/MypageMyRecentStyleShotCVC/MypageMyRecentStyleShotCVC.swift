//
//  MypageMyRecentStyleShotCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit

class MypageMyRecentStyleShotCVC: UICollectionViewCell {
    static let identifier = "MypageMyRecentStyleShotCVC"
    @IBOutlet weak var userContentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        userContentImage.image = nil
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
                        self?.userContentImage.image = UIImage(data: data)
                    }
                }
                task.resume()
        }
    }
}
