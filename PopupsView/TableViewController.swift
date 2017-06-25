//
//  PopupsTableViewController.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/24.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        // Text
        case (0, 0):
            view.popups(text: "Test message.")
        case (0, 1):
            view.popups(text: "Test message.", at_center: false)
        case (0, 2):
            DispatchQueue.global().async {
                for i in 0 ..< 2 {
                    DispatchQueue.main.async {
                        self.view.popups(text: "Test message \(i).")
                        self.view.popups(text: "Test message \(i).", at_center: false)
                    }
                    Thread.sleep(forTimeInterval: 1)
                }
            }
        // Image
        case (1, 0):
            view.popups(success: nil)
        case (1, 1):
            view.popups(error: nil, at_center: false)
        case (1, 2):
            DispatchQueue.global().async {
                for _ in 0 ..< 2 {
                    DispatchQueue.main.async {
                        self.view.popups(success: nil)
                        self.view.popups(error: nil, at_center: false)
                    }
                    Thread.sleep(forTimeInterval: 1)
                }
            }
        // Image + Text
        case (2, 0):
            view.popups(success: "Success.")
        case (2, 1):
            view.popups(error: "Error.", at_center: false)
        case (2, 2):
            DispatchQueue.global().async {
                for _ in 0 ..< 2 {
                    DispatchQueue.main.async {
                        self.view.popups(success: "Success.")
                        self.view.popups(error: "Error message.", at_center: false)
                    }
                    Thread.sleep(forTimeInterval: 1)
                }
            }
        default:
            break
        }
    }

}
