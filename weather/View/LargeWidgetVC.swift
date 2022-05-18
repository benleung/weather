//
//  LargeWidgetVC.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

final class LargeWidgetVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> LargeWidgetVC {
        let vc = UIStoryboard(name: "LargeWidgetVC", bundle: nil).instantiateViewController(identifier: "LargeWidgetVC") as! LargeWidgetVC
        return vc
    }
}
