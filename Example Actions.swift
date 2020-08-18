//
//  Example Actions.swift
//  App
//
//  Created by Ferhan Akkan on 17.08.2020.

//Database islemleri
//modeli direk tabloya kaydeder
//router.post(UserExampleDBModel.self, at: "userModel") { req, userModel -> Future<UserExampleDBModel> in
//    return userModel.save(on: req)
//}
//
//// Parametreye gore tablodan silme
//router.delete("userModel", UserExampleDBModel.parameter) { req -> Future<UserExampleDBModel> in
//    try req.parameters.next(UserExampleDBModel.self).delete(on: req)
//}
//
////o modele ait butun tabloyu getirir
//router.get("userModelAll") { req -> Future<[UserExampleDBModel]> in
//    return UserExampleDBModel.query(on: req).all()
//}
//
//// id ile tablodan cagirma
////Sql modeli inherit ediypr diye idsini direk algiliyor
//router.get("userGetById",UserExampleDBModel.parameter) { req -> Future<UserExampleDBModel> in
//    return try req.parameters.next(UserExampleDBModel.self)
//}
//
//// Parametreye gore tablodan filtre ile veri al
//router.get("getFilteredUserByName",String.parameter) { req -> Future<[UserExampleDBModel]> in
//    let name = try req.parameters.next(String.self).lowercased()
//    return UserExampleDBModel.query(on: req).filter(\.name == name).all()
//}


// map vs Flat map
//map ve flat'te future araciligi ile async calisir.
// map func icerisinden future donemez eger ki iceride future donen bi type cagirlmasi gerekirse o zaman flatmap kullanilmasi gerekmektedir.

//    router.get() { req -> Future<[PostExample]> in
//        return Future.map(on: req) { () -> [PostExample] in
//            let post = PostExample(name: "fer", surname: "ak")
//            var array: [PostExample] = []
//            array.append(post)
//            array.append(post)
//            return array
//        }
//    }
//
//    router.post(PostExample.self, at: "/postExampleEndPoint") { req, data -> Future<PostExample> in
//        return Future.flatMap(on: req) { () -> Future<PostExample> in
//            return Future.map(on: req) { () -> PostExample in
//                return PostExample(name: "fer", surname: "ak")
//            }
//        }
//    }


//// Future donecek olan responseun async olarak donmesini saglamaktadir.
//
//    router.post(PostExample.self, at: "/postExampleEndPoint") { req, data -> Future<PostExample> in
//        return Future.map(on: req) { () -> PostExample in
//            data.id = UUID()
//            return data
//        }
//    }
//
//    final class PostExample: Content {
//        var id: UUID?
//        var name: String
//        var surname: String
//        var family: [Family]?
//    }
//
//    final class Family: Content {
//        var motherName: String
//        var fatherName: String
//        var brotherName: String
//    }

///  Json Response Example
    
//    struct JsonExampleClass: Content {
//        var name: String
//        var surname: String
//        var age: Int
//    }
//
//    router.get("jsonTest") { req -> JsonExampleClass in
//        let name = try req.query.get(String.self, at: "name")
//        let surname = try req.query.get(String.self, at: "surname")
//        let age = try req.query.get(Int.self, at: "age")
//
//        let json = JsonExampleClass(name: name, surname: surname, age: age)
//        return json
//    }
    
    
/// Query String
////  /queryTest?name=Param&surname=Param2
//    router.get("queryTest") { req -> String in
//        let name = try req.query.get(String.self, at: "name")
//        let surname = try req.query.get(String.self, at: "surname")
//        return "name = \(name) surname \(surname)"
//    }
//
/// Parameters
//
//    router.get("ad",String.parameter,"dogum",Int.parameter,"ikinciString", String.parameter) { req -> String in
//        let param = try req.parameters.next(String.self)
//        let paramYil = try req.parameters.next(Int.self)
//        let paramString = try req.parameters.next(String.self)
//        return "gonderilen ad \(param), yil \(paramYil), ikinci string \(paramString)"
//    }
    
/// Group Example
//    let familyGroup = router.grouped("family/akkan/")
//    familyGroup.get("ferhan") { _ in
//        return "ferhan"
//    }
//
//    familyGroup.get() { _ in
//        return "salih"
//    }
    
    
////  Multiable usage is same
//    router.get("ferhan/akkan") { _ in
//        return "Ferhan Akkan"
//    }
//    router.get("ferhan", "akkan") { _ in
//        return "Ferhan Akkan"
//    }
    
//    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter,  use: todoController.delete)
