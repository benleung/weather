//
//  HomeViewController.swift
//  weather
//
//  Created by Ben Leung on 2022/05/16.
//

import UIKit

final class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet private weak var viewForPageVC: UIView!
    @IBOutlet private weak var pageControl: UIPageControl!
    private var pageVc: WeatherWidgetsPageVC!

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = self.view   // Prompt IBOutlet to be loaded

        pageVc = WeatherWidgetsPageVC.instantiate(pageControl: pageControl)

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
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
            pageVc.updateWidgetsBackground(imageURLPath: imageURL.path)
        }
        dismiss(animated: true, completion: {
            // FIXME: do something with the image
        })
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
}
