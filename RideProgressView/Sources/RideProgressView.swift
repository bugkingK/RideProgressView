//
//  RideProgressView.swift
//  RideProgressView
//
//  Created by moon on 04/10/2019.
//  Copyright © 2019 Bugking. All rights reserved.
//

import UIKit

@IBDesignable
open class RideProgressView: UIView {
    
    private let trackView = UIView()
    private let barView = UIView()
    private let imgView = UIImageView()
    
    private lazy var trackViewWidthConstraint: NSLayoutConstraint =  { NSLayoutConstraint(item: self.trackView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0) }()
    
    @IBInspectable
    open var barColor: UIColor = .gray {
        didSet {
            barView.layer.backgroundColor = barColor.cgColor
        }
    }
    
    @IBInspectable
    open var barCornerRadius:CGFloat = 0 {
        didSet {
            barView.layer.cornerRadius = barCornerRadius
        }
    }
    
    @IBInspectable
    open var trackColor: UIColor = .green {
        didSet {
            trackView.layer.backgroundColor = trackColor.cgColor
        }
    }
    
    @IBInspectable
    open var trackCornerRadius:CGFloat = 0 {
        didSet {
            trackView.layer.cornerRadius = trackCornerRadius
        }
    }
    
    @IBInspectable
    open var maximumValue: Float = 100.0 {
        didSet {
            progress = { progress }()
        }
    }

    @IBInspectable
    open var minimumValue: Float = 0.0 {
        didSet {
            progress = { progress }()
        }
    }
    
    @IBInspectable
    open private(set) var progress: Float = 0 {
        didSet {
            if progress > maximumValue {
                progress = maximumValue
            } else if progress < minimumValue {
                progress = minimumValue
            }
            layoutSubviews()
        }
    }

    @IBInspectable
    open var barInset: CGFloat = 0 {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable
    open var rideImage: UIImage? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    open var animationDuration: TimeInterval = 0.25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.addSubview(barView)
        self.addSubview(trackView)
        self.addSubview(imgView)
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        trackView.translatesAutoresizingMaskIntoConstraints = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = rideImage
        imgView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: barView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: barView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .rightMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: barView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: barView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.3, constant: 0),
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: trackView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .leftMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: trackView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: trackView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.3, constant: 0),
            trackViewWidthConstraint
            ])
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: imgView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imgView, attribute: .bottom, relatedBy: .equal, toItem: trackView, attribute: .centerY, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imgView, attribute: .centerX, relatedBy: .equal, toItem: trackView, attribute: .trailing, multiplier: 1.0, constant: 0),
            NSLayoutConstraint(item: imgView, attribute: .width, relatedBy: .equal, toItem: imgView, attribute: .height, multiplier: 0.7, constant: 0),
            ])
        
        self.layoutMargins = .zero
    }
    
    open func setProgress(_ value: Float, animated: Bool) {
        self.progress = value
        
        if animated {
            UIView.animate(withDuration: animationDuration, animations: {
                self.layoutIfNeeded()
            })
        }
    }
    
    open func setProgress(_ value: Float, animated: Bool, completion:@escaping(_ isSuccess:Bool)->()) {
        self.progress = value
        
        if animated {
            UIView.animate(withDuration: animationDuration, animations: {
                self.layoutIfNeeded()
            }, completion: completion)
        }
    }
    
    open func refresh() {
        self.progress = 0
        self.layoutIfNeeded()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        let maxWidth: CGFloat = max(self.frame.width - barInset * 2, 0) // prevent from becoming negative
        let calculatedWidth: CGFloat = maximumValue - minimumValue != 0 ? CGFloat((progress - minimumValue) / (maximumValue - minimumValue)) * maxWidth : 0
        trackViewWidthConstraint.constant = calculatedWidth

        self.layoutMargins = UIEdgeInsets(top: barInset, left: barInset, bottom: barInset, right: barInset)
    }
}

