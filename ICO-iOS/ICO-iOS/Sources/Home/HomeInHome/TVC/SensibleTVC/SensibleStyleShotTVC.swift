//
//  SensibleStyleShotTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
import UIKit

protocol SensibleStyleShotTVCDelegate : AnyObject{
    func didTapEachCells(styleShotIdx : Int, userNickName : String)
}

class SensibleStyleShotTVC: UITableViewCell {
    static let identifier = "SensibleStyleShotTVC"
    
    weak var delegate : SensibleStyleShotTVCDelegate?
    
    private var senseStyleShotModel = [HomeInHomeSenseStyleshot]()

    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getData(data : [HomeInHomeSenseStyleshot],nickname : String){
        self.senseStyleShotModel = data
        let name = nickname
        
        self.userNameLabel.text = "\(name) 님을 위한"

        
        collectionView.reloadData()
    }
}
// MARK: - CollectionView Configure
extension SensibleStyleShotTVC {
    func collectionViewConfigure(){
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: SensibleCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: SensibleCVC.identifier)
        
    }
}
extension SensibleStyleShotTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return senseStyleShotModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SensibleCVC.identifier, for: indexPath) as! SensibleCVC
        
        cell.getData(data: senseStyleShotModel[indexPath.row].category)
        cell.configure(with: SensibleCVCViewModel(with: senseStyleShotModel[indexPath.row]))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.didTapEachCells(styleShotIdx: senseStyleShotModel[indexPath.row].styleshotIdx,userNickName: senseStyleShotModel[indexPath.row].nickname)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 187)
    }
    
}
