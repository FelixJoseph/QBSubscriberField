//
//  ViewController.swift
//  QBSubscriberField
//
//  Created by Felix Joseph on 06/12/16.
//  Copyright (c) 2016 Felix. All rights reserved.
//

import UIKit
import QBSubscriberField

class ViewController: UIViewController, SubscriberFieldDelegate {

    @IBOutlet weak var subscriberField: QBSubscriberField!

    override func viewDidLoad() {

        super.viewDidLoad()
        subscriberField.callbackDelegate = self
        self.view.backgroundColor = UIColor(red: 81/255, green: 147/255, blue: 217/255, alpha: 1)
    }

    func didFinishTask(sender: String, field subscriberField: QBSubscriberField) {
        // do task using the email
        subscriberField.completion(result: .success)
    }
}
