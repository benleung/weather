//
//  WeatherWidgetsPageVC.swift
//  weather
//
//  Created by Ben Leung on 2022/05/17.
//

import Foundation
import UIKit

class WeatherWidgetsPageVC: UIPageViewController {
    private lazy var widgets: [UIViewController] = [
        SmallWidgetVC.instantiate(),
        MediumWidgetVC.instantiate(),
        LargeWidgetVC.instantiate(),
    ]
    
    private weak var pageControl: UIPageControl!
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // pageControl
        pageControl.numberOfPages = widgets.count

        // pageViewController
        setViewControllers([widgets[0]], direction: .forward, animated: true, completion: nil)
        dataSource = self
        delegate = self
    }
    
    func updateWidgetsBackground(image: UIImage?) {
        for widget in widgets {
            _ = widget.view  // Prompt IBOutlet to be loaded, if not loaded yet
            if let widget = widget as? WidgetVCProtocol {
                widget.updateBackground(image: image)
            }
        }
    }
    
    static func instantiate(pageControl: UIPageControl) -> WeatherWidgetsPageVC {
        let vc = WeatherWidgetsPageVC(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        vc.pageControl = pageControl
        vc.pageControl.isUserInteractionEnabled = false
        return vc
    }

}

extension WeatherWidgetsPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
         return widgets.count
     }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let newIndex = pageControl.currentPage + 1
        if (0..<widgets.count).contains(newIndex) {
            return widgets[newIndex]
        }
        return nil // end of page
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let newIndex = pageControl.currentPage - 1
        if (0..<widgets.count).contains(newIndex) {
            return widgets[newIndex]
        }
        return nil // beginning of page
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        if let controllers = pageViewController.viewControllers,
              let newPageIndex = widgets.firstIndex(of: controllers[0]) {
            pageControl.currentPage = newPageIndex
        }
    }
}
