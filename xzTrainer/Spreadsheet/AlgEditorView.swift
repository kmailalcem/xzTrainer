//
//  AlgEditorView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 1/6/19.
//  Copyright © 2019 Xuzhi Zhang. All rights reserved.
//

import UIKit

class AlgEditorView: UIView {
    @IBOutlet weak var contentView: UIView?
    
    weak var managedTextField: UITextField! {
        didSet {
            managedTextField.text = ""
        }
    }
    
    var entriesEntered: [String] = [] {
        didSet {
            managedTextField.text = entriesEntered.reduce("") { $0 + " " + $1 }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("AlgEditor", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = bounds
        addSubview(content)
        setupButtons()
    }
    
    private func setupButtons() {
        setupButtonsRecursive(subviews)
    }
    
    private func setupButtonsRecursive(_ views: [UIView]) {
        for view in views {
            let button = view as? UIButton
            if button != nil && button!.actions(forTarget: self, forControlEvent: .touchUpInside) == nil {
                button!.addTarget(self, action: #selector(AlgEditorView.handleButton), for: .touchUpInside)
            }
            if view.subviews.count != 0 {
                setupButtonsRecursive(view.subviews)
            }
        }
    }
    
    @IBAction func clearEntry() {
        entriesEntered.removeAll()
    }
    
    @IBAction func finishEntry() {
        // notify the owner of managedTextField that the user has finished editing
        managedTextField.delegate?.textFieldDidEndEditing?(managedTextField)
    }
    
    @IBAction func backspace() {
        entriesEntered.remove(at: entriesEntered.count - 1)
    }
    
    @objc private func handleButton(sender: UIButton) {
        entriesEntered.append(sender.titleLabel!.text!)
    }
}
