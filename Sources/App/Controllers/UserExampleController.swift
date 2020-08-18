//
//  UserExampleController.swift
//  App
//
//  Created by Ferhan Akkan on 18.08.2020.
//

import Foundation
import Vapor
import FluentSQLite

struct UserExampleController: RouteCollection {
    
    func boot(router: Router) throws {
        
        //        userRoutes.get("/", use: getAll) Hem / koyabilir yada adres eklemeden de kullanabilirsin. as =  userRoutes.get(use: getAll)
        
        let userRoutes = router.grouped("user")
        userRoutes.delete(UserExampleDBModel.parameter, use: deleteSelected)
        userRoutes.post(UserExampleDBModel.self, at: "/", use: postUser)
        userRoutes.get(use: getAll)
        userRoutes.get(UserExampleDBModel.parameter, use: getById)
        userRoutes.get("nameFilter",String.parameter, use: getFiltered)
    }
    
    func postUser(req:Request, user: UserExampleDBModel) throws -> Future<UserExampleDBModel> {
        return user.save(on: req)
    }
    
    func deleteSelected(req: Request) throws -> Future<UserExampleDBModel> {
        try req.parameters.next(UserExampleDBModel.self).delete(on: req)
    }
    
    func getAll(req: Request) -> Future<[UserExampleDBModel]> {
        return UserExampleDBModel.query(on: req).all()
    }
    
    
    func getById(req:Request) throws -> Future<UserExampleDBModel> {
        return try req.parameters.next(UserExampleDBModel.self)
    }

    func getFiltered(req: Request) throws -> Future<[UserExampleDBModel]> {
        let name = try req.parameters.next(String.self).lowercased()
        return UserExampleDBModel.query(on: req).filter(\.name == name).all()
    }

}
