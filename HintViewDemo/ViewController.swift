//
//  ViewController.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let view = PopupsView()
        view.frame = self.view.bounds
        self.view.addSubview(view)
        
        let unit = PopupsView.CenterUnit(frame: CGRect.zero)
//        unit.backgroundColor = UIColor.red
        view.display(unit: unit)
        view.run_timer()
        
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                let unit2 = PopupsView.CenterUnit(frame: CGRect.zero)
                view.display(unit: unit2)
            }
        }
        
        
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 1)
            DispatchQueue.main.async {
                let unit2 = PopupsView.BottomUnit(frame: CGRect.zero)
                view.display(unit: unit2)
                
                
                DispatchQueue.global().async {
                    Thread.sleep(forTimeInterval: 1)
                    DispatchQueue.main.async {
                        let unit2 = PopupsView.BottomUnit(frame: CGRect.zero)
                        view.display(unit: unit2)
                        
                        
                        
                        DispatchQueue.global().async {
                            Thread.sleep(forTimeInterval: 1)
                            DispatchQueue.main.async {
                                let unit2 = PopupsView.BottomUnit(frame: CGRect.zero)
                                view.display(unit: unit2)
                            }
                        }
                    }
                }
            }
        }
    }
    
}

class TableViewController: UITableViewController {
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            view.hint(text: "Test text.")
        case (0,1):
            view.hint(text: "This is a test text, you are select the indexPath at section(0) row(1).")
        case (0,2):
            view.hint(text: "Test text.")
            view.hint(text: "This is a test text, you are select the indexPath at section(0) row(2).")
        case (1, 0):
            view.hint(success: nil)
        case (1,1):
            view.hint(error: nil)
        case (1,2):
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.view.hint(success: nil)
                }
                Thread.sleep(forTimeInterval: 1)
                DispatchQueue.main.async {
                    self.view.hint(error: nil)
                }
                Thread.sleep(forTimeInterval: 1)
                DispatchQueue.main.async {
                    self.view.hint(info: nil)
                }
            }
        case (1,3):
            view.hint(success: "Success!")
        case (1,4):
            view.hint(error: "Error!")
        case (1,5):
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.view.hint(success: "Success!")
                }
                Thread.sleep(forTimeInterval: 1)
                DispatchQueue.main.async {
                    self.view.hint(error: "Error!")
                }
            }
        case (3,0):
            let unit = PopupsView.CenterUnit(frame: CGRect.zero)
            unit.backgroundColor = UIColor.red
            let view = PopupsView()
            view.bounds = tableView.bounds
            tableView.addSubview(view)
            view.display(unit: unit)
            view.run_timer()
        default:
            break
        }
    }
    
}

