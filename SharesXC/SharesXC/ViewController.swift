//
//  ViewController.swift
//  SharesXC
//
//  Created by abdullah on 08/02/1442 AH.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {
    
    var SHaring: [sharing]!
    
    
    var activeTextField: UITextField?
    
    @IBOutlet weak var ShareOutLet: UIBarButtonItem!
    
    @IBOutlet weak var CameraOutLet: UIBarButtonItem!
    
    @IBOutlet weak var TopText: UITextField!
    
    
    @IBOutlet weak var BottomText: UITextField!
    
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.CameraOutLet.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.TopText.delegate = self
        self.BottomText.delegate = self
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setImage(image: UIImage(named: "DefaultImage"))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Disable notification listening
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    @IBAction func chooseFromAlbum(_ sender: Any) {
        self.openImageController(UIImagePickerController.SourceType.photoLibrary)
        
        
        
        
    }
    
    
    
    
    @IBAction func takeNewPicture(_ sender: Any) {
        
        self.openImageController(UIImagePickerController.SourceType.camera)
        
        
    }
    
    func openImageController(_ type: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = type
        present(pickerController, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            setImage(image: image)
            self.ShareOutLet.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        
        let bounds = CGRect(x: -self.ImageView.frame.minX,y: -self.ImageView.frame.minY,width: self.view.bounds.width, height: self.view.bounds.height)
        
        UIGraphicsBeginImageContext(self.ImageView.bounds.size)
        view.drawHierarchy(in: bounds, afterScreenUpdates: true)
        let theMemeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        if let finalImage = theMemeImage {
            let sharingController = UIActivityViewController(activityItems: [finalImage], applicationActivities:[])
            sharingController.completionWithItemsHandler = {(activity, completed, items, error) in
                if (completed){
                    self.save(finalImage)
                }
                
                
                self.dismiss(animated: true, completion: { })
            }
            if let popoverController = sharingController.popoverPresentationController {
                popoverController.barButtonItem = sender as? UIBarButtonItem //UIBarButtonItem(image: finalImage, style: UIBarButtonItem.Style.plain, target: nil, action: nil)
            }
            present(sharingController, animated: true)
        } else {
            print("Error creating Meme Image!")
        }
        
        
    }
    
    
    func save(_ sharingImage: UIImage) {
        
        let SHaring = sharing(image: self.ImageView.image, topText: self.TopText.attributedText, bottomText: self.BottomText.attributedText, sharingImage: sharingImage)
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.SHarrring.append(SHaring)
    }
    
    
    
    func setImage(image: UIImage?) {
        if let image = image {
            self.ImageView.image = image
            let availableSize = self.view.bounds.size
            
            let imageAspectRatio = self.view.bounds.height * 0.75
            let screenAspectRatio = self.view.bounds.height * 0.75
            
            if imageAspectRatio > screenAspectRatio {
                self.imageViewWidthConstraint.constant = min(image.size.width, availableSize.width)
                self.imageViewHeightConstraint.constant = self.imageViewWidthConstraint.constant / imageAspectRatio
            }
            else {
                self.imageViewHeightConstraint.constant = min(image.size.height, availableSize.height)
                self.imageViewWidthConstraint.constant = self.imageViewHeightConstraint.constant * imageAspectRatio
            }
            view.layoutIfNeeded()
        }
        return
    }
    
    @objc func rotated() {
        self.setImage(image: self.ImageView.image)
    }
    
    
}

