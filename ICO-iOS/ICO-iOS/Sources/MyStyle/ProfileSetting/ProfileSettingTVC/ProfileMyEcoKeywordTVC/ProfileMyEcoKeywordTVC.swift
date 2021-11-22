//
//  ProfileMyEcoKeywordTVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/11.
//

import UIKit
protocol ProfileMyEcoKeywordTVCDelegate : AnyObject{
    func tapDonationView(seletedKeywords : [Int])
    func tapAnimalView(seletedKeywords : [Int])
    func tapTradeView(seletedKeywords: [Int])
    func tapVeganView(seletedKeywords : [Int])
    func tapLactoView(seletedKeywords : [Int])
    func tapLactovoView(seletedKeywords : [Int])
    func tapFescoView(seletedKeywords : [Int])
    func tapPlasticFreeView(seletedKeywords : [Int])
    func tapEcoView(seletedKeywords : [Int])
    func tapUpcyclingView(seletedKeywords : [Int])
    func tapPackageView(seletedKeywords : [Int])
    func tapGmoFreeView(seletedKeywords : [Int])
    func tapChemicalView(seletedKeywords : [Int])
    func tapFdaView(seletedKeywords : [Int])
    
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
    
    @IBOutlet weak var chemicalScrollView: UIScrollView!
    var isEcoKeywordState = Array(repeating: false, count: 14)
    var seletedKeywords = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTapGestures()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
    }
    
    func configure(keywords : [ProfileEcoKeyword]){
        
        for i in 0..<keywords.count {
            seletedKeywords.append(keywords[i].ecoKeywordIdx-1)
            
            switch keywords[i].name {
            case "수익기부" :
                setColor(view: donationView, label: donationLabel)
                isEcoKeywordState[0] = true
            case "동물실험 반대":
                setColor(view: animalView, label: animalLabel)
                isEcoKeywordState[1] = true
            case "공정무역":
                setColor(view: tradeView, label: tradeLabel)
                isEcoKeywordState[2] = true
            case "비건":
                setColor(view: veganView, label: veganLabel)
                isEcoKeywordState[3] = true
            case "락토":
                setColor(view: lactoView, label: lactoLabel)
                isEcoKeywordState[4] = true
            case "락토오보":
                setColor(view: lactovoView, label: lactovoLabel)
                isEcoKeywordState[5] = true
            case "페스코":
                setColor(view: fescoView, label: fescoLabel)
                isEcoKeywordState[6] = true
            case "플라스틱 프리":
                setColor(view: plasticfreeView, label: plasticFreeLabel)
                isEcoKeywordState[7] = true
            case "친환경":
                setColor(view: ecoView, label: ecoLabel)
                isEcoKeywordState[8] = true
            case "업사이클링":
                setColor(view: upCyclingView, label: upCyclingLabel)
                isEcoKeywordState[9] = true
            case "비건을 위한 뷰티":
                setColor(view: packageView, label: packageLabel)
                isEcoKeywordState[10] = true
            case "GMO프리":
                setColor(view: gmoFreeView, label: gmoFreeLabel)
                isEcoKeywordState[11] = true
            case "무향료":
                setColor(view: chemicalView, label: chemicalLabel)
                isEcoKeywordState[12] = true
            case "FDA승인":
                setColor(view: fdaView, label: fdaLabel)
                isEcoKeywordState[13] = true

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
    func changeColorLabelAndView(index : Int,view : UIView, label : UILabel){
        if !isEcoKeywordState[index] {
            view.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
            label.textColor = UIColor.appColor(.ecokeywordLabelColor)
            seletedKeywords.append(index)
        }else if isEcoKeywordState[index] {
            view.backgroundColor = UIColor.lightBackground
            label.textColor = UIColor.primaryBlack80
            seletedKeywords = seletedKeywords.filter{$0 != index}
        }
        isEcoKeywordState[index]  = !isEcoKeywordState[index]
    }
    // 수익기부
    func setDonationViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapDonationView))
        viewTap.cancelsTouchesInView = false
        donationView.addGestureRecognizer(viewTap)
    }
    @objc func didTapDonationView(){
        changeColorLabelAndView(index: 0, view: donationView, label: donationLabel)
        delegate?.tapDonationView(seletedKeywords: self.seletedKeywords)
    }
    // 동물실험 반대
    func setAnimalViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAnimalView))
        viewTap.cancelsTouchesInView = false
        animalView.addGestureRecognizer(viewTap)
    }
    @objc func didTapAnimalView(){
        changeColorLabelAndView(index: 1, view: animalView, label: animalLabel)
        delegate?.tapAnimalView(seletedKeywords: self.seletedKeywords)
    }
    // 공정무역
    func setTradeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapTradeView))
        viewTap.cancelsTouchesInView = false
        tradeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapTradeView(){
        changeColorLabelAndView(index: 2, view: tradeView, label: tradeLabel)
        delegate?.tapTradeView(seletedKeywords: self.seletedKeywords)
    }
    // 비건
    func setVeganViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapVeganView))
        viewTap.cancelsTouchesInView = false
        veganView.addGestureRecognizer(viewTap)
    }
    @objc func didTapVeganView(){
        changeColorLabelAndView(index: 3, view: veganView, label: veganLabel)
        delegate?.tapVeganView(seletedKeywords: self.seletedKeywords)
    }
    // 락토
    func setLactoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLactoView))
        viewTap.cancelsTouchesInView = false
        lactoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLactoView(){
        changeColorLabelAndView(index: 4, view: lactoView, label: lactoLabel)
        delegate?.tapLactoView(seletedKeywords: self.seletedKeywords)
    }
    // 락토오보
    func setLactovoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLactovoView))
        viewTap.cancelsTouchesInView = false
        lactovoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLactovoView(){
        changeColorLabelAndView(index: 5, view: lactovoView, label: lactovoLabel)
        delegate?.tapLactovoView(seletedKeywords: self.seletedKeywords)
    }
    // 페스코
    func setFescoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapFescoView))
        viewTap.cancelsTouchesInView = false
        fescoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapFescoView(){
        changeColorLabelAndView(index: 6, view: fescoView, label: fescoLabel)
        delegate?.tapFescoView(seletedKeywords: self.seletedKeywords)
    }
    // 플라스틱 프리
    func setPlasticFreeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapPlasticFreeView))
        viewTap.cancelsTouchesInView = false
        plasticfreeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapPlasticFreeView(){
        changeColorLabelAndView(index: 7, view: plasticfreeView, label: plasticFreeLabel)
        delegate?.tapPlasticFreeView(seletedKeywords: self.seletedKeywords)
    }
    //  친환경
    func setEcoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapEcoView))
        viewTap.cancelsTouchesInView = false
        ecoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapEcoView(){
        changeColorLabelAndView(index: 8, view: ecoView, label: ecoLabel)
        delegate?.tapEcoView(seletedKeywords: self.seletedKeywords)
    }
    //  업사이클링
    func setUpCyclingViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapUpCyclingView))
        viewTap.cancelsTouchesInView = false
        upCyclingView.addGestureRecognizer(viewTap)
    }
    @objc func didTapUpCyclingView(){
        changeColorLabelAndView(index: 9, view: upCyclingView, label: upCyclingLabel)
        delegate?.tapUpcyclingView(seletedKeywords: self.seletedKeywords)
    }
    //  비건을 위한 뷰티
    func setPackageViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapPackageView))
        viewTap.cancelsTouchesInView = false
        packageView.addGestureRecognizer(viewTap)
    }
    @objc func didTapPackageView(){
        changeColorLabelAndView(index: 10, view: packageView, label: packageLabel)
        delegate?.tapPackageView(seletedKeywords: self.seletedKeywords)
    }
    //  GMO프리
    func setGmoFreeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapGmoFreeView))
        viewTap.cancelsTouchesInView = false
        gmoFreeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapGmoFreeView(){
        changeColorLabelAndView(index: 11, view: gmoFreeView, label: gmoFreeLabel)
        delegate?.tapGmoFreeView(seletedKeywords: self.seletedKeywords)
    }
    //  무향료
    func setChemicalViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapChemicalView))
        viewTap.cancelsTouchesInView = false
        chemicalView.addGestureRecognizer(viewTap)
    }
    @objc func didTapChemicalView(){
        changeColorLabelAndView(index: 12, view: chemicalView, label: chemicalLabel)
        delegate?.tapChemicalView(seletedKeywords: self.seletedKeywords)
    }
    //  FDA
    func setFdaViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapFdaView))
        viewTap.cancelsTouchesInView = false
        fdaView.addGestureRecognizer(viewTap)
    }
    @objc func didTapFdaView(){
        changeColorLabelAndView(index: 13, view: fdaView, label: fdaLabel)
        delegate?.tapFdaView(seletedKeywords: self.seletedKeywords)
    }
}

