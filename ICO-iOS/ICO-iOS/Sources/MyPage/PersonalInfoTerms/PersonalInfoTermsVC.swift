//
//  PersonalInfoTermsVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/10.
//

import UIKit
import PDFKit
class PersonalInfoTermsVC: UIViewController {
    
    @IBOutlet weak var PDFView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = Bundle.main.url(forResource: "PersonalTerms", withExtension: "pdf") else{
            return
        }
        guard let document = PDFDocument(url: url) else{
            return
        }
        loadPdfView(document: document)
        
    }
    
    @IBAction func didTabpBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapHomeButton(_ sender: Any) {
    }
    func loadPdfView(document: PDFDocument) {
        PDFView.autoScales = true
        PDFView.displayMode = .singlePageContinuous
        PDFView.displayDirection = .vertical
        PDFView.document = document
    }
}
