//
//  ModeSelectionVC.swift
//  xzTrainer
//
//  Created by Xuzhi Zhang on 6/30/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit
import StoreKit

func openUrl(_ urlString:String) {
    let url = URL(string: urlString)!
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
}

class ModeSelectionVC: ThemeViewController {
    private enum TimerMode { case casual, execution }
    
    private struct Mode {
        var name: String
        var image: UIImage
        var onSelect: () -> (Void)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        modeSelectionTable.delegate = self
        modeSelectionTable.dataSource = self
        
        themeSetUp()
        displayGreeting()
        layingConstraints()
        dismissProfile()
        NotificationCenter.default.addObserver(self, selector: #selector(self.themeSetUp), name: NSNotification.Name(rawValue: "ThemeUpdated"), object: nil)
    }
    
    @objc override func themeSetUp() {
        super.themeSetUp()
        DispatchQueue.main.async {
            self.greetingLabel.textColor = Theme.current.headerTextColor
            self.nameLabel.textColor = Theme.current.darkerLightTextColor
            self.profileView.backgroundColor = Theme.current.backgroundColor
            self.profileView.tintColor = Theme.current.backgroundTintColor
            self.upperPiece.backgroundColor = Theme.current.backgroundColor
            self.upperPiece.shadowOpacity = Float(Theme.current.shadowOpacity)
        }
    }

    private func displayGreeting() {
        let hour = NSCalendar.current.component(.hour, from: Date())
        switch(hour) {
        case 6...11:
            greetingLabel.text = LocalizationGeneral.morningGreeting.localized + ","
        case 12...18:
            greetingLabel.text = LocalizationGeneral.afternoonGreeting.localized + ","
        default:
            greetingLabel.text = LocalizationGeneral.eveningGreeting.localized + ","
        }
        
        nameLabel.text = UserSetting.shared.general.name + ".".localized()
        smallNameLabel.text = UserSetting.shared.general.name
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

    
    // MARK: - IBActions
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
    
    @IBAction func rateApp() {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        } else {
            let alert = makeConfirm(title: "Rate This App", message: "Thank you for giving us your feedback! You will be redirected to the App Store.") { (_) in
                openUrl("itms-apps://itunes.apple.com/app/id1421716263")
            }
            present(alert, animated: true)
        }
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TimerVC, let sender = sender as? TimerMode {
            if sender == .execution {
                destination.isCasual = false
                GlobalData.shared.currentMode = "execute"
            } else if sender == .casual {
                destination.isCasual = true
                GlobalData.shared.currentMode = "casual"
            }
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        nameLabel.text = UserSetting.shared.general.name + "."
        smallNameLabel.text = UserSetting.shared.general.name
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var upperPiece: RoundedView!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var dismissProfileButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var smallNameLabel: UILabel!
    @IBOutlet weak var modeSelectionTable: UITableView!
    
    // MARK: - Privates
    private var profileViewHiddenTrailingConstraint: NSLayoutConstraint?
    private var profileviewShownTrailingConstraint: NSLayoutConstraint?
    
    private var modes: [Mode] {
        return [
            Mode(name: LocalizableMode.executionTraining.localized, image: #imageLiteral(resourceName: "ExecutionBGImage"), onSelect: {
                self.performSegue(withIdentifier: "toTimer", sender: TimerMode.execution)
            }),
            Mode(name: LocalizableMode.casualBLD.localized, image: #imageLiteral(resourceName: "Casual"), onSelect: {
                self.performSegue(withIdentifier: "toTimer", sender: TimerMode.casual)
            }),
            Mode(name: "My Spreadsheets", image: #imageLiteral(resourceName: "MySpreadsheet"), onSelect: {
                print("coming soon")
            })
        ]
    }
}

extension ModeSelectionVC: UITableViewDelegate, UITableViewDataSource {
    
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
        modes[indexPath.row].onSelect()
    }
}
