//
//  StyleUploadVC.swift
//  ICO-iOS
//
//  Created by 이은영 on 2021/11/10.
//

import UIKit
import FirebaseStorage
import BSImagePicker
import Photos

class StyleUploadVC: BaseViewController {
    
    var isStart: Bool = true
    var StyleDetailData: StyleDetailResult?
    var selectedContentImage : String?
    var isFix: Bool?
    var styleIndex: Int?
    
    var photoNum : Int = 0
    var urlNum1: Int = 0
    var urlNum2: Int = 0
    var detailNum: Int = 0
    
    //에코 키워드 관련, 선택된 경우: 1 / 선택되지 않은 경우: 0
    var numberList : [Int] = [0,0,0,0,0,0,0]
    var ecoList : [Int] = []
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet var ecoView: [UIView]!
    @IBOutlet var ecoButton: [UIButton]!
    
    @IBOutlet var ecoLevel: [UIButton]!
    @IBOutlet weak var ecoLevelScore: UILabel!
    @IBOutlet weak var navigationTitle: UILabel!
    var serverEcoScore : Int = 0
    @IBOutlet var levelTitle: [UILabel]!
    @IBOutlet var mainTitle: [UILabel]!
    @IBOutlet var urlTitle: [UILabel]!
    @IBOutlet var lineView: [UIView]!
    
    @IBOutlet var urlTextField: [UITextField]!
    @IBOutlet weak var noURL: UILabel!
    
    @IBOutlet weak var urlBtn: UIButton!
    @IBOutlet weak var removeBtn1: UIButton!
    @IBOutlet weak var removeBtn2: UIButton!
    
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var imgNumLabel: UILabel!
    
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var imageNumView: UIView!
    @IBOutlet weak var imgDelBtn: UIButton!
    
    @IBOutlet var essentialView: [UIView]!
    @IBOutlet var essentialLabel: [UILabel]!
    
    @IBOutlet weak var urlLabel1: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var memoView: UIView!
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBOutlet weak var hashTagTextField: UITextField!
    @IBOutlet weak var hashTagCV: UICollectionView!
    @IBOutlet weak var hashTagView: UIView!
    @IBOutlet weak var hashTagText: UILabel!
    @IBOutlet weak var TagLabel: UILabel!
    var hashTagCnt: Int = 0
    var hashTagArr: [String] = []
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    //BsImagepicker관련
    var selectedAssets : [PHAsset] = []
    var userSelectedImages: [UIImage] = []
    
    
    
    
    //에코 키워드를 누르면
    @objc func selectEcoKeywordClicked(_ sender: UIButton){
        if numberList[sender.tag] == 0{
            numberList[sender.tag] = 1
        }else{
            numberList[sender.tag] = 0
        }
        setButton(select: numberList)
    }
   
    
    func checkEco(select: [Int]){
        for i in 0...6{
            if numberList[i] == 1{
                ecoList.append(i+1)
            }
        }
    }
    
    func setButton(select: [Int]){
        for i in 0...6{
            if select[i] == 1 {
                ecoButton[i].setTitleColor(UIColor.white, for: .normal)
                //ecoButton[i].applyGradient(colors: [UIColor.iGreen20.cgColor, UIColor.coGreen60.cgColor])
                ecoButton[i].backgroundColor = UIColor.gradient012
            }else{
                if i == 0{
                    ecoButton[i].backgroundColor = UIColor.lightWarning
                    ecoButton[i].setTitleColor(UIColor.alertWarning, for: .normal)
                }else if i == 1{
                    ecoButton[i].backgroundColor = UIColor.lightSuccess
                    ecoButton[i].setTitleColor(UIColor.alertsSuccess, for: .normal)
                }else if i == 2{
                    ecoButton[i].backgroundColor = UIColor.lightInfo
                    ecoButton[i].setTitleColor(UIColor.alertsInfo, for: .normal)
                }else if i == 3 {
                    ecoButton[i].backgroundColor = UIColor.lightPoint
                    ecoButton[i].setTitleColor(UIColor.point, for: .normal)
                }else if i == 4{
                    ecoButton[i].backgroundColor = UIColor.primaryigreen5
                    ecoButton[i].setTitleColor(UIColor.coGreen90, for: .normal)
                }else if i == 5 {
                    ecoButton[i].backgroundColor = UIColor.lightShadow
                    ecoButton[i].setTitleColor(UIColor.primaryBlack50, for: .normal)
                }else{
                    ecoButton[i].backgroundColor = UIColor.lightError
                    ecoButton[i].setTitleColor(UIColor.alertsError, for: .normal)
                }
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKeyboardWhenTappedAround()
        self.tabBarController?.tabBar.isHidden = true
        setUI()
        urlTextField[0].delegate = self
        urlTextField[1].delegate = self
        memoTextView.delegate = self
        for i in 0...6{
            ecoButton[i].addTarget(self, action: #selector(selectEcoKeywordClicked(_:)), for: .touchUpInside)
        }
        setCV()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow2(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        if isFix == true{
            StyleUploadDataManager().styleEdit(self, styleShotIdx: styleIndex!)
            setFix()
        }
        
        self.navigationController?.navigationBar.isTranslucent = true
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.setBlurEffect(view: topView)
        
        if isStart {
            let blur = UIBlurEffect(style: .regular)
            let blurView = UIVisualEffectView(effect: blur)
            blurView.frame = topView.bounds
            topView.addSubview(blurView)
            topView.sendSubviewToBack(blurView)
            isStart = false
        }
    }
    @objc func keyboardWillShow2(notification: NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        //self.bottom.constant = keyboardFrame.size.height + 20
        //print(keyboardFrame.size.height)
    }
    
    func setCV(){
        hashTagCV.delegate = self
        hashTagCV.dataSource = self
        hashTagCV.register(UINib(nibName: "hashTagCVC", bundle: nil), forCellWithReuseIdentifier: "hashTagCVC")
    }
    
    @IBAction func addHashTag(_ sender: Any) {
        hashTagCnt = hashTagCnt + 1
        if hashTagCnt <= 5{
            hashTagText.text = "\(hashTagCnt)/5"
            hashTagArr.append(hashTagTextField.text!)
            hashTagTextField.text = ""
            hashTagCV.reloadData()
        }
    }
    
    func setUI(){
        navigationTitle.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 20)
        
        for i in 0...5{
            levelTitle[i].font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        }
        for i in 0...5{
            mainTitle[i].font = UIFont.init(name: "AppleSDGothicNeo-Light", size: 16)
        }
        for i in 0...4{
            lineView[i].backgroundColor = UIColor.backGround1
        }
        
        for i in 0...1{
            urlTitle[i].font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
            urlTitle[i].textColor = UIColor.primaryBlack60
            urlTextField[i].backgroundColor = UIColor.backGround1
            urlTextField[i].cornerRadius = 8
            urlTextField[i].leftViewMode = .always
            urlTextField[i].leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        }
        
        for i in 0...6{
            ecoButton[i].layer.cornerRadius = 8
        }
        ecoButton[0].backgroundColor = UIColor.lightWarning
        ecoButton[1].backgroundColor = UIColor.lightSuccess
        ecoButton[2].backgroundColor = UIColor.lightInfo
        ecoButton[3].backgroundColor = UIColor.lightPoint
        ecoButton[4].backgroundColor = UIColor.primaryigreen5
        ecoButton[5].backgroundColor = UIColor.lightShadow
        ecoButton[6].backgroundColor = UIColor.lightError
        ecoButton[0].setTitleColor(UIColor.alertWarning, for: .normal)
        ecoButton[1].setTitleColor(UIColor.alertsSuccess, for: .normal)
        ecoButton[2].setTitleColor(UIColor.alertsInfo, for: .normal)
        ecoButton[3].setTitleColor(UIColor.point, for: .normal)
        ecoButton[4].setTitleColor(UIColor.coGreen90, for: .normal)
        ecoButton[5].setTitleColor(UIColor.primaryBlack50, for: .normal)
        ecoButton[6].setTitleColor(UIColor.alertsError, for: .normal)
        
        for i in 0...3{
            essentialView[i].cornerRadius = 8
            essentialView[i].backgroundColor = UIColor.backGround1
            essentialLabel[i].textColor = UIColor.alertsError
            essentialLabel[i].font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
        }
        
        
        imageView.backgroundColor = UIColor.primaryBlack10
        imageView.cornerRadius = 16
        newImageView.cornerRadius = 16
        imageNumView.backgroundColor = UIColor.primaryBlack40
        imageNumView.cornerRadius = 8
        imgDelBtn.isHidden = true
        
        let font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 16)
        let attributedStr1 = NSMutableAttributedString(string: mainTitle[0].text!)
        attributedStr1.addAttribute(.font, value: font, range: (mainTitle[0].text as! NSString).range(of: "스타일샷"))
        mainTitle[0].attributedText = attributedStr1
        
        let attributedStr2 = NSMutableAttributedString(string: mainTitle[1].text!)
        attributedStr2.addAttribute(.font, value: font, range:(mainTitle[1].text! as NSString).range(of: "에코 키워드"))
        mainTitle[1].attributedText = attributedStr2
        
        let attributedStr3 = NSMutableAttributedString(string: mainTitle[2].text!)
        attributedStr3.addAttribute(.font, value: font, range:(mainTitle[2].text! as NSString).range(of: "만족도"))
        mainTitle[2].attributedText = attributedStr3
        
        let attributedStr4 = NSMutableAttributedString(string: mainTitle[3].text!)
        attributedStr4.addAttribute(.font, value: font, range:(mainTitle[3].text! as NSString).range(of:
        "제품 URL"))
        mainTitle[3].attributedText = attributedStr4
        
        let attributedStr5 = NSMutableAttributedString(string: mainTitle[4].text!)
        attributedStr5.addAttribute(.font, value: font, range:(mainTitle[4].text! as NSString).range(of:
        "상세내용"))
        mainTitle[4].attributedText = attributedStr5
        
        let attributedStr6 = NSMutableAttributedString(string: mainTitle[5].text!)
        attributedStr6.addAttribute(.font, value: font, range:(mainTitle[5].text! as NSString).range(of:
        "어울리는 해시태그"))
        mainTitle[5].attributedText = attributedStr6
        
        plusBtn.setImage(UIImage(named: "icPlus1"), for: .normal)
        imgNumLabel.text = "\(photoNum)/1"
        imgNumLabel.textColor = UIColor.white
        imgNumLabel.font = UIFont.init(name: "AppleSDGothicNeo-Regular", size: 12)
    
        if UIDevice.current.userInterfaceIdiom == .pad {
            uploadBtn.backgroundColor = .gradient01
        }else{
            uploadBtn.setGradient(color1: UIColor.appColor(.feedbackButtoncolor1), color2: UIColor.appColor(.feedbackButtoncolor2))
           
        }
        
        uploadBtn.setTitleColor(UIColor.white, for: .normal)
        uploadBtn.layer.cornerRadius = 12
        uploadBtn.clipsToBounds = true
        uploadBtn.titleLabel?.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 20)
        
        memoView.backgroundColor = UIColor.white
        memoView.cornerRadius = 8
        memoView.borderWidth = 0.5
        memoView.borderColor = UIColor.primaryBlack50
        memoTextView.text = "스타일샷에 대한 무드,후기,느낀 점 모든 좋아요. 적절하지 않은 사진 혹은 글을 게시할 경우 앱 내에서 게시가 제한될 수 있습니다."
        memoTextView.textColor = UIColor.primaryBlack50
        memoTextView.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
        
        urlLabel1.text = "\(urlNum1)/20"
        detailLabel.text = "\(detailNum)/400"
        ecoLevelScore.text = "\(0.0)"
        
        hashTagTextField.backgroundColor = UIColor.backGround1
        hashTagTextField.leftViewMode = .always
        hashTagTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        hashTagView.backgroundColor = UIColor.primaryBlack40
        hashTagView.layer.cornerRadius = 8
        hashTagText.text = "\(hashTagCnt)/5"
        TagLabel.textColor = UIColor.coGreen70
        
        noURL.textColor = UIColor.primaryBlack60
    }
    

    @IBAction func toBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        checkEco(select: numberList)
    }
    
    @IBAction func urlBtn(_ sender: Any) {
        urlBtn.isSelected = !urlBtn.isSelected
        if urlBtn.isSelected{
            urlTextField[1].text = ""
        }
    }
    
    
    @IBAction func removeBtn1Clicked(_ sender: Any) {
        urlTextField[0].text = ""
    }
    
    @IBAction func removeBtn2Clicked(_ sender: Any) {
        urlTextField[1].text = ""
    }
    
    
    @IBAction func ecoLevel1Btn(_ sender: Any) {
        ecoLevel[0].isSelected = !ecoLevel[0].isSelected
        if ecoLevel[0].isSelected{
            ecoLevelScore.text = "\(1).0"
            serverEcoScore = 1
        }else{
            ecoLevelScore.text = "\(0).0"
            serverEcoScore = 0
            ecoLevel[0].isSelected = false
            ecoLevel[1].isSelected = false
            ecoLevel[2].isSelected = false
            ecoLevel[3].isSelected = false
            ecoLevel[4].isSelected = false
        }
    }
    
    @IBAction func ecoLevel2Btn(_ sender: Any) {
        ecoLevel[1].isSelected = !ecoLevel[1].isSelected
        if ecoLevel[1].isSelected{
            ecoLevelScore.text = "\(2).0"
            ecoLevel[0].isSelected = true
            serverEcoScore = 2
        }else{
            ecoLevelScore.text = "\(1).0"
            serverEcoScore = 1
            ecoLevel[1].isSelected = false
            ecoLevel[2].isSelected = false
            ecoLevel[3].isSelected = false
            ecoLevel[4].isSelected = false
        }
    }
    
    @IBAction func ecoLevel3Btn(_ sender: Any) {
        ecoLevel[2].isSelected = !ecoLevel[2].isSelected
        if ecoLevel[2].isSelected{
            ecoLevelScore.text = "\(3).0"
            ecoLevel[1].isSelected = true
            ecoLevel[0].isSelected = true
            serverEcoScore = 3
        }else{
            ecoLevelScore.text = "\(2).0"
            ecoLevel[2].isSelected = false
            ecoLevel[3].isSelected = false
            ecoLevel[4].isSelected = false
            serverEcoScore = 2
        }
    }
    
    @IBAction func ecoLevel4Btn(_ sender: Any) {
        ecoLevel[3].isSelected = !ecoLevel[3].isSelected
        if ecoLevel[3].isSelected{
            ecoLevelScore.text = "\(4).0"
            ecoLevel[2].isSelected = true
            ecoLevel[1].isSelected = true
            ecoLevel[0].isSelected = true
            serverEcoScore = 4
        }else{
            ecoLevelScore.text = "\(3).0"
            ecoLevel[3].isSelected = false
            ecoLevel[4].isSelected = false
            serverEcoScore = 3
        }
    }
    
    
    @IBAction func ecoLevel5Btn(_ sender: Any) {
        ecoLevel[4].isSelected = !ecoLevel[4].isSelected
        if ecoLevel[4].isSelected{
            ecoLevelScore.text = "\(5).0"
            ecoLevel[3].isSelected = true
            ecoLevel[2].isSelected = true
            ecoLevel[1].isSelected = true
            ecoLevel[0].isSelected = true
            serverEcoScore = 5
        }else{
            ecoLevelScore.text = "\(4).0"
            ecoLevel[4].isSelected = false
            serverEcoScore = 4
        }
    }
    
    
    @IBAction func uploadBtn(_ sender: Any) {
        
        PHPhotoLibrary.requestAuthorization( { status in
                    switch status{
                    case .authorized:
                        print("Album: 권한 허용")
                        DispatchQueue.main.async {
                            let imagePicker = ImagePickerController()
                            imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
                            imagePicker.settings.theme.selectionFillColor = UIColor.gradient012
                            imagePicker.modalPresentationStyle = .fullScreen
                            self.presentImagePicker(imagePicker, select: { (asset) in
                                
                            }, deselect: { (asset) in
                                
                            }, cancel: { (assets) in
                                
                            }, finish: { [self](assets) in
                                for i in assets{
                                    self.selectedAssets.append(i)
                                }
                            
                                self.convertAssetToImages()
                                self.newImageView.image = self.userSelectedImages[0]
                                self.newImageView.contentMode = .scaleAspectFill
                                self.photoNum = 1
                                self.imgNumLabel.text = "\(self.photoNum)/1"
                                self.imgDelBtn.isHidden = false
                                
                                guard let image = self.newImageView.image as? UIImage,
                                      let newImage = self.resizeImage(image: image, newWidth: 380) else{
                                    return
                                }
                                
                                let imageId = UUID().uuidString
                                BaseManager.shared.uploadImage(image: newImage, imageId: imageId) { success in
                                    guard success else{
                                        return
                                    }
                                    BaseManager.shared.downloadUrlForPostImage(imageId: imageId) { url in
                                        guard let url = url else{
                                            return
                                        }
                                        self.selectedContentImage = "\(url)"
                                        print(url)
                                    }
                                }
                                
                                
                            })
                        }
                    case .denied:
                        DispatchQueue.main.async {
                            self.presentAlert(title: "사진 접근 권한이 없습니다.\n설정 > 개인 정보 보호 > 사진에서\n권한을 추가해주세요.")
                        }
                        
                    case .restricted, .notDetermined:
                        print("Album: 선택하지 않음")
                    default:
                        break
                    }
                })
    

    }

    //Bsimagepicker형식 변화 관련
    func convertAssetToImages(){
        if selectedAssets.count != 0 {
            for i in 0..<selectedAssets.count{
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                var thumbnail = UIImage()
                
                imageManager.requestImage(for: selectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option){ (result, info) in
                    thumbnail = result!
                }
                
                let data = thumbnail.jpegData(compressionQuality: 0.7)
                let newImage = UIImage(data: data!)
                                
                self.userSelectedImages.append(newImage! as UIImage)
            }

        }
        
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
         let scale = newWidth / image.size.width
         let newHeight = image.size.height * scale
         UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
         image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()

         return newImage
     }
    
    
    
    @IBAction func styleUploadBtn(_ sender: Any) {
        checkEco(select: numberList)
        
        let frame = CGRect(x: 0, y: 0, width: view.width/1.5, height: 38)
      
        if selectedContentImage == nil{
            self.showCustomAlert(alert: CustomAlert(viewModel: CustomAlerViewmoel(text: "사진을 등록해주세요."), frame: frame), button: uploadBtn)
            return
        }
        
        if urlTextField[0].text == nil || urlTextField[1].text == nil{
            self.showCustomAlert(alert: CustomAlert(viewModel: CustomAlerViewmoel(text: "제품 정보를 등록해주세요."), frame: frame), button: uploadBtn)
            return
        }
       
        let styleUploadRequest = StyleUploadRequest(image: selectedContentImage ?? "", category: ecoList, productName: urlTextField[0].text ?? "", productURL: urlTextField[1].text ?? "", point: serverEcoScore, purpleDescription: memoTextView.text!, hashtag: hashTagArr)
        StyleUploadDataManager().styleUpload(styleUploadRequest, self)
        self.navigationController?.popViewController(animated: true)
        /*
        if isFix == true{
            let styleUploadRequest = StyleUploadRequest(image: selectedContentImage ?? "", category: ecoList, productName: urlTextField[0].text ?? "", productURL: urlTextField[1].text ?? "", point: serverEcoScore, purpleDescription: memoTextView.text!, hashtag: hashTagArr)
            StyleUploadDataManager().styleEdit(self, styleShotIdx: styleIndex ?? 0)
            print("00000000000")
            print(urlTextField[1].text)
            print(selectedContentImage ?? "")
            self.navigationController?.popViewController(animated: true)
            print("수정 업로드 서버통신 완료!")
        }*/
    }
    
}

// 스타일샷 텍스트 필드, 텍스트 뷰 관련
extension StyleUploadVC: UITextFieldDelegate, UITextViewDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == urlTextField[0]{
            if let textCount1 = textField.text?.count{
                urlNum1 = textCount1
                urlLabel1.text = "\(urlNum1)/20"
            }
            checkMaxLength(textField: textField, maxLength: 20)
        }
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text!.count > maxLength) {
            textField.deleteBackward()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if memoTextView.textColor == UIColor.primaryBlack50{
            memoTextView.text = nil
            memoTextView.textColor = UIColor.black
            memoTextView.font = UIFont.init(name: "AppleSDGothicNeo-Medium", size: 14)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if memoTextView.text.count > 400{
            memoTextView.deleteBackward()
        }
        detailNum = memoTextView.text.count
        detailLabel.text = "\(detailNum)/400"
        
        return true
    }
}

//스타일샷 해시태그 컬렉션 뷰 관련
extension StyleUploadVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hashTagCnt
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tagCell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashTagCVC", for: indexPath)as? hashTagCVC else {return UICollectionViewCell()}
        
        tagCell.backgroundColor = UIColor.backGround1
        tagCell.tagTitle.textColor = UIColor.coGreen70
        tagCell.layer.cornerRadius = 8
        tagCell.tagTitle.text = "#" + hashTagArr[indexPath.row]
        
        return tagCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = hashTagArr[indexPath.row].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width ?? 0
        let entireSize = size + 50
        return CGSize(width: entireSize, height: 28)
        
    }
}

extension StyleUploadVC{
    func setFix(){
        setUI()
        
    }
}


extension StyleUploadVC{
    func didSuccessStyleUpload(message: String,code: Int){
        print(message)
    }
    
    func didSuccessEditStyle(message: String){
        self.newImageView.setImage(with: StyleDetailData!.imageURL ?? "")
        self.memoTextView.text = StyleDetailData?.resultDescription
        self.urlTextField[0].text = StyleDetailData?.productName
        self.urlTextField[1].text = StyleDetailData?.productURL
        self.ecoLevelScore.text = "\(StyleDetailData?.point ?? 0).0"
  
        hashTagArr = StyleDetailData?.hashtag ?? []
        hashTagCnt = hashTagArr.count
        hashTagCV.reloadData()
       
    
        uploadSetEcoLevel()
        setFixStyleShot()
        setFixCategory()
    }
    
    func setFixCategory(){
        var array = StyleDetailData?.category ?? []
        
        for i in array{
            if i == "제로웨이스트"{
                numberList[0] = 1
            }else if i == "비건"{
                numberList[1] = 1
            }else if i == "에너지절약"{
                numberList[2] = 1
            }else if i == "가치"{
                numberList[3] = 1
            }else if i == "업사이클링"{
                numberList[4] = 1
            }else if i == "클린뷰티"{
                numberList[5] = 1
            }else{
                numberList[6] = 1
            }
        }
        /*
        print("*****************")
        print(numberList)*/
    
        setButton(select: numberList)
        checkEco(select: numberList)
        /*
        print("final")
        print(ecoList)*/
    }
    
    func setFixHashTag(){
        let hashTagArr = StyleDetailData?.hashtag ?? []
        print(hashTagArr.count)
    }

    
    func setFixStyleShot(){
        if self.newImageView.image != nil{
            imgDelBtn.isHidden = false
            photoNum = 1
            imgNumLabel.text = "\(photoNum)/1"
        }
    }
    
    func uploadSetEcoLevel(){
        if ecoLevelScore.text == "5.0"{
            for i in 0...4{
                ecoLevel[i].isSelected = true
            }
        }else if ecoLevelScore.text == "4.0"{
            for i in 0...3{
                ecoLevel[i].isSelected = true
            }
        }else if ecoLevelScore.text == "3.0"{
            for i in 0...2{
                ecoLevel[i].isSelected = true
            }
        }else if ecoLevelScore.text == "2.0"{
            for i in 0...1{
                ecoLevel[i].isSelected = true
            }
        }else if ecoLevelScore.text == "1.0"{
            ecoLevel[0].isSelected = true
        }
    }
}
