import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    //MARK: - All Polls
    app.get("polls", "list") { req async throws -> [Poll] in
        try await Poll.query(on: req.db).all()
    }
    
    //MARK: - Poll for ID
    app.get("polls", "vote", ":uuid") { req async throws -> Poll in 
        guard
            let idString = req.parameters.get("uuid"),
            let pollId = UUID(uuidString: idString)
        else {
            throw Abort(.badRequest)
        }
        
        guard let poll = try await Poll.find(pollId, on: req.db) else {
            throw Abort(.notFound)
        }
        
        return poll
    }
    
    //MARK: - Create Poll
    app.post("polls", "create") { req async throws -> Poll in
        guard let newPoll = try? req.content.decode(Poll.self) else {
            throw Abort(.badRequest)
        }
        
        try await newPoll.create(on: req.db)
        return newPoll
    }
    
    //MARK: - Vote in Poll
    app.post("polls", "vote", ":uuid", ":option") { req async throws -> String in
        guard
            let pollIdString = req.parameters.get("uuid"),
            let pollId = UUID(uuidString: pollIdString)
        else {
            throw Abort(.badRequest)
        }
        
        guard
            let optionString = req.parameters.get("option"),
            let option = Int(optionString)
        else {
            throw Abort(.badRequest)
        }
        
        guard let poll = try await Poll.find(pollId, on: req.db) else {
            throw Abort(.notFound)
        }
        
        switch option {
        case 1: poll.votes1 += 1
        case 2: poll.votes2 += 1
        default: throw Abort(.badRequest)
        }
        
        do {
            try await poll.save(on: req.db)
        } catch {
            throw Abort(.internalServerError)
        }
        
        switch option {
        case 1: return "\(poll.title) updated to have \(poll.votes1) votes for option 1 (\(poll.option1)"
        case 2: return "\(poll.title) updated to have \(poll.votes2) votes for option 2 (\(poll.option2)"
        default: throw Abort(.badRequest)
        }
    }
    
    //MARK: - Delete ID
    app.post("polls", "delete", ":uuid") { req async throws -> String in
        guard
            let pollIdString = req.parameters.get("uuid"),
            let pollId = UUID(uuidString: pollIdString)
        else {
            throw Abort(.badRequest)
        }
        
        guard let poll = try await Poll.find(pollId, on: req.db) else {
            throw Abort(.notFound)
        }
        
        do {
            try await poll.delete(on: req.db)
        } catch {
            throw Abort(.internalServerError)
        }
        
        return "Deleted \(poll.title)"
    }
    
    //MARK: - Delete All
    app.post("polls", "delete", "all") { req async throws -> String in
        do {
            let polls = try await Poll.query(on: req.db).all()
            try await polls.delete(on: req.db)
        } catch {
            throw Abort(.internalServerError)
        }
        
        return "Deleted All"
    }

//    try app.register(collection: PollController())
}
