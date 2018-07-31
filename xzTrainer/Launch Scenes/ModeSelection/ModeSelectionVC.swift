//
//  ModeSelectionVC.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 6/30/18.
//  Copyright © 2018 Nelson Zhang. All rights reserved.
//

import UIKit

struct Mode {
    var name: String
    var image: UIImage
}

class ModeSelectionVC:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource
{
    
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var dismissProfileButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    private var profileViewHiddenTrailingConstraint: NSLayoutConstraint?
    private var profileviewShownTrailingConstraint: NSLayoutConstraint?
    
    
    
    var modes: [Mode] = [
        Mode(name: "Execution Trainer", image: #imageLiteral(resourceName: "ExecutionBGImage")),
        Mode(name: "Casual BLD", image: #imageLiteral(resourceName: "Casual")),
        Mode(name: "My Alg Sheet", image: #imageLiteral(resourceName: "MyAlgSheet"))
    ]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModeSelectionCell") as? ModeSelectionCell
        if cell == nil {
            return UITableViewCell()
        }
        cell!.modeLabel.text = modes[indexPath.row].name
        cell!.bgImage.image = modes[indexPath.row].image
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "toTimer", sender: 0)
        case 1:
            performSegue(withIdentifier: "toTimer", sender: 1)
        case 2:
            print("Not yet implemented!")
        default:
            print("invalid table row index reached")
        }
    }
    
   

    @IBOutlet weak var modeSelectionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modeSelectionTable.delegate = self
        modeSelectionTable.dataSource = self
        
        
        let hour = NSCalendar.current.component(.hour, from: Date())
        switch(hour) {
        case 6...11:
            greetingLabel.text = "Good morning,"
        case 12...18:
            greetingLabel.text = "Good afternoon,"
        default:
            greetingLabel.text = "Good evening,"
        }
        
        layingConstraints()
        dismissProfile()
        
    }

    private func layingConstraints() {
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let margin = view.layoutMarginsGuide
        profileView.trailingAnchor.constraint(equalTo: margin.trailingAnchor, constant: 100).isActive = true
        profileView.leadingAnchor.constraint(equalTo: margin.trailingAnchor, constant: -84).isActive = true
        
        
    }
    
    @IBAction func dismissProfile() {
        
        
        UIView.animate(withDuration: 0.2) {
            self.dismissProfileButton.alpha = 0
            self.profileView.transform = CGAffineTransform(translationX: self.profileView.frame.width, y: 0)
        }
        
        profileView.isHidden = true
    }
    
    @IBAction func showProfile() {
        UIView.animate(withDuration: 0.2) {
            self.dismissProfileButton.alpha = 1
            self.profileView.transform = .identity
        }
        profileView.isHidden = false
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? TimerVC, let sender = sender as? Int {
            if sender == 0 {
                destination.isCasual = false
                GlobalData.shared.currentMode = "execute"
            } else if sender == 1 {
                destination.isCasual = true
                GlobalData.shared.currentMode = "casual"
            }
        }
    }
    

}
