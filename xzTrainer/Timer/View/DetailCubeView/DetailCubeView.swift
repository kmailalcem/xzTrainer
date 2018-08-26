//
//  DetailCubeView.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/21/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

class DetailCubeView: UIView {
    enum MemoDisplayMode {
        case none, hidden, shown
    }

    @IBOutlet weak var scrambleLabel: UILabel! 
    @IBOutlet weak var cubeView: CubeView!
    @IBOutlet weak var edgeMemoLabel: UILabel!
    @IBOutlet weak var cornerMemoLabel: UILabel!
    @IBOutlet weak var memoStack: UIStackView!
    
    @IBOutlet var contentView: UIView?
    var memoDisplayMode: MemoDisplayMode = .hidden {
        didSet {
            switch memoDisplayMode {
            case .none:
                memoStack.isHidden = true
                updateView()
            case .hidden:
                memoStack.isHidden = false
                updateView()
            case .shown:
                showMemo()
                
            }
        }
    }
    
    public func updateCube (withScramble scramble: String) {
        scrambleLabel.text = scramble
        let topColor = UserSetting.shared.general.topFaceColor
        let frontColor = UserSetting.shared.general.frontFaceColor
        if needsToScrambleInStandardOrientation {
            cubeView.cube = Cube(top: .WHITE, front: .GREEN, scramble: scramble)
        } else {
            cubeView.cube = Cube(top: topColor, front: frontColor, scramble: scramble)
        }
        cubeView.updateFaces()
    }
    
    var forceScrambleInStandardOrientation: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DetailCubeView", owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = bounds
        addSubview(content)
        cubeView.settingFrame()
    }
    
    
    private var needsToScrambleInStandardOrientation: Bool {
        return memoDisplayMode == .none || UserSetting.shared.encoder.scrambleInWCAOrientation || forceScrambleInStandardOrientation
    }
    
    private func updateView() {
        scrambleLabel.text = Scrambler.getRandomScrambleWithLength(from: 19, to: 22, withOrientationMangle: memoDisplayMode != .none)
        updateView(withScramble: scrambleLabel.text!)
    }
    
    private func updateView(withScramble: String) {
        updateCube(withScramble: scrambleLabel.text!)
        if memoDisplayMode == .none {
            self.cubeView.hideFacesExceptTop()
        } else {
            UIView.animate(withDuration: 0.8) {
                self.cubeView.hideFacesExceptTop()
            }
        }
        edgeMemoLabel.text = LocalizationGeneral.timerMessage1.localized
        cornerMemoLabel.text = LocalizationGeneral.timerMessage2.localized
    }
    
    private func showMemo() {
        cubeView.showAllFaces()
        let scrambleFilter: String
        if needsToScrambleInStandardOrientation {
            let helperCube = Cube(top: UserSetting.shared.general.topFaceColor, front: UserSetting.shared.general.frontFaceColor, scramble: "")
            scrambleFilter = toString(helperCube.rotate(top: .WHITE, front: .GREEN))
        } else {
            scrambleFilter = ""
        }
        
        let memorizer = CubePermutationEncoder(
            forScramble: scrambleFilter + scrambleLabel.text!)
        
        edgeMemoLabel.text = memorizer.formattedEdgeMemo
        cornerMemoLabel.text = memorizer.formattedCornerMemo
    }
}
