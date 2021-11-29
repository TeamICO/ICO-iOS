//
//  ServiceTermVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/20.
//

import UIKit
import PDFKit
class ServiceTermVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var PDFView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: "ServiceTerms", withExtension: "pdf") else{
            return
        }
        guard let document = PDFDocument(url: url) else{
            return
        }
        loadPdfView(document: document)
        
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setBlurEffect(view: topView)
    }
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func loadPdfView(document: PDFDocument) {
        PDFView.autoScales = true
        PDFView.displayMode = .singlePageContinuous
        PDFView.displayDirection = .vertical
        PDFView.document = document
        }

}
