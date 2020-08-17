import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    router.get() { _ in 
        return "Ferhan Api Test"
    }
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter,  use: todoController.delete)
}
