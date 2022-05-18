//
//  SmallWidgetVC.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

final class SmallWidgetVC: UIViewController, WidgetVCProtocol {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackground()
    }

    static func instantiate() -> SmallWidgetVC {
        let vc = UIStoryboard(name: "SmallWidgetVC", bundle: nil).instantiateViewController(identifier: "SmallWidgetVC") as! SmallWidgetVC
        return vc
    }
}
