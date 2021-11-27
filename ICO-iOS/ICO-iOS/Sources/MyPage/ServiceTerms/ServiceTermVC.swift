//
//  ServiceTermVC.swift
//  ICO-iOS
//
//  Created by do_yun on 2021/11/20.
//

import UIKit
import PDFKit
class ServiceTermVC: UIViewController {

    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var PDFView: PDFView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = ""

        if let url = URL(string: url),
            let document = PDFDocument(url: url) {
            loadPdfView(document: document)
        }
        
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
