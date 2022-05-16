//
//  HomeViewController.swift
//  weather
//
//  Created by Ben Leung on 2022/05/16.
//

import UIKit

final class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public override func viewDidLoad() {
        super.viewDidLoad()
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
            print(imageURL.path) // FIXME: debuging
        }
        dismiss(animated: true, completion: {
            // FIXME: do something with the image
        })
    }
}
