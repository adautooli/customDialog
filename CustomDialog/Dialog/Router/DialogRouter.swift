//
//  DialogRouter.swift
//
//  Created by Adauto Oliveira on 07/04/2022.
//  Copyright © 2022 Adauto Oliveira. All rights reserved.
//

import UIKit

extension DialogCustom {
    public enum DialogStyle {
        case positive, negative, warning
    }
    
    public enum AxisStack {
        case horizontal, vertical
    }
}

class DialogCustom {
    
    private var view: DialogVC?
    private var presenter: DialogPresenter?
    
    public init(message: String) {
        let view = UIStoryboard(name: "DialogVC", bundle: Bundle(for: DialogVC.self)).instantiateViewController(withIdentifier: "DialogVC") as! DialogVC
        self.view = view
        let presenter = DialogPresenter()
        self.presenter = presenter
        self.presenter?.message = message
        
        self.view?.modalPresentationStyle = .overCurrentContext
        self.view?.modalTransitionStyle = .crossDissolve
        self.view?.presenter = self.presenter
    }

}

// MARK: Funcs
extension DialogCustom {
    
    public func show() {
        DispatchQueue.main.async {
            guard let view = self.view,
                let target = UIApplication.shared.topViewController,
                !(target is DialogVC) else {return}
            target.present(view, animated: false, completion: nil)
        }
    }
    
    @discardableResult func addIcon(imgIcon: UIImage?) -> DialogCustom {
        presenter?.customIcon = imgIcon
        return self
        
    }
    
    @discardableResult func addTitle(title: String) -> DialogCustom {
        presenter?.title = title
        return self
        
    }
        
    @discardableResult func addOrientation(orientation: DialogCustom.AxisStack) -> DialogCustom {
        presenter?.orientation = orientation
        return self
    }
    
    @discardableResult func addCancelAction(action: @escaping () -> Void) -> DialogCustom {
        presenter?.cancelAction = action
        return self
    }
    
    @discardableResult func addSuccesslAction(action: @escaping () -> Void) -> DialogCustom {
        presenter?.successAction = action
        return self
    }
    
    @discardableResult func addLink(link: String, linkDescription: NSAttributedString) -> DialogCustom {
        presenter?.linkUrl = link
        presenter?.linkDescription = linkDescription
        return self
    }
    
}

@discardableResult func SuccessDialog(message: String) -> DialogCustom {
    
    return buildDialog(style: DialogCustom.DialogStyle.positive, imgIcon: "successIcon", title: "Sucesso", message: message)
}

@discardableResult func NegativeDialog(message: String) -> DialogCustom {
    
    return buildDialog(style: DialogCustom.DialogStyle.negative, imgIcon: "errorIcon" ,title: "Oops!!", message: message)
}

@discardableResult func WarningDialog(message: String) -> DialogCustom {
    
    return buildDialog(style: DialogCustom.DialogStyle.warning, imgIcon: "image_warning_default", title: "Atenção", message: message, orientation: .horizontal)
}

private func buildDialog(style: DialogCustom.DialogStyle? = nil,
                         imgIcon: String? = nil,
                         title: String? = nil,
                         message: String,
                         successTitle: String? = nil,
                         successAction: (() -> Void)? = nil,
                         cancelTitle: String? = nil,
                         cancelAction: (() -> Void)? = nil,
                         linkUrl: String? = nil,
                         linkDescription: NSAttributedString? = nil,
                         orientation: DialogCustom.AxisStack? = nil) -> DialogCustom {
    
    
    let dialog = DialogCustom(message: message)
    
    if let imgIcon = imgIcon {
        dialog.addIcon(imgIcon: UIImage(named: imgIcon))
    }
    
    if let title = title {
        dialog.addTitle(title: title)
    }
    
    if let orientation = orientation {
        dialog.addOrientation(orientation: orientation)
    }
    
    if let linkUrl = linkUrl {
        dialog.addLink(link: linkUrl, linkDescription: linkDescription!)
    }
    
    dialog.show()
    return dialog
}

extension UIApplication {
    /// Current presented view controller
    public var topViewController: UIViewController? {
        guard var topController: UIViewController = keyWindow?.rootViewController else {return nil}
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }

}
