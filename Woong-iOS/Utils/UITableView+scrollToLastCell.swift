
//
//  UITableView+scrollToLastCell.swift
//  Woong-iOS
//
//  Created by 박세은 on 2018. 7. 5..
//  Copyright © 2018년 Leess. All rights reserved.
//

import Foundation
import UIKit
extension UITableView {
    func scrollToLastCell(animated : Bool) {
        let lastSectionIndex = self.numberOfSections - 1 // last section
        let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: .bottom, animated: animated)
    }
}
