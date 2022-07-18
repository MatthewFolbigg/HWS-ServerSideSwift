import Fluent

struct CreatePoll: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database
            .schema(Poll.schema)
            .id()
            .field("title", .string, .required)
            .field("option_1", .string)
            .field("option_2", .string)
            .field("votes_1", .int16)
            .field("votes_2", .int16)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database
            .schema(Poll.schema)
            .delete()
    }
}
