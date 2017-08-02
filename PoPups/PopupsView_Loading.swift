//
//  PopupsView_Loading.swift
//  PopupViews
//
//  Created by Myron on 2017/6/27.
//  Copyright © 2017年 myron. All rights reserved.
//

import UIKit

class PopupsView_Loading: PopupsView_Image {
    
    // MARK: - Content Views
    
    var content_loading: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    override func deploy_at_init() {
        self.run_duration = 0
        super.deploy_at_init()
        addSubview(content_loading)
        content_loading.hidesWhenStopped = true
    }
    
    // MARK: - Content Layout
    
    override func update_center_layout() {
        image_hidden = false
        super.update_center_layout()
        content_loading.center = content_image.center
    }
    
    override func update_content_layout() {
        image_hidden = false
        super.update_content_layout()
        content_loading.center = content_image.center
    }
    
    // MARK: - Display and Dismiss
    
    override func display_completion() {
        content_loading.startAnimating()
    }
    
}
