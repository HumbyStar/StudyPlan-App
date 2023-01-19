//
//  ViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
// MARK: AutoresizingMaskIntoContraints tem que marcar como FALSE

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController{
    
    let sm = StudyManager.shared

    var textField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Digite a Matéria", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.textColor = .black
        textfield.layer.masksToBounds = false
        textfield.layer.cornerRadius = 5
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    var secondTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.masksToBounds = false
        textfield.layer.cornerRadius = 5
        textfield.attributedPlaceholder = NSAttributedString(string: "Digite o Assunto", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textfield.textColor = .black
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    var textDatePicker: UILabel = {
        let textlabel = UILabel()
        textlabel.textColor = .orange
        textlabel.text = "Data de estudo"
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        return textlabel
    }()
    
    var dpDate: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .dateAndTime
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
        
    }()
    var btConfirm: UIButton = {
        let button = UIButton()
        button.setTitle("Cadastrar Aula", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCode()
        
    }
    
    @objc func schedule(sender: UIButton!) {
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: textField.text!, section: secondTextField.text!, date: dpDate.date, done: false, id: id)
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria \(studyPlan.course)"
        content.body = "Estudar \(studyPlan.section)"
        content.categoryIdentifier = "Lembrete"
        let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: dpDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request,withCompletionHandler: nil)
        sm.addPlan(studyPlan)
        navigationController?.popViewController(animated: true)
    }

}

extension StudyPlanViewController: ViewCode {
    func viewHierarquic() {
        view.addSubview(textField)
        view.addSubview(secondTextField)
        view.addSubview(textDatePicker)
        view.addSubview(dpDate)
        view.addSubview(btConfirm)
    }
    
    func setContrains() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            secondTextField.topAnchor.constraint(equalTo: textField.topAnchor, constant: 35),
            secondTextField.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            secondTextField.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            
            textDatePicker.topAnchor.constraint(equalTo: secondTextField.topAnchor, constant: 50),
            textDatePicker.leadingAnchor.constraint(equalTo: secondTextField.leadingAnchor),
            textDatePicker.trailingAnchor.constraint(equalTo: secondTextField.trailingAnchor),
            
            dpDate.topAnchor.constraint(equalTo: textDatePicker.topAnchor, constant: 30),
            dpDate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            
            btConfirm.topAnchor.constraint(equalTo: dpDate.bottomAnchor,constant: 100),
            btConfirm.trailingAnchor.constraint(equalTo:textDatePicker.trailingAnchor),
            btConfirm.leadingAnchor.constraint(equalTo: textDatePicker.leadingAnchor),
            btConfirm.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    func extraFeatures() {
        view.backgroundColor = .white
        title = "Cadastrar"
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        dpDate.minimumDate = Date()
        btConfirm.addTarget(self, action: #selector(schedule), for: .touchUpInside)
    }
}

extension StudyPlanViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    
}

