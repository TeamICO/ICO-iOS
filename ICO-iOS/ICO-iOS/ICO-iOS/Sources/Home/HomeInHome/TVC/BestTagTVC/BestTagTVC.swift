//
//  BestTagTVC.swift
//  ICO
//
//  Created by do_yun on 2021/11/07.
//
import UIKit
enum HomeBestButtonState {
    case today
    case week
    case month
}

class BestTagTVC: UITableViewCell {
    static let identifier = "BestTagTVC"
    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 버튼 클릭시 폰트 색상 변경을 위한 상태 변수
    var isState : HomeBestButtonState = .today {
        didSet{
            switch isState{
            case .today:
                todayButton.backgroundColor = UIColor.appColor(.homeBestButtonBackground)
                weekButton.backgroundColor = .white
                monthButton.backgroundColor = .white
                break
            case .week:
                weekButton.backgroundColor = UIColor.appColor(.homeBestButtonBackground)
                todayButton.backgroundColor = .white
                monthButton.backgroundColor = .white
            case .month:
                monthButton.backgroundColor = UIColor.appColor(.homeBestButtonBackground)
                todayButton.backgroundColor = .white
                weekButton.backgroundColor = .white
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapTodayButton(_ sender: Any) {
        isState = .today
    }
    @IBAction func didTapWeekButton(_ sender: Any) {
        isState = .week
    }
    @IBAction func didTapMonthButton(_ sender: Any) {
        isState = .month
    }
}

// MARK: - CollectionView Configure
extension BestTagTVC {
    func collectionViewConfigure(){
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: BestTagCVC.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BestTagCVC.identifier)
        
    }
}
extension BestTagTVC : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestTagCVC.identifier, for: indexPath) as! BestTagCVC

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 179)
    }
    
}
