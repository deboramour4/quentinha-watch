//
//  ViewController.swift
//  AskQuentinha
//
//  Created by Ada 2018 on 27/09/2018.
//  Copyright © 2018 Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let model = OrderingModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func startPreparing(_ sender: Any) {
		self.model.makeOrderWithTimer()
	}
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

