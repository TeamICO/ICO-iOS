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
    
    var isDoantion = false
    var isAnimal = false
    var isTrade = false
    var isVegan = false
    var isLacto = false
    var isLactovo = false
    var isFesco = false
    var isPlasticFree = false
    var isEco = false
    var isUpcycling = false
    var isPackage = false
    var isGmoFree = false
    var isChemical = false
    var isFda = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTapGestures()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
    }
    
    func configure(keywords : [ProfileEcoKeyword]){
        for i in 0..<keywords.count {
            switch keywords[i].name {
            case "수익기부" :
                setColor(view: donationView, label: donationLabel)
                isDoantion = true
            case "동물실험 반대":
                setColor(view: animalView, label: animalLabel)
                isAnimal = true
            case "공정무역":
                setColor(view: tradeView, label: tradeLabel)
                isTrade = true
            case "비건":
                setColor(view: veganView, label: veganLabel)
                isVegan = true
            case "락토":
                setColor(view: lactoView, label: lactoLabel)
                isLacto = true
            case "락토오보":
                setColor(view: lactovoView, label: lactovoLabel)
                isLactovo = true
            case "페스코":
                setColor(view: fescoView, label: fescoLabel)
                isFesco = true
            case "플라스틱 프리":
                setColor(view: plasticfreeView, label: plasticFreeLabel)
                isPlasticFree = true
            case "친환경":
                setColor(view: ecoView, label: ecoLabel)
                isEco = true
            case "업사이클링":
                setColor(view: upCyclingView, label: upCyclingLabel)
                isUpcycling = true
            case "비건을 위한 뷰티":
                setColor(view: packageView, label: packageLabel)
                isPackage = true
            case "GMO프리":
                setColor(view: gmoFreeView, label: gmoFreeLabel)
                isGmoFree = true
            case "무향료":
                setColor(view: chemicalView, label: chemicalLabel)
                isChemical = true
            case "FDA승인":
                setColor(view: fdaView, label: fdaLabel)
                isFda = true

            default:
                break
            }
        }
    }
    func setColor(view : UIView, label: UILabel){
        view.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
        label.textColor = UIColor.appColor(.ecokeywordLabelColor)
    }
    
    
    
}
extension ProfileMyEcoKeywordTVC{
    func setTapGestures(){
        setDonationViewTapGesture()
        setAnimalViewTapGesture()
        setTradeViewTapGesture()
        setVeganViewTapGesture()
        setLactoViewTapGesture()
        setLactovoViewTapGesture()
        setFescoViewTapGesture()
        setPlasticFreeViewTapGesture()
        setEcoViewTapGesture()
        setUpCyclingViewTapGesture()
        setPackageViewTapGesture()
        setGmoFreeViewTapGesture()
        setChemicalViewTapGesture()
        setFdaViewTapGesture()
    
    }
    func changeColorLabelAndView(value : inout Bool,view : UIView, label : UILabel){
        if !value {
            view.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
            label.textColor = UIColor.appColor(.ecokeywordLabelColor)
        }else if value{
            view.backgroundColor = UIColor.lightBackground
            label.textColor = UIColor.primaryBlack80
        }
        value = !value
    }
    // 수익기부
    func setDonationViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapDonationView))
        viewTap.cancelsTouchesInView = false
        donationView.addGestureRecognizer(viewTap)
    }
    @objc func didTapDonationView(){
        changeColorLabelAndView(value: &isDoantion, view: donationView, label: donationLabel)
        delegate?.tapDonationView()
    }
    // 동물실험 반대
    func setAnimalViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAnimalView))
        viewTap.cancelsTouchesInView = false
        animalView.addGestureRecognizer(viewTap)
    }
    @objc func didTapAnimalView(){
        changeColorLabelAndView(value: &isAnimal, view: animalView, label: animalLabel)
        delegate?.tapAnimalView()
    }
    // 공정무역
    func setTradeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapTradeView))
        viewTap.cancelsTouchesInView = false
        tradeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapTradeView(){
        changeColorLabelAndView(value: &isTrade, view: tradeView, label: tradeLabel)
        delegate?.tapTradeView()
    }
    // 비건
    func setVeganViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapVeganView))
        viewTap.cancelsTouchesInView = false
        veganView.addGestureRecognizer(viewTap)
    }
    @objc func didTapVeganView(){
        changeColorLabelAndView(value: &isVegan, view: veganView, label: veganLabel)
        
    }
    // 락토
    func setLactoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLactoView))
        viewTap.cancelsTouchesInView = false
        lactoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLactoView(){
        changeColorLabelAndView(value: &isLacto, view: lactoView, label: lactoLabel)
        
    }
    // 락토오보
    func setLactovoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLactovoView))
        viewTap.cancelsTouchesInView = false
        lactovoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLactovoView(){
        changeColorLabelAndView(value: &isLactovo, view: lactovoView, label: lactovoLabel)
        
    }
    // 페스코
    func setFescoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapFescoView))
        viewTap.cancelsTouchesInView = false
        fescoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapFescoView(){
        changeColorLabelAndView(value: &isFesco, view: fescoView, label: fescoLabel)
        
    }
    // 플라스틱 프리
    func setPlasticFreeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapPlasticFreeView))
        viewTap.cancelsTouchesInView = false
        plasticfreeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapPlasticFreeView(){
        changeColorLabelAndView(value: &isPlasticFree, view: plasticfreeView, label: plasticFreeLabel)
        
    }
    //  친환경
    func setEcoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapEcoView))
        viewTap.cancelsTouchesInView = false
        ecoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapEcoView(){
        changeColorLabelAndView(value: &isEco, view: ecoView, label: ecoLabel)
        
    }
    //  업사이클링
    func setUpCyclingViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapUpCyclingView))
        viewTap.cancelsTouchesInView = false
        upCyclingView.addGestureRecognizer(viewTap)
    }
    @objc func didTapUpCyclingView(){
        changeColorLabelAndView(value: &isUpcycling, view: upCyclingView, label: upCyclingLabel)
        
    }
    //  비건을 위한 뷰티
    func setPackageViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapPackageView))
        viewTap.cancelsTouchesInView = false
        packageView.addGestureRecognizer(viewTap)
    }
    @objc func didTapPackageView(){
        changeColorLabelAndView(value: &isPackage, view: packageView, label: packageLabel)
        
    }
    //  GMO프리
    func setGmoFreeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapGmoFreeView))
        viewTap.cancelsTouchesInView = false
        gmoFreeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapGmoFreeView(){
        changeColorLabelAndView(value: &isGmoFree, view: gmoFreeView, label: gmoFreeLabel)
        
    }
    //  무향료
    func setChemicalViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapChemicalView))
        viewTap.cancelsTouchesInView = false
        chemicalView.addGestureRecognizer(viewTap)
    }
    @objc func didTapChemicalView(){
        changeColorLabelAndView(value: &isChemical, view: chemicalView, label: chemicalLabel)
        
    }
    //  FDA
    func setFdaViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapFdaView))
        viewTap.cancelsTouchesInView = false
        fdaView.addGestureRecognizer(viewTap)
    }
    @objc func didTapFdaView(){
        changeColorLabelAndView(value: &isFda, view: fdaView, label: fdaLabel)
        
    }
}

