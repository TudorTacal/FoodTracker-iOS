//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Tacal Tudor on 26/12/2016.
//  Copyright © 2016 Tacal Tudor. All rights reserved.
//

import UIKit
import os.log


class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //MARK: Properties

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       //The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
    
    }
    //MARK: Navigation 
    //This method lets you configure a view controller before it's presented.
    override func prepare(for seque: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: seque, sender: seque)
        //Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //Set the meal to be passed to MealTableViewController after the unwind seque.
        meal = Meal(name: name, photo: photo, rating: rating)
        
    }
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        //Hides the keyboard
        nameTextField.resignFirstResponder()
        
        //UIImagePickerController is a view that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        //Only allows images to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
   


}

