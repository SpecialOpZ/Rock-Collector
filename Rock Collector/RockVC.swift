//  RockVC.swift
//  Rock Collector
//
//  Created by Anthony on 3/16/17.
//  Copyright © 2017 Anthony. All rights reserved.

import UIKit

class RockVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var enterRockTextField: UITextField!
    @IBOutlet weak var rockImageView: UIImageView!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var rock:Rock? = nil
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        guard rock == nil else {
            rockImageView.image = UIImage(data: rock!.image! as Data)
            enterRockTextField.text = rock!.title
            addUpdateButton.setTitle("Update", for: UIControlState.normal)
            deleteButton.isHidden = false
         return print("We have a rock")
        }
    }
    
    func saveData() {
        do {
            try context.save()
            print("Data was saved")
        } catch {
            print("Unable to save data")
        }
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
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitRockButtonPressed(_ sender: UIButton) {
        
        if rock != nil {
            rock?.title = enterRockTextField.text
            rock?.image = UIImagePNGRepresentation(rockImageView.image!)! as NSData
            print("Rock updated")
        } else {
            let rock = Rock(context: context)
            rock.title = enterRockTextField.text
            rock.image = UIImagePNGRepresentation(rockImageView.image!)! as NSData
        }
        saveData()
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        context.delete(rock!)
        saveData()
        navigationController?.popToRootViewController(animated: true)
    }
}
