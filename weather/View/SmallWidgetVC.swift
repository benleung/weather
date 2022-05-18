//
//  SmallWidgetVC.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

final class SmallWidgetVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> SmallWidgetVC {
        let vc = UIStoryboard(name: "SmallWidgetVC", bundle: nil).instantiateViewController(identifier: "SmallWidgetVC") as! SmallWidgetVC
        return vc
    }
}
