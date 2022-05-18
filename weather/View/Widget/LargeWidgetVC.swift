//
//  LargeWidgetVC.swift
//  weather
//
//  Created by Ben Leung on 2022/05/18.
//

import UIKit

final class LargeWidgetVC: UIViewController, WidgetVCProtocol {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackground()
    }

    static func instantiate() -> LargeWidgetVC {
        let vc = UIStoryboard(name: "LargeWidgetVC", bundle: nil).instantiateViewController(identifier: "LargeWidgetVC") as! LargeWidgetVC
        return vc
    }
}
