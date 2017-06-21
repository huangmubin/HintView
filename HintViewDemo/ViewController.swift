//
//  ViewController.swift
//  HintViewDemo
//
//  Created by Myron on 2017/6/21.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.hint(success: nil)
        self.view.hint(error: nil)
        self.view.hint(info: nil)
//        DispatchQueue.global().async {
//            for _ in 0 ..< 3 {
//                Thread.sleep(forTimeInterval: 2)
//                DispatchQueue.main.async {
//                }
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

