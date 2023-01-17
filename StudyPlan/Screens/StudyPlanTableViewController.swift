//
//  StudyPlanTableViewController.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import UIKit

class StudyPlanTableViewController: UITableViewController {
    
    let sm = StudyManager.shared
    
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
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onReceived(notification:)), name: NSNotification.Name("Confirmed"), object: nil)
        prepareView()
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
