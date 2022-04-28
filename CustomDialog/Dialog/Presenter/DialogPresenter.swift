//
//  DialogPresenter.swift
//
//  Created by Adauto Oliveira on 07/04/2022.
//  Copyright © 2022 Adauto Oliveira. All rights reserved.
//

import Foundation
import UIKit

class DialogPresenter {
    
    weak var view: DialogVC?
    var router: DialogCustom?
    var interactor: DialogInteractor?
    
    var customIcon: UIImage?
    var title: String?
    var message: String?
    
    var alphaView: CGFloat?
    var cancelAction: (() -> Void)?
    var cancelTitle: String?
    var successAction: (() -> Void)?
    var successTitle: String?
    var orientation: DialogCustom.AxisStack?
    var linkUrl: String?
    var linkDescription: NSAttributedString?

}

