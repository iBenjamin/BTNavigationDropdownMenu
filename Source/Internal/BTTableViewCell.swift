//
//  BTTableViewCell.swift
//
//  Copyright (c) 2017 PHAM BA THO (phambatho@gmail.com). All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

class BTTableViewCell: UITableViewCell {
    let checkmarkIconWidth: CGFloat = 50
    let horizontalMargin: CGFloat = 24
    
    var checkmarkIcon: UIImageView!
    var cellContentFrame: CGRect!
    var configuration: BTConfiguration!
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, configuration: BTConfiguration) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configuration = configuration
        
        // Setup cell
        cellContentFrame = CGRect(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.frame.width)!, height: self.configuration.cellHeight)
        self.contentView.backgroundColor = self.configuration.cellBackgroundColor
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.textLabel!.textColor = self.configuration.cellTextLabelColor
        self.textLabel!.font = self.configuration.cellTextLabelFont
        self.textLabel!.textAlignment = self.configuration.cellTextLabelAlignment
        self.detailTextLabel?.textColor = self.configuration.cellDetailLabelTextColor
        self.detailTextLabel?.font = self.configuration.cellDetailLabelFont
        self.detailTextLabel?.textAlignment = self.configuration.cellTextLabelAlignment
        
        if self.textLabel!.textAlignment == .center {
            self.textLabel!.frame = CGRect(x: 0, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
        } else if self.textLabel!.textAlignment == .left {
            self.textLabel!.frame = CGRect(x: horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
        } else {
            self.textLabel!.frame = CGRect(x: -horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
        }
        
        // Checkmark icon
        if self.textLabel!.textAlignment == .center {
            self.checkmarkIcon = UIImageView(frame: CGRect(x: cellContentFrame.width - checkmarkIconWidth, y: (cellContentFrame.height - 18)/2, width: 18, height: 18))
        } else if self.textLabel!.textAlignment == .left {
            self.checkmarkIcon = UIImageView(frame: CGRect(x: cellContentFrame.width - checkmarkIconWidth, y: (cellContentFrame.height - 18)/2, width: 18, height: 18))
        } else {
            self.checkmarkIcon = UIImageView(frame: CGRect(x: horizontalMargin, y: (cellContentFrame.height - 18)/2, width: 18, height: 18))
        }
        self.checkmarkIcon.image = self.configuration.checkMarkImage
        self.checkmarkIcon.contentMode = UIView.ContentMode.scaleAspectFill
        self.contentView.addSubview(self.checkmarkIcon)
        
        // Separator for cell
        let separator = BTTableCellContentView(frame: cellContentFrame)
        if let cellSeparatorColor = self.configuration.cellSeparatorColor {
            separator.separatorColor = cellSeparatorColor
        }
        self.contentView.addSubview(separator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.bounds = cellContentFrame
        self.contentView.frame = self.bounds
    }
    
    func updateLayout() {
        if detailTextLabel?.text != nil, let size = detailTextLabel?.intrinsicContentSize {
            if self.textLabel!.textAlignment == .center {
                self.textLabel!.frame = CGRect(x: 0, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            } else if self.textLabel!.textAlignment == .left {
                self.textLabel!.frame = CGRect(x: horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height - size.height + 2 - 8)
                self.detailTextLabel?.frame = .init(x: horizontalMargin, y: self.textLabel!.frame.height - 2, width: cellContentFrame.width, height: size.height)
            } else {
                self.textLabel!.frame = CGRect(x: -horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            }
        } else {
            if self.textLabel!.textAlignment == .center {
                self.textLabel!.frame = CGRect(x: 0, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            } else if self.textLabel!.textAlignment == .left {
                self.textLabel!.frame = CGRect(x: horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            } else {
                self.textLabel!.frame = CGRect(x: -horizontalMargin, y: 0, width: cellContentFrame.width, height: cellContentFrame.height)
            }
            self.detailTextLabel?.frame = .zero
        }
    }
    
    func showRoundedBottomCorner(show: Bool) {
        if show {
            let maskPath = UIBezierPath(
                roundedRect: cellContentFrame,
                byRoundingCorners: [.bottomLeft, .bottomRight],
                cornerRadii: CGSize(width: 15, height: 15))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            self.layer.mask = shape
        } else {
            let maskPath = UIBezierPath(
                roundedRect: cellContentFrame,
                byRoundingCorners: [.bottomLeft, .bottomRight],
                cornerRadii: CGSize(width: 0, height: 0))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            self.layer.mask = shape
        }
    }
}
