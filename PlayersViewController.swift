//
//  PlayersViewController.swift
//  BoxCricket
//
//  Created by Fnu, Rohit on 11/2/16.
//  Copyright © 2016 Fnu, Rohit. All rights reserved.
//

import UIKit
import Firebase
import Alamofire


class PlayersViewController: UIViewController, UITextFieldDelegate {
    
    var ref: FIRDatabaseReference!
    var player: [FIRDataSnapshot]! = []
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var playerOfTheDayLabel: UILabel!
    fileprivate var _refHandle: FIRDatabaseHandle!
    
    @IBOutlet weak var playerOfTheDayOutputLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var cancelUpdateButton: UIButton!

    @IBOutlet weak var playerOfTheDayTextField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureDatabase()

    }

    
    @IBAction func LogOut_TouchUp_Inside(_ sender: Any)
    {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            AppState.sharedInstance.signedIn = false
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }


    @IBAction func savePlayer_TouchUpInside(_ sender: Any)
    {
        textFieldShouldReturn(playerOfTheDayTextField)
        self.view.endEditing(true)
        playerOfTheDayTextField.text = ""
        self.playerOfTheDayTextField.isHidden = true
        self.sendButton.isHidden = true
        self.cancelUpdateButton.isHidden = true
    }
    
    @IBAction func vishalDetails_TouchUpInside(_ sender: Any)
    {
        performSegue(withIdentifier: "PlayerDetailsScene", sender: nil)

    }

    @IBAction func rohitButton_TouchUpInside(_ sender: Any)
    {
        performSegue(withIdentifier: "RohitScene", sender: nil)

    }
    
    @IBAction func vishal_TouchUpInside(_ sender: Any)
    {
        performSegue(withIdentifier: "VishalScene", sender: nil)

    }
    
    @IBAction func totoTouchUpInside(_ sender: Any)
    {
        performSegue(withIdentifier: "TotoScene", sender: nil)

    }
    
    @IBAction func liveChat_TouchUpInside(_ sender: Any)
    {
        performSegue(withIdentifier: "LiveChatScene", sender: nil)

    }
    
    @IBAction func latestNewsButton_TouchUpInside(_ sender: Any)
    {
        performSegue(withIdentifier: "LatestNewsScene", sender: nil)

    }

    @IBAction func editButton_TouchupInside(_ sender: Any)
    {
        self.playerOfTheDayTextField.isHidden = false
        self.sendButton.isHidden = false
        self.cancelUpdateButton.isHidden = false
        playerOfTheDayTextField.becomeFirstResponder()
    }
    
    @IBAction func cancelButton_TouchupInside(_ sender: Any)
    {
        self.playerOfTheDayTextField.isHidden = true
        self.sendButton.isHidden = true
        self.cancelUpdateButton.isHidden = true
        self.view.endEditing(true)
    }
    
    deinit
    {
        self.ref.child("BestPlayer").removeObserver(withHandle: _refHandle)
        
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("BestPlayer").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.player.append(snapshot)
            
            let snapshotValue = snapshot.value as? NSDictionary
            let name = snapshotValue?["text"] as? String
            
            self?.playerOfTheDayOutputLabel.text = name
            
            print(" this is snap value: \(snapshot.value)")
            print(snapshot.childrenCount)
            print(" this is snap value: \(name)")
            
        })
    }
    
    // UITextViewDelegate protocol methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        let data = [Constants.MessageFields.text: text]
        sendMessage(withData: data)
        self.view.endEditing(true)
        
        return true
    }
    
    func sendMessage(withData data: [String: String])
    {
        var mdata = data
        mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
        self.ref.child("BestPlayer").childByAutoId().setValue(mdata)
        
    }
 
}
