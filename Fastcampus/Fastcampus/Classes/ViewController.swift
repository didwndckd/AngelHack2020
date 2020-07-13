//
//  ViewController.swift
//  Fastcampus
//
//  Created by Fury on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

class ViewController<V: View>: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = V()
    view.backgroundColor = .white
  }
  
  var customView: V {
    return view as! V
  }
}
