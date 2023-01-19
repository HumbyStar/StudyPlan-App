//
//  StudyPlanTableViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import UIKit
import UserNotifications

class StudyPlanTableViewController: UITableViewController {
    let ud = UserDefaults.standard
    let sm = StudyManager.shared

    let center = UNUserNotificationCenter.current()
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy HH:mm"
        return formatter
    }()
    
    lazy var lbText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .orange
        label.numberOfLines = 2
        return label
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        getNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(getNotification), name: NSNotification.Name("Refresh"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceived(notification:)), name: NSNotification.Name("Confirmed"), object: nil)
        prepareView()
    }
    
    @objc func getNotification() {
        center.delegate = self
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                
                //MARK: Só vai configurar a notificação se tiver authorization
                print("Estamos dentro de NotDetermined")
                
                let options: UNAuthorizationOptions = [.alert,.badge,.carPlay,.sound]
                self.center.requestAuthorization(options: options) { success, error in
                    if error == nil {
                        print("A primeira resposta do usuario ao pedir a notificação foi: \(success)")
                    } else {
                        print(error?.localizedDescription)
                    }
                }
            } else if settings.authorizationStatus == .denied {
                print("Estamos dentro de Denied")
                DispatchQueue.main.async {
                    self.warningAuthorization()
                }
            } else if settings.authorizationStatus == .authorized {
                print ("Estamos dentro de Authorized")//Agora preciso passar esse valor para a var da table
            }
        }
        let confirmAction = UNNotificationAction(identifier: "Confirmar", title: "Ja estudei 👍🏻", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancelar", title: "Deixar pra depois 👎🏻")
        let category = UNNotificationCategory(identifier:"Lembrete", actions: [confirmAction, cancelAction], intentIdentifiers: [], options: .customDismissAction)
        center.setNotificationCategories([category])
    }
    
    @objc func warningAuthorization() {
        
        let alert = UIAlertController(title: "Erro", message: "O app precisa da permissão para exibir as notificações", preferredStyle: .alert  )
            let okAction = UIAlertAction(title: "Dar permissão", style: .default) { _ in
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    NotificationCenter.default.post(name: NSNotification.Name("Change"), object: nil)
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "Não dar permissão", style: .default)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
    }
    
    
    
    
    @objc func onReceived(notification: Notification) {
        if let userInfo = notification.userInfo, let id = userInfo["id"] as? String { // ID recebido de SceneDelegate
            sm.setDonePlan(id: id)
            tableView.reloadData()
        }
    }
    
    func prepareView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        title = "Planos de Estudo"
        let btPlus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(push))
        navigationItem.rightBarButtonItem = btPlus
    }
    
    @objc func push() {
        navigationController?.pushViewController(StudyPlanViewController(), animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sm.studyPlan.count == 0 {
            lbText.text = "Voce não possui nenhum \n estudo programado"
            tableView.backgroundView = lbText
        } else {
            lbText.text = nil
        }
        
        return sm.studyPlan.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        }
        
        guard let cell = cell else {return UITableViewCell()}

        let studyPlan = sm.studyPlan[indexPath.row]
        cell.backgroundColor = .clear
        
        //MARK: preciso mudar o tipo que to mostrando a celula para funcionar o detailTextLabel
        cell.textLabel?.textColor = .orange
        cell.textLabel?.text = studyPlan.section
        cell.detailTextLabel?.textColor = .black
        cell.detailTextLabel?.text = dateFormatter.string(from: studyPlan.date)
        cell.backgroundColor = studyPlan.done ? .green : .white

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sm.removePlan(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension StudyPlanTableViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let id = response.notification.request.identifier
        print(id)
        
        switch response.actionIdentifier {
        case "Confirmar":
            print("Confirmado")
            NotificationCenter.default.post(name: NSNotification.Name("Confirmed"), object: nil, userInfo: ["id":id])
        case "Cancelar":
            print("Cancelado")
        case UNNotificationDefaultActionIdentifier:
            print("Usuario tocou na notificação")
        case UNNotificationDismissActionIdentifier:
            print("Usuário deu dismiss na notificacao")
        default:
            break
        }
    }
}





