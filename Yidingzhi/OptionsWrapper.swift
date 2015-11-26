//
//  OptionsViewController.swift
//  Yidingzhi
//
//  Created by flybywind on 15/11/25.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import UIKit

protocol OptionDelegate {
    func afterSelect(optionWrapper:OptionsWrapper)
    func presentViewController(viewCtrl:UIViewController, animated: Bool, completion: (()->Void)?)
}

class OptionsWrapper:NSObject {
    let alertCtrl : UIAlertController
    let button: UIButton
    let title:String
    let options:[String]?
    var selectedOption: String
    var delegate: OptionDelegate?
    
    init(rect: CGRect, title:String, options:[String]?) {
        self.alertCtrl = UIAlertController(title: title, message: nil, preferredStyle: .Alert)
        self.title = title
        self.button = UIButton(type: .System)
        self.button.frame = rect
        self.button.setTitle(title, forState: .Normal)
        self.button.backgroundColor = UIColor.whiteColor()
        self.options = options
        self.selectedOption = ""
        // init必须在子类的所有初始化完成后执行！
        super.init()
        if options == nil {
            print("options list not set!")
            return
        }
        for (i, _) in options!.enumerate() {
            let action = UIAlertAction(title: self.options![i],
                style: .Default, handler:
                {_ in
                    self.selectedOption = self.options![i]
                    self.alertCtrl.dismissViewControllerAnimated(true, completion: nil)
                    if self.delegate == nil {
                        print("no set touch delegate")
                    } else {
                        self.delegate!.afterSelect(self)
                    }
            })
            self.alertCtrl.addAction(action)
        }
        
    }
    
    func onTouch(target: OptionDelegate) {
        self.delegate = target
        self.button.addTarget(self, action: "popUp:",
            forControlEvents: .TouchUpInside)
    }
    func popUp(sender: UIButton!) {
        self.delegate!.presentViewController(self.alertCtrl, animated: true, completion: nil)
    }
}
