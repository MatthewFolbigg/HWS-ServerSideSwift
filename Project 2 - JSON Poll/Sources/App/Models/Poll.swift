import Foundation
import Vapor
import Fluent
import FluentSQL


final class Poll: Content, Model {
    static let schema = "polls"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    @Field(key: "option_1")
    var option1: String
    @Field(key: "option_2")
    var option2: String
    @Field(key: "votes_1")
    var votes1: Int
    @Field(key: "votes_2")
    var votes2: Int
    
//    @Timestamp(key: "created_at", on: .create, format: .iso8601)
//    var createdAt: Date?
//    
//    @Timestamp(key: "updated_at", on: .update, format: .iso8601)
//    var updatedAt: Date?
    
    init() { }
    init(id: UUID, title: String, option1: String, option2: String, votes1: Int, votes2: Int) {
        self.id = id
        self.title = title
        self.option1 = option1
        self.option2 = option2
        self.votes1 = votes1
        self.votes2 = votes2
    }
}




//MARK: - Mockable
extension Poll {
    static var example = Poll(id: UUID(), title: "title", option1: "Option One", option2: "Option Two", votes1: 0, votes2: 0)
    
    static var examples: [Poll] {
        var array = Array<Poll>()
        for i in 1...20 {
            array.append(
                Poll(id: UUID(), title: "Poll \(i)", option1: "Option One (\(i))", option2: "Option Two (\(i))", votes1: 0, votes2: 0)
            )
        }
        return array
    }
}

