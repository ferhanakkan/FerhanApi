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
    
    let userController = UserExampleController()
    try router.register(collection: userController)

}
