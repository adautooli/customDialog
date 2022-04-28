//
//  DialogVC.swift
//
//  Created by Adauto Oliveira on 07/04/2022.
//  Copyright © 2022 Adauto Oliveira. All rights reserved.
//

import UIKit

class DialogVC: UIViewController {
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var stackButtons: UIStackView!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var successButton: UIButton!
    
    @IBOutlet weak var stackButtonsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var linkBtn: UIButton!
    
    var presenter: DialogPresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func linkAction(_ sender: Any) {
        if let linkUrl = presenter?.linkUrl {
            openLink(linkUrl: linkUrl)
        }
    }
    
}

// MARK: - Funcs
extension DialogVC {
    
    func setupView() {
        
        view.backgroundColor = UIColor(hexString: "000000", alpha: 0.75)
        dialogView.layer.cornerRadius = 3
        labelTitle.text = presenter?.title
        imgIcon.image = presenter?.customIcon
        setupTextView()
        setupButtons()
        setActionsInBtns()
        setLink()
        
    }
    
    func setupTextView() {
        messageLabel.text = presenter?.message
        messageLabel.textColor = UIColor(hexString: "555555")
        
        dialogView.layoutIfNeeded()
    }
    
    func setupButtons() {
        
        cancelButton.layer.cornerRadius = 3
        successButton.layer.cornerRadius = 3
        
        switch presenter?.orientation {
        case .horizontal:
            stackButtons.axis = .horizontal
        default:
            stackButtons.axis = .vertical
            cancelButton.removeFromSuperview()
        }
        
    }
    
    func setActionsInBtns() {
        checkAction()
    }
    
    func checkAction() {
        if let cancelAction = presenter?.cancelAction {
            cancelButton.actionHandler(controlEvents: .touchUpInside, ForAction: cancelAction)
            cancelButton.addTarget(self, action: #selector(dissmisAction(_:)), for: .touchUpInside)
        }else {
            cancelButton.addTarget(self, action: #selector(dissmisAction(_:)), for: .touchUpInside)
        }
        if let successAction = presenter?.successAction {
            successButton.actionHandler(controlEvents: .touchUpInside, ForAction: successAction)
            successButton.addTarget(self, action: #selector(dissmisAction(_:)), for: .touchUpInside)
        }else {
            successButton.addTarget(self, action: #selector(dissmisAction(_:)), for: .touchUpInside)
        }
    }
    
    func setLink() {
        if let linkDescription = presenter?.linkDescription {
            linkBtn.setAttributedTitle(linkDescription, for: .normal)
            stackButtonsConstraint.isActive = false
            self.view.layoutIfNeeded()
        }else {
            linkBtn.removeFromSuperview()
            stackButtonsConstraint.constant = 16
        }
    }
    
    @objc func dissmisAction(_ sender: UIButton) {
        dismiss(animated: true, completion: {
            
        })
    }
    
    func openLink(linkUrl: String) {
        let urlLink = URL(string: linkUrl)
        UIApplication.shared.open(urlLink!)
    }
    
}
extension UIColor {
            
    convenience init(hexString:String, alpha: CGFloat? = nil) {
        let hexString:NSString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) as NSString
        let scanner = Scanner(string: hexString as String)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
                
        var color:UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha: alpha ?? 1)
}
            
func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
            
}

extension UIButton {
    
    private func actionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    func actionHandler(controlEvents control :UIControl.Event, ForAction action:@escaping () -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}
