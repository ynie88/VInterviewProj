//
//  ExtendedViewController.swift
//  SwiftyInterview
//
//  Created by Yuchen Nie on 2/7/17.
//  Copyright © 2017 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit

class ExtendedViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        S3Helper.sharedInstance.writeToFile(text: "Hello another world\n")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
