//
//  Theme.swift
//  xzTrainer
//
//  Created by Nelson Zhang on 8/19/18.
//  Copyright © 2018 Xuzhi Zhang. All rights reserved.
//

import UIKit

struct Theme {
    var name: String = LocalizationTheme.blueTheme.localized
    var key: String = "blueTheme"
    var backgroundColor: UIColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8745098039, alpha: 1)
    var lighterBackgroundColor: UIColor = #colorLiteral(red: 0.8980392157, green: 0.9137254902, blue: 0.937254902, alpha: 1)
    var darkerBackgroundColor: UIColor = #colorLiteral(red: 0.5725490196, green: 0.6509803922, blue: 0.7450980392, alpha: 1)
    var backgroundTintColor: UIColor = #colorLiteral(red: 0, green: 0.208977282, blue: 0.3710498214, alpha: 1)
    var invertedBackgroundColor = #colorLiteral(red: 0.1098039216, green: 0.3215686275, blue: 0.5176470588, alpha: 1)
    
    var normalTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    var darkerLightTextColor = #colorLiteral(red: 0.2823529412, green: 0.4196078431, blue: 0.568627451, alpha: 1)
    var lighterLightTextColor = #colorLiteral(red: 0.6376282573, green: 0.7111827731, blue: 0.7914314866, alpha: 1)
    var lightTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238)
    var invertedTexTColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var headerTextColor = #colorLiteral(red: 0, green: 0.1529411765, blue: 0.2980392157, alpha: 1)
    var timerColor = #colorLiteral(red: 0.1342299879, green: 0.4006600678, blue: 0.5895091891, alpha: 1)
    var warningTextColor = #colorLiteral(red: 0.6431372549, green: 0, blue: 0.2392156863, alpha: 1)
    
    var fabBackgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var fabTintColor = #colorLiteral(red: 0.1490196078, green: 0.4039215686, blue: 0.5803921569, alpha: 1)
    var fabHighlightedColor = #colorLiteral(red: 0.7843137255, green: 0.8274509804, blue: 0.8745098039, alpha: 1)
    var fabSelectedColor = #colorLiteral(red: 0.1342299879, green: 0.4006600678, blue: 0.5895091891, alpha: 1)
    
    var alertBackgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var shadowOpacity: Double {
        mutating get {
            if keyExists(Theme.shadowKey) {
                _shadowOpacity = UserDefaults.standard.double(forKey: Theme.shadowKey)
            }
            if _shadowOpacity == nil {
                return 0.25
            } else {
                return _shadowOpacity!
            }
        }
        set {
            _shadowOpacity = newValue
            UserDefaults.standard.set(newValue, forKey: Theme.shadowKey)
        }
    }
    
    private var _shadowOpacity: Double?
    static let themeKey = "themeKey"
    static let shadowKey = "shadowKey"
    static let defaultTheme = Theme()
    private static var _current: Theme?
    static var current: Theme {
        get {
            if (keyExists(themeKey)) {
                _current = allThemes[UserDefaults.standard.string(forKey: themeKey)!]!
            }
            if _current == nil {
                return defaultTheme
            } else {
                return _current!
            }
        }
        set {
            UserDefaults.standard.set(newValue.key, forKey: themeKey)
            _current = newValue
        }
    }
    static let whiteTheme = Theme(
        name: LocalizationTheme.whiteTheme.localized,
        key: "whiteTheme",
        backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        lighterBackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        darkerBackgroundColor: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1),
        backgroundTintColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        invertedBackgroundColor: #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1),
        
        normalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        darkerLightTextColor: #colorLiteral(red: 0.5058823529, green: 0.5058823529, blue: 0.5058823529, alpha: 1),
        lighterLightTextColor: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1),
        lightTextColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238),
        invertedTexTColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        headerTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        timerColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        warningTextColor: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),
        
        fabBackgroundColor: #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 1),
        fabTintColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        fabHighlightedColor: #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1),
        fabSelectedColor: #colorLiteral(red: 0.2352941176, green: 0.2352941176, blue: 0.2352941176, alpha: 1),
        
        alertBackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        _shadowOpacity: 0.25)
    
    static let pinkTheme = Theme(
        name: LocalizationTheme.pinkTheme.localized,
        key: "pinkTheme",
        backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        lighterBackgroundColor: #colorLiteral(red: 0.968627451, green: 0.9176470588, blue: 0.9176470588, alpha: 1),
        darkerBackgroundColor: #colorLiteral(red: 0.9294117647, green: 0.7921568627, blue: 0.7921568627, alpha: 1),
        
        backgroundTintColor: #colorLiteral(red: 0.8588235294, green: 0.2352941176, blue: 0.4745098039, alpha: 1),
        invertedBackgroundColor: #colorLiteral(red: 0.8392156863, green: 0.5843137255, blue: 0.5529411765, alpha: 1),
        
        normalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        darkerLightTextColor: #colorLiteral(red: 0.8392156863, green: 0.5843137255, blue: 0.5529411765, alpha: 1),
        lighterLightTextColor: #colorLiteral(red: 0.968627451, green: 0.9176470588, blue: 0.9176470588, alpha: 1),
        lightTextColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5263805651),
        invertedTexTColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        headerTextColor: #colorLiteral(red: 0.7137254902, green: 0, blue: 0.3137254902, alpha: 1),
        timerColor: #colorLiteral(red: 0.831372549, green: 0, blue: 0.3843137255, alpha: 1),
        warningTextColor: #colorLiteral(red: 0.5764705882, green: 0.1098039216, blue: 0.007843137255, alpha: 1),
        fabBackgroundColor: #colorLiteral(red: 1, green: 0.9607843137, blue: 0.9568627451, alpha: 1),
        fabTintColor: #colorLiteral(red: 0.8392156863, green: 0.5843137255, blue: 0.5529411765, alpha: 1),
        fabHighlightedColor: #colorLiteral(red: 0.8392156863, green: 0.5843137255, blue: 0.5529411765, alpha: 1),
        fabSelectedColor: #colorLiteral(red: 0.8, green: 0.3058823529, blue: 0.2235294118, alpha: 1),
        alertBackgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        _shadowOpacity: 0.25)
    
    static let winterTheme = Theme(
        name: LocalizationTheme.winterTheme.localized,
        key: "winterTheme",
        backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
        lighterBackgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
        darkerBackgroundColor: #colorLiteral(red: 0.7647058824, green: 0.8352941176, blue: 0.9058823529, alpha: 1),
        
        backgroundTintColor: #colorLiteral(red: 0.2980392157, green: 0.4470588235, blue: 0.7019607843, alpha: 1),
        invertedBackgroundColor: #colorLiteral(red: 0.3215686275, green: 0.4941176471, blue: 0.7529411765, alpha: 1),
        
        normalTextColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        darkerLightTextColor: #colorLiteral(red: 0.2274509804, green: 0.3176470588, blue: 0.5647058824, alpha: 1),
        lighterLightTextColor: #colorLiteral(red: 0.9019607843, green: 0.9333333333, blue: 0.9607843137, alpha: 1),
        lightTextColor: #colorLiteral(red: 0.9019607843, green: 0.9333333333, blue: 0.9607843137, alpha: 0.5263805651),
        invertedTexTColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        headerTextColor: #colorLiteral(red: 0.2274509804, green: 0.3176470588, blue: 0.5647058824, alpha: 1),
        timerColor: #colorLiteral(red: 0.1647058824, green: 0.2078431373, blue: 0.4509803922, alpha: 1),
        warningTextColor: #colorLiteral(red: 0.5058823529, green: 0.0862745098, blue: 0, alpha: 1),
        fabBackgroundColor: #colorLiteral(red: 0.9019607843, green: 0.9333333333, blue: 0.9607843137, alpha: 1),
        fabTintColor: #colorLiteral(red: 0.631372549, green: 0.7333333333, blue: 0.8392156863, alpha: 1),
        fabHighlightedColor: #colorLiteral(red: 0.4, green: 0.5607843137, blue: 0.7725490196, alpha: 1),
        fabSelectedColor: #colorLiteral(red: 0.2274509804, green: 0.3176470588, blue: 0.5647058824, alpha: 1),
        alertBackgroundColor: #colorLiteral(red: 0.7647058824, green: 0.8352941176, blue: 0.9058823529, alpha: 1),
        _shadowOpacity: 0.25)
    
    static let allThemes = [defaultTheme.key: defaultTheme, pinkTheme.key: pinkTheme, whiteTheme.key: whiteTheme, winterTheme.key : winterTheme]
}
