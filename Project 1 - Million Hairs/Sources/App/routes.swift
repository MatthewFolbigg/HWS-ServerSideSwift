import Foundation
import Leaf
import Fluent
import Vapor

func routes(_ app: Application) throws {
    //MARK: - Home
    app.get { req -> EventLoopFuture<View> in
        let context = [String: String]()
        return req.view.render("home", context)
    }
    
    //MARK: - Staff
    app.get("staff", ":name") { req -> EventLoopFuture<View> in
        guard let name = req.parameters.get("name") else {
            throw Abort(.internalServerError)
        }
        
        struct StaffView: Codable {
            var name: String?
            var bio: String?
            var allNames: [String]
        }
        
        let leafContext: StaffView
        
        let bios = [
            "kirk": "My name is James Kirk and I love snakes.",
            "picard": "My name is Jean-Luc Picard and I'm mad for fish.",
            "sisko": "My name is Benjamin Sisko and I'm all about the budgies.",
            "janeway": "My name is Kathryn Janeway and I want to hug every hamster.",
            "archer": "My name is Jonathan Archer and beagles are my thing."
        ]
        
        if let bio = bios[name] {
            leafContext = StaffView(name: name, bio: bio, allNames: bios.keys.sorted())
        } else {
            leafContext = StaffView(allNames: bios.keys.sorted())
        }
        
        return req.view.render("staff", leafContext)
    }
    
    //MARK: - Contact
    app.get("contact") { req -> EventLoopFuture<View> in
        let context = ["": ""]
        return req.view.render("contact", context)
    }
    
    try app.register(collection: TodoController())
}
