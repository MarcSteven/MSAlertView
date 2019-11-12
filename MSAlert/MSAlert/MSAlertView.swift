//
//  MSAlertView.swift
//  MSAlert
//
//  Created by Marc Zhao on 2017/11/12.
//  Copyright © 2017 - 2019 Marc Zhao. All rights reserved.
//

import Foundation

import UIKit

open class MSAlertView:UIView {
    
    //MARK: - Private properties
    private let wrapperView:UIView = {
        let view = UIView()
        view.cornerRadius = 10
        view.backgroundColor = UIColor(hexString: "#AA000000")
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // the icons of alert
    private let icon:UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let messageLabel:UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.alpha = 0.0
        self.isUserInteractionEnabled = false
        
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder) has not been implemented")
    }
}
//MARK: - set up wrapper constraints
fileprivate extension MSAlertView {
    func setupConstraintsToWrappedView() {
        self.addSubview(wrapperView)
        wrapperView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            wrapperView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            wrapperView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    func setupConstraintsForMessageLabel() {
        NSLayoutConstraint.activate([
            wrapperView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 2.2),
            messageLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            messageLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20),
        
        ])
    }
    func setupConstraintsBetweenMessageLabelAndIcon() {
        wrapperView.addSubview(icon)
        NSLayoutConstraint.activate([
            icon.widthAnchor.constraint(equalToConstant: 35),
            icon.heightAnchor.constraint(equalToConstant: 35),
            icon.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 20),
            icon.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -20),
            messageLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -20),
            messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / 3),
        ])
    }
}

public extension MSAlertView {
    static func show(message:String,
                     icon imageIcon:UIImage? = nil,
                     duration:TimeInterval = 1.0) {
        //get the instance of the window
        guard let window = UIApplication.shared.keyWindow else {
            fatalError("no access to UIApplication window")
        }
        //create the Alert instance
        let alert = MSAlertView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
        if let icon = imageIcon {
            alert.icon.image = icon
            alert.setupConstraintsBetweenMessageLabelAndIcon()
        }else {
            alert.setupConstraintsForMessageLabel()
        }
        alert.messageLabel.text = message
        // add alert to the main keywindow
        window.addSubview(alert)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
            alert.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, delay: duration, options: .curveEaseOut, animations: {
                alert.alpha = 0.0
                alert.frame.origin.y = alert.frame.origin.y + 50
            }, completion: { _ in
                
                alert.removeFromSuperview()
            })
        })
        
    }
    static func showSuccess(message:String,
                            duration:TimeInterval) {
        #warning("TODO")
        let image = UIImage(named: "", in: Bundle(for: MSAlertView.self), with: nil)
        show(message: message, icon: image, duration: duration)
    }
    #warning("TODO"):
    static func showError(message:String,
                          duration:TimeInterval) {
        let image = UIImage(named: "", in: Bundle(for: MSAlertView.self), with: nil)
        show(message: message, icon: image, duration: duration)
    }
}
