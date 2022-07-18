import Fluent
import Vapor
//
//struct PollController: RouteCollection {
//    func boot(routes: RoutesBuilder) throws {
//        let polls = routes.grouped("polls")
//        polls.get(use: index)
//        polls.post(use: create)
//        polls.group(":pollID") { poll in
//            poll.delete(use: delete)
//        }
//    }
//
//    func index(req: Request) async throws -> [Poll] {
//        try await Poll.query(on: req.db).all()
//    }
//
//    func create(req: Request) async throws -> Poll {
//        let poll = try req.content.decode(Poll.self)
//        try await poll.save(on: req.db)
//        return poll
//    }
//
//    func delete(req: Request) async throws -> HTTPStatus {
//        guard let poll = try await Poll.find(req.parameters.get("pollID"), on: req.db) else {
//            throw Abort(.notFound)
//        }
//        try await poll.delete(on: req.db)
//        return .noContent
//    }
//}
