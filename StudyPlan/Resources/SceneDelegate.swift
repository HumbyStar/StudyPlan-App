//
//  SceneDelegate.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 16/01/23.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var center = UNUserNotificationCenter.current()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: StudyPlanTableViewController())
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        center.delegate = self
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                let options: UNAuthorizationOptions = [.alert,.badge,.carPlay,.sound]
                self.center.requestAuthorization(options: options) { success, error in
                    if error == nil {
                        print(success)
                    } else {
                        print(error?.localizedDescription)
                    }
                }
                
            } else if settings.authorizationStatus == .denied {
                print("Usuário não autorizou o app a realizar notificações")
            }
        }
        
        let confirmAction = UNNotificationAction(identifier: "Confirmar", title: "Ja estudei 👍🏻", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancelar", title: "Deixar pra depois 👎🏻")
        let category = UNNotificationCategory(identifier:"Lembrete", actions: [confirmAction, cancelAction], intentIdentifiers: [], options: .customDismissAction)
        center.setNotificationCategories([category])
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate: UNUserNotificationCenterDelegate {
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

