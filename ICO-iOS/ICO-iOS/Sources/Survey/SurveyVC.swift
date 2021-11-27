//
//  SurveyVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit

class SurveyVC: ViewController {
    
    var name: String = ""
    var userIdx : Int = 0
    
   
  
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet var titleLabel: [UILabel]!
    @IBOutlet var emojiLabel: [UILabel]!
    
    @IBOutlet var emojiView: [UIView]!
    
    @IBOutlet weak var passButton: UIButton!
    
    @IBOutlet weak var completButton: UIButton!
    
    
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
    @IBOutlet weak var chemicalLabel: UILabel!
    @IBOutlet weak var fdaLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    var isEcoKeywordState = Array(repeating: false, count: 14)
    var seletedKeywords = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setTapGestures()
       setUI()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func toBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUI(){
        completButton.layer.cornerRadius = 12
        completButton.layer.masksToBounds = true
        completButton.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
        passButton.layer.cornerRadius = 12
        passButton.layer.masksToBounds = true
        passButton.layer.borderColor = UIColor.coGreen70.cgColor
        passButton.layer.borderWidth = 1
        
        
        userNameLabel.text = "\(self.name) 님의"

        for i in 0...3{
            titleLabel[i].font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        }
        
        for j in 0...13{
            emojiLabel[j].font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
            emojiLabel[j].textColor = UIColor.primaryBlack60
            emojiView[j].cornerRadius = 16
            emojiView[j].backgroundColor = UIColor.lightShadow.withAlphaComponent(0.6)
        }
        
    
    }
    
    
    @IBAction func didTapPassButon(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainSB", bundle: nil)
 
        let baseTBC = storyboard.instantiateViewController(identifier: "BaseTBC")
        let vc = baseTBC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTapCompletButton(_ sender: Any) {
        guard let jwtToken = UserDefaults.standard.string(forKey: "jwtToken") else{
            return
        }
        let keywords = self.seletedKeywords.map{String($0 + 1)}
        SurveyMamager.shared.insertUserSurveyInfo(activatedEcoKeyword: keywords,
                                                      userIdx: self.userIdx,
                                                      jwtToken: jwtToken) { response in
            guard response.isSuccess else{
                return
            }
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "MainSB", bundle: nil)
         
                let baseTBC = storyboard.instantiateViewController(identifier: "BaseTBC")
                let vc = baseTBC
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
       
    }

    func setColor(view : UIView, label: UILabel){
        view.backgroundColor = UIColor.appColor(.ecokeywordBackgroundColor)
        label.textColor = UIColor.appColor(.ecokeywordLabelColor)
    }
    
    
    
}
extension SurveyVC{
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
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.iGreen.cgColor
            view.backgroundColor = .white
            label.textColor = UIColor.coGreen
            seletedKeywords.append(index+1)
            
        
        }else if isEcoKeywordState[index] {
            view.layer.borderWidth = 0
            view.backgroundColor = UIColor.lightShadow.withAlphaComponent(0.6)
            label.textColor = UIColor.primaryBlack80
            seletedKeywords = seletedKeywords.filter{$0 != index+1}
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
        
    }
    // 동물실험 반대
    func setAnimalViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapAnimalView))
        viewTap.cancelsTouchesInView = false
        animalView.addGestureRecognizer(viewTap)
    }
    @objc func didTapAnimalView(){
        changeColorLabelAndView(index: 1, view: animalView, label: animalLabel)
        
    }
    // 공정무역
    func setTradeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapTradeView))
        viewTap.cancelsTouchesInView = false
        tradeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapTradeView(){
        changeColorLabelAndView(index: 2, view: tradeView, label: tradeLabel)
        
    }
    // 비건
    func setVeganViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapVeganView))
        viewTap.cancelsTouchesInView = false
        veganView.addGestureRecognizer(viewTap)
    }
    @objc func didTapVeganView(){
        changeColorLabelAndView(index: 3, view: veganView, label: veganLabel)
        
    }
    // 락토
    func setLactoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLactoView))
        viewTap.cancelsTouchesInView = false
        lactoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLactoView(){
        changeColorLabelAndView(index: 4, view: lactoView, label: lactoLabel)
        
    }
    // 락토오보
    func setLactovoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapLactovoView))
        viewTap.cancelsTouchesInView = false
        lactovoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapLactovoView(){
        changeColorLabelAndView(index: 5, view: lactovoView, label: lactovoLabel)
        
    }
    // 페스코
    func setFescoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapFescoView))
        viewTap.cancelsTouchesInView = false
        fescoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapFescoView(){
        changeColorLabelAndView(index: 6, view: fescoView, label: fescoLabel)
        
    }
    // 플라스틱 프리
    func setPlasticFreeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapPlasticFreeView))
        viewTap.cancelsTouchesInView = false
        plasticfreeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapPlasticFreeView(){
        changeColorLabelAndView(index: 7, view: plasticfreeView, label: plasticFreeLabel)
        
    }
    //  친환경
    func setEcoViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapEcoView))
        viewTap.cancelsTouchesInView = false
        ecoView.addGestureRecognizer(viewTap)
    }
    @objc func didTapEcoView(){
        changeColorLabelAndView(index: 8, view: ecoView, label: ecoLabel)
        
    }
    //  업사이클링
    func setUpCyclingViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapUpCyclingView))
        viewTap.cancelsTouchesInView = false
        upCyclingView.addGestureRecognizer(viewTap)
    }
    @objc func didTapUpCyclingView(){
        changeColorLabelAndView(index: 9, view: upCyclingView, label: upCyclingLabel)
        
    }
    //  비건을 위한 뷰티
    func setPackageViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapPackageView))
        viewTap.cancelsTouchesInView = false
        packageView.addGestureRecognizer(viewTap)
    }
    @objc func didTapPackageView(){
        changeColorLabelAndView(index: 10, view: packageView, label: packageLabel)
        
    }
    //  GMO프리
    func setGmoFreeViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapGmoFreeView))
        viewTap.cancelsTouchesInView = false
        gmoFreeView.addGestureRecognizer(viewTap)
    }
    @objc func didTapGmoFreeView(){
        changeColorLabelAndView(index: 11, view: gmoFreeView, label: gmoFreeLabel)
        
    }
    //  무향료
    func setChemicalViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapChemicalView))
        viewTap.cancelsTouchesInView = false
        chemicalView.addGestureRecognizer(viewTap)
    }
    @objc func didTapChemicalView(){
        changeColorLabelAndView(index: 12, view: chemicalView, label: chemicalLabel)
    
    }
    //  FDA
    func setFdaViewTapGesture(){
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(didTapFdaView))
        viewTap.cancelsTouchesInView = false
        fdaView.addGestureRecognizer(viewTap)
    }
    @objc func didTapFdaView(){
        changeColorLabelAndView(index: 13, view: fdaView, label: fdaLabel)
 
    }
}

