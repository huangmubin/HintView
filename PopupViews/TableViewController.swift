//
//  TableViewController.swift
//  PopupViews
//
//  Created by Myron on 2017/6/27.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var messages: [String?] = [
        nil,
        "Message.",
        "This is a long message for the popups view.",
        "This is a very long message, to test the popups view's size. Maybe you can let it longer."
    ]
    
    var m_index: Int = 0
    var message: String? {
        let i = m_index
        m_index += 1
        if m_index >= messages.count {
            m_index = 0
        }
        return messages[i]
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            view.popup(success: message)
        case (0, 1):
            view.popup(error: message)
        case (0, 2):
            view.popup(info: message)
        case (1, 0):
            view.popup(loading: message)
        case (1, 1):
            view.popup(loading: message)
            DispatchQueue.global().async {
                Thread.sleep(forTimeInterval: 3)
                DispatchQueue.main.async {
                    self.view.popup(success: self.message)
                }
            }
        case (2, 0):
            view.popup(progress: nil)
            var value: CGFloat = 0
            DispatchQueue.global().async {
                for _ in 0 ..< 101 {
                    Thread.sleep(forTimeInterval: 0.1)
                    DispatchQueue.main.async {
                        value += 0.01
                        self.view.popup(update: value)
                    }
                }
            }
        default:
            break
        }
    }
    
    
}
