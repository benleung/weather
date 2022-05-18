//
//  MediumWidgetVC.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

final class MediumWidgetVC: UIViewController, WidgetVCProtocol {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackground()
    }

    static func instantiate() -> MediumWidgetVC {
        let vc = UIStoryboard(name: "MediumWidgetVC", bundle: nil).instantiateViewController(identifier: "MediumWidgetVC") as! MediumWidgetVC
        return vc
    }
}
