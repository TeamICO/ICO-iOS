//
//  ProfileMyEcoKeywordTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit
protocol ProfileMyEcoKeywordTVCDelegate : AnyObject{
    func tapDonationView()
    func tapAnimalView()
    func tapTradeView()
}

class ProfileMyEcoKeywordTVC: UITableViewCell {
    static let identifier = "ProfileMyEcoKeywordTVC"
    
    weak var delegate : ProfileMyEcoKeywordTVCDelegate?
    
    @IBOutlet weak var donationView: UIView!
    @IBOutlet weak var animalView: UIView!
    @IBOutlet weak var tradeView: UIView!
    @IBOutlet weak var veganView: UIView!
    @IBOutlet weak var lactoView: UIView!
    @IBOutlet weak var lactovoView: UIView!
    @IBOutlet weak var fescoView: UIView!
    @IBOutlet weak var plasticfreeView: UIView!
    @IBOutlet weak var ecoView: UIView!
    @IBOutlet weak var upCyclingView: UIView!
    @IBOutlet weak var packageView: UIView!
    @IBOutlet weak var gmoFreeView: UIView!
    @IBOutlet weak var chemicalView: UIView!
    @IBOutlet weak var fdaView: UIView!
    
    @IBOutlet weak var donationLabel: UILabel!
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var tradeLabel: UILabel!
    @IBOutlet weak var veganLabel: UILabel!
    @IBOutlet weak var lactoLabel: UILabel!
    @IBOutlet weak var lactovoLabel: UILabel!
    @IBOutlet weak var fescoLabel: UILabel!
    @IBOutlet weak var plasticFreeLabel: UILabel!
    @IBOutlet weak var ecoLabel: UILabel!
    @IBOutlet weak var upCyclingLabel: UILabel!
    @IBOutlet weak var packageLabel: UILabel!
    @IBOutlet weak var gmoFreeLabel: UILabel!
    @IBOutlet weak var fdaLabel: UILabel!
    
    @IBOutlet weak var chemicalLabel: UILabel!
    
    
    var isCompanyEcoType : CompanyEco = .donation{
        didSet{
            switch isCompanyEcoType{
            case .donation :
                donationView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                donationLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                animalView.backgroundColor = UIColor.lightBackground
                animalLabel.textColor = UIColor.primaryBlack80
                tradeView.backgroundColor = UIColor.lightBackground
                tradeLabel.textColor = UIColor.primaryBlack80
                break
            case .animal :
                animalView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                animalLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                donationView.backgroundColor = UIColor.lightBackground
                donationLabel.textColor = UIColor.primaryBlack80
                tradeView.backgroundColor = UIColor.lightBackground
                tradeLabel.textColor = UIColor.primaryBlack80
                break
            case .trade :
                tradeView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                tradeLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                animalView.backgroundColor = UIColor.lightBackground
                animalLabel.textColor = UIColor.primaryBlack80
                donationView.backgroundColor = UIColor.lightBackground
                donationLabel.textColor = UIColor.primaryBlack80
                break
            }
        }
    }
    var isSocialEcoType : SocialEco = .plasticfree{
        didSet{
            switch isSocialEcoType{
            case .plasticfree :
                plasticfreeView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                plasticFreeLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                break
            case .eco :
                ecoView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                ecoLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                break
            case .upcycling :
                upCyclingView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                upCyclingLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                break
            case .package :
                packageView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                packageLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                break
            }
        }
    }
    var isChemicalEcoType : ChemicalEco = .gmoFree{
        didSet{
            switch isChemicalEcoType{
            case .gmoFree :
                gmoFreeView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                gmoFreeLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                break
            case .chemical :
                chemicalView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                chemicalLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                break
            case .fda :
                fdaView.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
                fdaLabel.textColor = UIColor.appColor(.ecokeywordLabelColor)
                break
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTapGestures()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
    }
    
    
    
    
}
extension ProfileMyEcoKeywordTVC{
    func setTapGestures(){
        setDonationViewTapGesture()
        setAnimalViewTapGesture()
        setTradeViewTapGesture()
    }
    func setDonationViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapDonationView))
        viewTap.cancelsTouchesInView = false
        donationView.addGestureRecognizer(viewTap)
    }
    @objc func didTapDonationView(){
        isCompanyEcoType = .donation
        delegate?.tapDonationView()
    }
    func setAnimalViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAnimalView))
        viewTap.cancelsTouchesInView = false
        animalView.addGestureRecognizer(viewTap)
    }
    @objc func didTapAnimalView(){
        isCompanyEcoType = .animal
        delegate?.tapAnimalView()
    }
    func setTradeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapTradeView))
        viewTap.cancelsTouchesInView = false
        tradeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapTradeView(){
        isCompanyEcoType = .trade
        delegate?.tapTradeView()
    }
}

