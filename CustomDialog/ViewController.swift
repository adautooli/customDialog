//
//  ViewController.swift
//  CustomDialog
//
//  Created by Adauto Oliveira on 07/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createButton()
    }
    func createButton() {
       
        
        let continueButton = UIButton()
        continueButton.frame = CGRect(x: self.view.frame.size.width / 2 - 50, y: self.view.frame.size.height / 2 - 25, width: 100, height: 50)
        continueButton.setTitle("Carregar", for: .normal)
        continueButton.backgroundColor = .blue
        continueButton.addTarget(self, action: #selector(goDialog), for: .touchUpInside)
        self.view.addSubview(continueButton)
        
    }
    
    @objc func goDialog(sender: UIButton) {

//        WarningDialog(message: "Testando dialog sucesso")
//            .addCancelAction(action: printMessage)
//            .addTitle(title: "Testando Titulo")
        
            printMessage()
            
    }
    
    func printMessage() {
        let attrLinkTest: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Inter-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor(hexString: "555555")]
        
        let linkAttStr = NSAttributedString(string: "Testando o Link: ", attributes: attrLinkTest)
        
        let attributesImportantDescRegular: [NSAttributedString.Key : Any] = [
            .font : UIFont(name: "Inter-Light", size: 12) ?? UIFont.systemFont(ofSize: 12),
            .foregroundColor: UIColor(hexString: "856404"),
            
        ]
        let descLine2 = NSAttributedString(string: "Uma vez que a conta é excluída, não é possível recuperá-la e todos os seus dados serão perdidos. O processo é irreversível.", attributes: attributesImportantDescRegular)
        
        let linkButtonDescription = NSMutableAttributedString()
        linkButtonDescription.append(linkAttStr)
        linkButtonDescription.append(descLine2)
        
        SuccessDialog(message: "Chamou o successo")
            .addSuccesslAction(action: self.dismissSuccessAndGoTo)
            .addLink(link: "https://www.movida.com.br", linkDescription: linkButtonDescription)
    }
    
    func dismissSuccessAndGoTo () {
        dismiss(animated: true) {
            let vc = UIStoryboard(name: "Second", bundle: nil).instantiateViewController(withIdentifier: "Second") as! SecondViewController
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true)
        }
    }

}



