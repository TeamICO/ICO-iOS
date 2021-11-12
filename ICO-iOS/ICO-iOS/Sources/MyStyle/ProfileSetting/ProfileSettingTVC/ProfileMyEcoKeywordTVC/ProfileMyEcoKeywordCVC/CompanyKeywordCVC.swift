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
