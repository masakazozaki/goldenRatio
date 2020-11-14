//
//  PaddingLabel.swift
//  goldenRatio
//
//  Created by Masakaz Ozaki on 2020/11/15.
//  Copyright © 2020 Masakazu Ozaki. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {

    var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)

    override func drawText(in rect: CGRect) {
        let newRect = rect.inset(by: padding)
        super.drawText(in: newRect)
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
