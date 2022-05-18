//
//  MediumWidgetVC.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

final class MediumWidgetVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    static func instantiate() -> MediumWidgetVC {
        let vc = UIStoryboard(name: "MediumWidgetVC", bundle: nil).instantiateViewController(identifier: "MediumWidgetVC") as! MediumWidgetVC
        return vc
    }
}
