//
//  RockVC.swift
//  Rock Collector
//
//  Created by Anthony on 3/16/17.
//  Copyright © 2017 Anthony. All rights reserved.
//

import UIKit

class RockVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var enterRockTextField: UITextField!
    @IBOutlet weak var rockImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        rockImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func photosButtonTapped(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .camera
    }
    
    @IBAction func submitRockButtonPressed(_ sender: UIButton) {
        let rock = Rock(context: context)
        rock.title = enterRockTextField.text
        rock.image = UIImagePNGRepresentation(rockImageView.image!)! as NSData
        
        do {
            try context.save()
            print("Data was saved")
        } catch {
            print("Unable to save data")
        }
        navigationController?.popToRootViewController(animated: true)
    }
}
