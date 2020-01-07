//
//  ViewController.swift
//  TestExtension
//
//  Created by coolkernel on 2019/3/27.
//  Copyright © 2019 CoolKernel. All rights reserved.
//

import UIKit

@objc
public class ViewController: UIViewController {
    @objc static let shared: UIViewController = UIViewController()
    class func shareInstance() -> UIViewController {
        return self.shared 
    }

    @objc static func test() {
        
    }

    func test1() {
        
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

