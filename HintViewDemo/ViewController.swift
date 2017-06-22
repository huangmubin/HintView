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
//        self.view.hint(success: "Success, This is a text hint. This is a text hint.")
//        self.view.hint(error: "Error")
//        self.view.hint(info: "Info")
//        self.view.hint(text: "Text hint.")
//        self.view.hint(text: "This is a text hint.")
//        self.view.hint(text: "This is a text hint. This is a text hint. This is a text hint. This is a text hint. This is a text hint. This is a text hint. This is a text hint. This is a text hint. This is a text hint. This is a text hint.")
        let hint = self.view.hint(loading: "Loading ...")
        DispatchQueue.global().async {
            Thread.sleep(forTimeInterval: 3)
            DispatchQueue.main.async {
                hint.update(result: true, text: "Success")
            }
//            for _ in 0 ..< 3 {
//            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

