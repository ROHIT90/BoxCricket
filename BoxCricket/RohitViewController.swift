//
//  RohitViewController.swift
//  BoxCricket
//
//  Created by Fnu, Rohit on 11/3/16.
//  Copyright © 2016 Fnu, Rohit. All rights reserved.
//

import UIKit
import Firebase

class RohitViewController: UIViewController {
    
    var ref: FIRDatabaseReference!
    var rohit: [FIRDataSnapshot]! = []
    var msglength: NSNumber = 10
    fileprivate var _refHandle: FIRDatabaseHandle!
    
    @IBOutlet weak var matchesTextField: UITextField!
    @IBOutlet weak var winsTextField: UITextField!
    @IBOutlet weak var runsTextField: UITextField!
    
    @IBOutlet weak var matchLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var runLabel: UILabel!
    
    @IBOutlet weak var saveRunButton: UIButton!
    @IBOutlet weak var saveWinButton: UIButton!
    @IBOutlet weak var saveMatchButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        configureMatchDatabase()
        configureRunDatabase()
        configureWinDatabase()
        
        saveRunButton.isUserInteractionEnabled = false
        saveWinButton.isUserInteractionEnabled = false
        saveMatchButton.isUserInteractionEnabled = false
    }
    
    
    deinit
    {
        self.ref.child("RohitMatches").removeObserver(withHandle: _refHandle)
        self.ref.child("RohitRuns").removeObserver(withHandle: _refHandle)
        self.ref.child("RohitWins").removeObserver(withHandle: _refHandle)
    }
    
    func configureMatchDatabase() {
        ref = FIRDatabase.database().reference()
        
        _refHandle = self.ref.child("RohitMatches").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            
            strongSelf.rohit.append(snapshot)
            let snapshotValueForMatch = snapshot.value as? NSDictionary
            
            let matches = snapshotValueForMatch?["match"] as? String
            
            self?.matchLabel.text = ("Matches played: \(matches!)")
            
            
        })
    }
    
    func configureRunDatabase() {
        ref = FIRDatabase.database().reference()
        _refHandle = self.ref.child("RohitRuns").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.rohit.append(snapshot)
            
            let snapshotValueForRuns = snapshot.value as? NSDictionary
            
            let runs = snapshotValueForRuns?["runs"] as? String
            
            self?.runLabel.text = ("Total runs: \(runs!)")
            
            
        })
    }
    
    func configureWinDatabase() {
        ref = FIRDatabase.database().reference()
        _refHandle = self.ref.child("RohitWins").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.rohit.append(snapshot)
            
            let snapshotValueForRuns = snapshot.value as? NSDictionary
            
            let wins = snapshotValueForRuns?["wins"] as? String
            
            self?.winLabel.text = ("Total wins: \(wins!)")
            
            
        })
    }
    
    func updateRuns(withData data: [String: String])
    {
        //var mdata = data
        //mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
        self.ref.child("RohitRuns").child("runs").setValue(data)
    }
    
    func updateMatch(withData data: [String: String])
    {
        //var mdata = data
        //mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
        self.ref.child("RohitMatches").child("matches").setValue(data)
    }
    
    func updateWins(withData data: [String: String])
    {
        //var mdata = data
        //mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
        self.ref.child("RohitWins").child("wins").setValue(data)
    }
    
    
    
    @IBAction func updateMatches_TouchUpInside(_ sender: Any)
    {
        self.view.endEditing(true)
        
        let text = matchesTextField.text
        let data = ["match": text]
        updateMatch(withData: data as! [String : String])
        
        matchesTextField.isHidden = true
        
        matchLabel.isHidden = false
        configureMatchDatabase()
        
        saveMatchButton.isUserInteractionEnabled = false
        
    }
    
    @IBAction func updateWins_TouchUpInside(_ sender: Any)
    {
        self.view.endEditing(true)
        
        let text = winsTextField.text
        let data = ["wins": text]
        updateWins(withData: data as! [String : String])
        
        winsTextField.isHidden = true
        
        winLabel.isHidden = false
        configureWinDatabase()
        
        saveWinButton.isUserInteractionEnabled = false
        
        
    }
    
    @IBAction func updateRuns_TouchUpInside(_ sender: Any)
    {
        self.view.endEditing(true)
        
        let text = runsTextField.text
        let data = ["runs": text]
        updateRuns(withData: data as! [String : String])
        
        runsTextField.isHidden = true
        
        runLabel.isHidden = false
        configureRunDatabase()
        saveRunButton.isUserInteractionEnabled = false
        
    }
    
    @IBAction func editMatch_TouchUpInside(_ sender: Any)
    {
        matchesTextField.isHidden = false
        matchLabel.isHidden = true
        
        saveMatchButton.isUserInteractionEnabled = true
        
        
    }
    
    @IBAction func editWin_TouchUpInside(_ sender: Any)
    {
        winsTextField.isHidden = false
        winLabel.isHidden = true
        saveWinButton.isUserInteractionEnabled = true
        
        
        
    }
    @IBAction func editRun_TouchupInside(_ sender: Any)
    {
        runsTextField.isHidden = false
        runLabel.isHidden = true
        saveRunButton.isUserInteractionEnabled = true
            
    }
    
    @IBAction func closeView_TouchUpInside(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
        
    }
    
}
