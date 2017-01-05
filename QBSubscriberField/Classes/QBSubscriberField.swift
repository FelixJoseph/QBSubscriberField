//
//  QBSubscriberField.swift
//  Pods
//
//  Created by Felix Joseph on 06/12/16.
//
//

import UIKit

private enum Constant {
    static let fontsize: CGFloat = 14
    static let defaultOffset = 10
    static let defaultDuration = 0.5
    static let semiTransparentAlpha: CGFloat = 0.5
    static let defaultDelay = 0.3
    static let emailPlaceholderString = "  Email Address"
    static let checkEmailString = "THANKS! CHECK YOUR EMAIL."
    static let failedResponseString = "FAILED! PLEASE TRY AGAIN."
    static let buttonTitle = "Ok"
    static let Zero: CGFloat = 0
    static let One: CGFloat = 1
    static let defaultHeight: CGFloat = 40
    static let defaultScalingFactor: CGFloat = 0.60
    static let defaultCornerRadius: CGFloat = 5
}

public enum Result {
    case success
    case failure
}

public protocol SubscriberFieldDelegate: class {
    func didFinishTask(sender: String, field: QBSubscriberField)
}

public class QBSubscriberField: UITextField, UITextFieldDelegate {

    var label = UILabel()
    let button = UIButton()
    var buttonCompletionString = Constant.checkEmailString
    var sucessfullySubscribed = true
    var isFloatingLabelActive: Bool = false
    @IBInspectable open var textFieldBackgroundColor: UIColor
        = #colorLiteral(red: 0.02352941176, green: 0.3607843137, blue: 0.7176470588, alpha: 1)
    @IBInspectable open var buttonBackgroundColor: UIColor
        = #colorLiteral(red: 0.5960784314, green: 0.7254901961, blue: 0.8588235294, alpha: 1)
    @IBInspectable open var errorColor: UIColor
        = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    public var callbackDelegate: SubscriberFieldDelegate?

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialiseSubscribeField()
    }

    required override public init(frame: CGRect) {

        super.init(frame: frame)
        self.initialiseSubscribeField()
    }

    override public func prepareForInterfaceBuilder() {

        super.prepareForInterfaceBuilder()
        self.initialiseSubscribeField()
    }

    func initialiseSubscribeField() {

        //Set the properties of Text field.
        self.font = UIFont.systemFont(ofSize: Constant.fontsize)
        var frameRect: CGRect = self.frame
        frameRect.size.height = Constant.defaultHeight
        self.frame = frameRect
        self.layer.cornerRadius = Constant.defaultCornerRadius
        self.autocorrectionType = UITextAutocorrectionType.no
        self.keyboardType = UIKeyboardType.default
        self.addTarget(self, action: #selector(self.textFieldDidChange(textField:)),
                       for: UIControlEvents.editingChanged)
        //Initialize and set the properties of the floating label.
        label = UILabel(frame: CGRect(x: Constant.Zero, y: Constant.Zero,
                                      width: (self.bounds.width), height: (self.bounds.height)))
        label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        label.font = UIFont.systemFont(ofSize: Constant.fontsize)
        label.backgroundColor = UIColor.clear
        label.textColor = self.textColor
        label.text = Constant.emailPlaceholderString
        self.addSubview(label)
    }

    func buttonAction(sender: UIButton!) {

        if !sucessfullySubscribed {
            UIView.animate(withDuration: Constant.defaultDuration, delay: Constant.defaultDelay,
                           options: .curveEaseInOut, animations: {

                //Make the size of button same as text field size.
                self.button.frame = (frame: CGRect(x: (self.frame.size.width)
                    - Constant.defaultHeight, y: Constant.Zero, width: Constant.defaultHeight,
                                              height: self.bounds.height))
                self.button.backgroundColor = self.buttonBackgroundColor
                self.buttonCompletionString = Constant.buttonTitle
                }, completion: nil )

            UIView.animate(withDuration: Constant.defaultDelay, delay: Constant.defaultDelay,
                           options: .curveEaseInOut, animations: {
                //Change the text of button.
                self.button.titleLabel?.alpha = Constant.Zero
                }, completion: {(value: Bool) in

                    self.button.titleLabel?.alpha = Constant.One
                    self.button.setTitle(self.buttonCompletionString, for: .normal)
            })
            sucessfullySubscribed = true
        } else {
            callbackDelegate?.didFinishTask(sender: self.text!,
                                            field: self)
            UIView.animate(withDuration: Constant.defaultDuration, delay: Constant.defaultDelay,
                           options: .curveEaseInOut, animations: {

                //Make the size of button same as text field size.
                self.button.frame = (frame: CGRect(x: Constant.Zero, y: Constant.Zero,
                                    width: self.bounds.width, height: self.bounds.height))
                if !self.sucessfullySubscribed {
                    self.button.backgroundColor = self.errorColor
                    self.buttonCompletionString = Constant.failedResponseString
                } else {
                    self.button.backgroundColor = self.buttonBackgroundColor
                    self.buttonCompletionString = Constant.checkEmailString
                    self.button.isEnabled = false
                }
                }, completion: nil )

            UIView.animate(withDuration: Constant.defaultDelay, delay: Constant.defaultDelay,
                           options: .curveEaseInOut, animations: {
                //Change the text of button.
                self.button.titleLabel?.alpha = Constant.Zero
                }, completion: {(value: Bool) in

                    self.button.titleLabel?.alpha = Constant.One
                    self.button.setTitle(self.buttonCompletionString, for: .normal)
            })
        }
    }

    override public func layoutSubviews() {

        super.layoutSubviews()
        if self.isFirstResponder && !isFloatingLabelActive {
            isFloatingLabelActive = true
            UIView.animate(withDuration: Constant.defaultDuration, delay: Constant.defaultDelay,
                           options: .curveEaseInOut, animations: {
                //On selecting the textfield. set the label as floating label.
                self.backgroundColor = self.textFieldBackgroundColor
                self.label.transform = self.label.transform.scaledBy(
                    x: Constant.defaultScalingFactor,
                    y: Constant.defaultScalingFactor)
                var labelFrame = self.label.frame
                labelFrame.origin = CGPoint(x: Constant.Zero, y: -Constant.defaultCornerRadius)
                self.label.frame = labelFrame
                self.label.alpha = Constant.semiTransparentAlpha
                }, completion: { (value: Bool) in
                    //Create the button and set as disabled.
                    self.button.frame = (frame: CGRect(
                        x: (self.frame.size.width) - Constant.defaultHeight,
                        y: Constant.Zero,
                        width: Constant.defaultHeight, height: self.bounds.height))
                    self.button.backgroundColor = self.buttonBackgroundColor
                    self.button.alpha = Constant.semiTransparentAlpha
                    self.button.layer.cornerRadius = Constant.defaultCornerRadius
                    self.button.titleLabel?.font = UIFont.systemFont(ofSize: Constant.fontsize)
                    self.button.setTitle(Constant.buttonTitle, for: .normal)
                    self.button.setTitleColor(self.textColor, for: UIControlState.normal)
                    self.button.titleLabel?.alpha = Constant.semiTransparentAlpha
                    self.button.isEnabled = false
                    self.button.addTarget(self, action: #selector(self.buttonAction),
                                          for: .touchUpInside)
                    self.addSubview(self.button)
            })
        }
    }

    func isValidEmail(testStr: String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

    @objc private func textFieldDidChange(textField: UITextField) {

        //On entering a valid email, enable the button.
        if isValidEmail(testStr: self.text!) {
            self.button.isEnabled = true
            self.button.setTitleColor(self.textColor, for: UIControlState.normal)
            self.button.titleLabel?.alpha = Constant.One
            self.button.backgroundColor = buttonBackgroundColor
            self.button.alpha = Constant.One
        } else {
            self.button.isEnabled = false
            self.button.backgroundColor = buttonBackgroundColor
            self.button.alpha = Constant.semiTransparentAlpha
            self.button.setTitleColor(self.textColor, for: UIControlState.normal)
            self.button.titleLabel?.alpha = Constant.semiTransparentAlpha
        }
    }

    public func completion(result: Result) {

        if result == .success {
            sucessfullySubscribed = true
        } else {
            sucessfullySubscribed = false
        }
    }

    //Function for changing the text area of the textfield.
    override public func textRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.insetBy(dx: CGFloat(Constant.defaultOffset),
                              dy: CGFloat(Constant.defaultOffset))
    }

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {

        return CGRect.init(x: bounds.origin.x + Constant.defaultCornerRadius,
                           y: bounds.origin.y + bounds.height/(Constant.defaultCornerRadius/2),
                           width: bounds.width, height: bounds.height)
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.insetBy(dx: CGFloat(Constant.defaultOffset),
                              dy: CGFloat(Constant.defaultCornerRadius*3))
    }
}
