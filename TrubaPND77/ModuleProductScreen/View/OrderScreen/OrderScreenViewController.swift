//
//  OrderScreeViewController.swift
//  TrubaPND77
//
//  Created by Serg on 07.09.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import UIKit
import MessageUI

class OrderScreenViewController: UIViewController {
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var productDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingLayout()
        customizingNavigation()
        addObserversForKeyBoard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func settingLayout() {
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        sendButton.layer.masksToBounds = true
        sendButton.layer.cornerRadius = 5
        
        warnLabel.alpha = 0
    }
    
    private func addObserversForKeyBoard() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func customizingNavigation() {
        let leftBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backButton"), style: .plain, target: self, action: #selector(backward))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.title = "Заказать звонок"
    }
    
    @objc func handleKeyboardNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo {
            
            guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue else {
                objectDescription(self, function: #function)
                return
            }
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            bottomConstraint.constant = isKeyboardShowing ? keyboardFrame.height + 10 : 30
            
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func backward() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func sendOrder(_ sender: UIButton) {
        guard let name = nameTextField.text,
            let phoneNumber = phoneTextField.text,
            name != "", phoneNumber != "" else {
            displayWarningLabel(withText: "Информация некорректна")
            return
        }
        
        sendEmail(with: name, and: phoneNumber)
        
    }
    
    private func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { [weak self] in
            guard let self = self else {
                print("OrderScreenViewController is deinitialized")
                return
            }
            self.warnLabel.alpha = 1
        }) { [weak self] complete in
            guard let self = self else {
                print("OrderScreenViewController is deinitialized")
                return
            }
            self.warnLabel.alpha = 0
        }
    }
    
    //MARK: for info when user not reg in app "Mail"
    private func showInfoAlert(description: String) {
        settingAlert(title: "Информация", message: description)
    }
    
    private func settingAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension OrderScreenViewController: MFMailComposeViewControllerDelegate {
    private func sendEmail(with name: String, and phone: String) {
        let body = "Имя: \(name), т. \(phone), товар: \(productDescription)"
        let mailComposeViewController = configureMailComposer(with: body)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true)
        } else {
            showInfoAlert(description: "Убедитесь, что у вас есть учетная запись в приложении \"Почта\"")
        }
    }
    
    func configureMailComposer(with body: String) -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["neofun10@mail.ru"])
        mailComposeVC.setSubject("Заказать звонок")
        mailComposeVC.setMessageBody(body, isHTML: false)
        return mailComposeVC
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if result == .sent {
            controller.dismiss(animated: true) { [weak self] in
            guard let self = self else {
                print("OrderScreenViewController is deinitialized")
                return
            }
                self.perform(#selector(self.backward))
            }
            return
        } else if result == .failed {
            controller.dismiss(animated: true, completion: nil)
            showInfoAlert(description: unknownError)
            return
        }
        controller.dismiss(animated: true, completion: nil)
        
    }
}
