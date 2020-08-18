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
        
        // getler query degilse direk link sonuna koy
        
        let userRoutes = router.grouped("user")
        userRoutes.get(use: getAll) // calisiyi
        userRoutes.post(UserExampleDBModel.self, at: "/", use: postUser) // calisiyi
        userRoutes.get("nameFilterQuery", use: getFilteredQuery) // calisti
        userRoutes.get("nameFilter", String.parameter, use: getFilteredLink) // calisti direk linke yaz /nameFilter/akkaniOS
        userRoutes.delete(UserExampleDBModel.parameter, use: deleteSelected)
        //user/C41A7709-FADC-4F43-8F69-2A37A83B648A
        
        userRoutes.get(UserExampleDBModel.parameter, use: getById)
        //user/C41A7709-FADC-4F43-8F69-2A37A83B648A
        
        
    }
    
    func getById(req:Request) throws -> Future<UserExampleDBModel> {
        return try req.parameters.next(UserExampleDBModel.self)
    }
    
    func deleteSelected(req: Request) throws -> Future<UserExampleDBModel> {
        // direk link uzerinden elte ettigi id nin bu objenin idsi oldugunu anlar ve siler /user/dsafafa uzerinden.
        return try req.parameters.next(UserExampleDBModel.self).delete(on: req)
    }
    
    func getFilteredLink(req: Request) throws -> Future<[UserExampleDBModel]> {
        let surname = try req.parameters.next(String.self)
        return UserExampleDBModel.query(on: req).filter(\.surname == surname).all()
    }
    
    func getFilteredQuery(req: Request) throws -> Future<[UserExampleDBModel]> {
        let name = try req.query.get(String.self, at: "name")
        return UserExampleDBModel.query(on: req).filter(\.name == name).all()
    }
    
    func postUser(req:Request, user: UserExampleDBModel) throws -> Future<UserExampleDBModel> {
        return user.save(on: req)
    }
    
    func getAll(req: Request) -> Future<[UserExampleDBModel]> {
        return UserExampleDBModel.query(on: req).all()
    }
    
    


}
