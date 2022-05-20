//
//  HomeViewController.swift
//  weather
//
//  Created by Ben Leung on 2022/05/16.
//

import UIKit
import WidgetKit
import infra

final class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet private weak var viewForPageVC: UIView!
    @IBOutlet private weak var pageControl: UIPageControl!
    private var pageVc: WeatherWidgetsPageVC!

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.view   // Prompt IBOutlet to be loaded

        setupWeatherWidgetsPageVC()
        setupViews()
    }

    static func instantiate() -> HomeViewController {
        let vc = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        vc.navigationItem.title = "Weather Widget"
        return vc
    }

    @IBAction func didTapChangeBackgroundButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.modalTransitionStyle = .coverVertical
        self.present(imagePicker, animated: true, completion: nil)
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController,
                                    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            FileStorage.shared.saveUIImage(image: image, filename: .backgroundImage)
            pageVc.updateWidgetsBackground(image: image)
            WidgetCenter.shared.reloadAllTimelines()
        }
        dismiss(animated: true)
    }

    // MARK: Private Functions
    private func setupViews() {
        viewForPageVC.translatesAutoresizingMaskIntoConstraints = false
        viewForPageVC.addSubview(pageVc.view)
        pageVc.view.frame = viewForPageVC.frame
        pageVc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageVc.view.topAnchor.constraint(equalTo: viewForPageVC.topAnchor),
            pageVc.view.leftAnchor.constraint(equalTo: viewForPageVC.leftAnchor),
            pageVc.view.bottomAnchor.constraint(equalTo: viewForPageVC.bottomAnchor),
            pageVc.view.rightAnchor.constraint(equalTo: viewForPageVC.rightAnchor)
        ])
    }
    
    private func setupWeatherWidgetsPageVC() {
        pageVc = WeatherWidgetsPageVC.instantiate(pageControl: pageControl)
        pageVc.updateWidgetsBackground(image: FileStorage.shared.getUIImage(of: .backgroundImage))
    }
}
