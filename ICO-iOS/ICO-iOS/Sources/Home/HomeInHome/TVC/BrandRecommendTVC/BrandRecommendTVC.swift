//
//  BrandRecommendTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/03.
//

import UIKit
protocol BrandRecommendTVCDelegate : AnyObject{
    func didTapBrandView()
}

class BrandRecommendTVC: UITableViewCell {
    static let identifier = "BrandRecommendTVC"
    
    private var brand : HomeInHomeBrand?
    weak var delegate : BrandRecommendTVCDelegate?
    
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var brandView: UIView!
    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
        setBrandViewTapGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        brandImage.image = nil
        brandNameLabel.text = nil
    }
    
    func getData(data : HomeInHomeBrand,nickname : String){
        self.brand = data
        brandNameLabel.text = brand?.name
        var name = nickname
        
        self.userNameLable.text = "\(name) 님을 위한"
        
        guard let url = URL(string: data.imageURL) else{
                return
            }
        DispatchQueue.global().async {
                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                    guard let data = data else{
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.brandImage.image = UIImage(data: data)
                    }
                }
                task.resume()
        }
        
        collectionView.reloadData()
    }
    
    func setBrandViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapBrandView))
        viewTap.cancelsTouchesInView = false
        brandView.addGestureRecognizer(viewTap)
    }
    @objc func didTapBrandView(){
        delegate?.didTapBrandView()
    }
}
// MARK: - CollectionView Configure
extension BrandRecommendTVC {
    func collectionViewConfigure(){
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: BrandCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BrandCVC.identifier)
        
    }
}
extension BrandRecommendTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brand?.product?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandCVC.identifier, for: indexPath) as! BrandCVC
        if let product = self.brand?.product{
            cell.configure(with: BrandCVCViewModel(with: product[indexPath.row]))
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        if let product = self.brand?.product{
            UIApplication.shared.open(URL(string: product[indexPath.row].contentURL )! as URL, options: [:], completionHandler: nil)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 129)
    }
    
}
