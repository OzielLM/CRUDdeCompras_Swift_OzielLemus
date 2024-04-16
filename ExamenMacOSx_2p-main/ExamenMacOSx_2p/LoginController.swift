//
//  LoginController.swift
//  ExamenMacOSx_2p
//
//  Created by Braulio Alejandro Navarrete Horta on 13/05/23.
//

import Foundation

class LoginController{
    @objc dynamic var users:[User] = []
    static var compartir: LoginController = {
        let instance = LoginController()
        return instance
    }()
    
    func addUser(_ user:User){
        users.append(user)
    }
    
    func login(username:String, password:String) -> Bool {
        for user in users {
            if user.username == username && user.password == password{
                return true
            }
        }
        return false
    }
}
