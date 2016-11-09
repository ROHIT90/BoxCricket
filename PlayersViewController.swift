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


class PlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var ref: FIRDatabaseReference!
    var Vicky: [FIRDataSnapshot]! = []
    var msglength: NSNumber = 10
    
    @IBOutlet weak var newsLabel: UILabel!
    fileprivate var _refHandle: FIRDatabaseHandle!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* let rect = CGRect(x: 320, y: 100, width: 400, height: 60) // CGFloat, Double, Int

        newsLabel = UILabel(frame: rect)
        newsLabel.text = "Your music title here"
        self.view.addSubview(newsLabel)
        
        UIView.animate(withDuration: 10.0, delay: 0.0, options: [.repeat], animations: { () -> Void in
            self.newsLabel.frame = CGRect(x:-320, y:100, width:400, height:60)
        }, completion: { (finished: Bool) -> Void in
            self.newsLabel.frame = CGRect(x:320, y:100, width:400, height:60)
        });*/
        
        configureDatabase()
        configureStorage()
        configureRemoteConfig()
        fetchConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    @IBAction func vishalDetails_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "PlayerDetailsScene", sender: nil)

    }

    @IBAction func rohitButton_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "RohitScene", sender: nil)

    }
    @IBAction func vishal_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "VishalScene", sender: nil)

    }
    
    @IBAction func totoTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "TotoScene", sender: nil)

    }
    
    @IBAction func liveChat_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "LiveChatScene", sender: nil)

    }
    @IBAction func latestNewsButton_TouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "LatestNewsScene", sender: nil)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Vicky.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue cell
        let cell = self.tableView .dequeueReusableCell(withIdentifier: "mvpCell", for: indexPath)
        // Unpack message from Firebase DataSnapshot
        let messageSnapshot: FIRDataSnapshot! = self.Vicky[indexPath.row]
        let message = messageSnapshot.value as! Dictionary<String, String>
        let name = message[Constants.MessageFields.name] as String!
        let text = message[Constants.MessageFields.text] as String!
        cell.textLabel?.text = name! + ": " + text!
        cell.imageView?.image = UIImage(named: "ic_account_circle")
        if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL), let data = try? Data(contentsOf: URL) {
            cell.imageView?.image = UIImage(data: data)
        }
        return cell
    }
    
    deinit {
        self.ref.child("BestPlayer").removeObserver(withHandle: _refHandle)
        
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        // Listen for new messages in the Firebase database
        _refHandle = self.ref.child("BestPlayer").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.Vicky.append(snapshot)
            strongSelf.tableView.insertRows(at: [IndexPath(row: strongSelf.Vicky.count-1, section: 0)], with: .automatic)
        })
    }
    
    func configureStorage() {
    }
    
    func configureRemoteConfig() {
    }
    
    func fetchConfig() {
    }

}
