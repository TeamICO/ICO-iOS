//
//  CompanyKeywordCVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/12.
//

import UIKit

class CompanyKeywordCVC: UICollectionViewCell {
    static let identifier = "CompanyKeywordCVC"
    
      static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
          let cell = CompanyKeywordCVC()
          cell.configure(name: name)
          
          let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
          return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
      }
      
      private let titleLabel: UILabel = UILabel()
    
    private let content : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appColor(.keywordBackgroundGray)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setupView()
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          setupView()
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
          
      }
      
      private func setupView() {
          titleLabel.translatesAutoresizingMaskIntoConstraints = false
          titleLabel.textAlignment = .center
          titleLabel.textColor = .black
          
          contentView.addSubview(content)
          content.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
          content.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
          content.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
          content.heightAnchor.constraint(equalToConstant: 32).isActive = true
          
          
          content.addSubview(titleLabel)
          titleLabel.snp.makeConstraints { (make) in
                     make.edges.equalToSuperview().inset(3)
            
                 }
          
      }
      
      func configure(name: String?) {
          titleLabel.text = name
      }
}
//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    return CompanyKeywordCVC.fittingSize(availableHeight: 32, name: arr[indexPath.row])
//   }


//
//var isCompanyEcoType : CompanyEco = .donation{
//    didSet{
//        switch isCompanyEcoType{
//        case .donation :
//            donationView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            donationLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            animalView.backgroundColor = UIColor.lightBackground
//            animalLabel.textColor = UIColor.primaryBlack80
//            tradeView.backgroundColor = UIColor.lightBackground
//            tradeLabel.textColor = UIColor.primaryBlack80
//            break
//        case .animal :
//            animalView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            animalLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            donationView.backgroundColor = UIColor.lightBackground
//            donationLabel.textColor = UIColor.primaryBlack80
//            tradeView.backgroundColor = UIColor.lightBackground
//            tradeLabel.textColor = UIColor.primaryBlack80
//            break
//        case .trade :
//            tradeView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            tradeLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            animalView.backgroundColor = UIColor.lightBackground
//            animalLabel.textColor = UIColor.primaryBlack80
//            donationView.backgroundColor = UIColor.lightBackground
//            donationLabel.textColor = UIColor.primaryBlack80
//            break
//        }
//    }
//}
//var isVeganType : VeganEco =  .vegan {
//    didSet{
//        switch isVeganType{
//        case .vegan :
//            plasticfreeView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            plasticFreeLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .lacto :
//            ecoView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            ecoLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .lactovo :
//            upCyclingView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            upCyclingLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .fesco :
//            packageView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            packageLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        }
//    }
//}
//var isSocialEcoType : SocialEco = .plasticfree{
//    didSet{
//        switch isSocialEcoType{
//        case .plasticfree :
//            plasticfreeView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            plasticFreeLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .eco :
//            ecoView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            ecoLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .upcycling :
//            upCyclingView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            upCyclingLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .package :
//            packageView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            packageLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        }
//    }
//}
//var isChemicalEcoType : ChemicalEco = .gmoFree{
//    didSet{
//        switch isChemicalEcoType{
//        case .gmoFree :
//            gmoFreeView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            gmoFreeLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .chemical :
//            chemicalView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            chemicalLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        case .fda :
//            fdaView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
//            fdaLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
//            break
//        }
//    }
//}
