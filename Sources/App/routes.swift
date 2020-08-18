import Vapor
import FluentSQLite

struct PostExample: Content {
    var id: UUID?
    var name: String
    var surname: String
    var family: [Family]?
}

struct Family: Content {
    var motherName: String
    var fatherName: String
    var brotherName: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get() { _ in 
        return "Ferhan Api Test"
    }
    

    //modeli direk tabloya kaydeder
    router.post(UserExampleDBModel.self, at: "userModel") { req, userModel -> Future<UserExampleDBModel> in
        return userModel.save(on: req)
    }
    
    // Parametreye gore tablodan silme
    router.delete("userModel", UserExampleDBModel.parameter) { req -> Future<UserExampleDBModel> in
        try req.parameters.next(UserExampleDBModel.self).delete(on: req)
    }
    
    //o modele ait butun tabloyu getirir
    router.get("userModelAll") { req -> Future<[UserExampleDBModel]> in
        return UserExampleDBModel.query(on: req).all()
    }
    
    // id ile tablodan cagirma
    //Sql modeli inherit ediypr diye idsini direk algiliyor
    router.get("userGetById",UserExampleDBModel.parameter) { req -> Future<UserExampleDBModel> in
        return try req.parameters.next(UserExampleDBModel.self)
    }
    
    // Parametreye gore tablodan filtre ile veri al
    router.get("getFilteredUserByName",String.parameter) { req -> Future<[UserExampleDBModel]> in
        let name = try req.parameters.next(String.self).lowercased()
        return UserExampleDBModel.query(on: req).filter(\.name == name).all()
    }
    

}
