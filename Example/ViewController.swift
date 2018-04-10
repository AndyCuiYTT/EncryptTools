//
//  ViewController.swift
//  EncryptTools
//
//  Created by AndyCui on 2018/4/10.
//  Copyright © 2018年 AndyCuiYTT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(String(data:("速度快本反馈给快递反馈速度".ytt.XOR(encryptKeyStr: "qwer")?.ytt.XOR(encryptKeyStr: "qwer"))!, encoding: .utf8))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

