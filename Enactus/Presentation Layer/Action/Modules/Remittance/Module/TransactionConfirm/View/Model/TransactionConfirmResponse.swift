struct TransactionConfirmResponse: Codable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}

struct TransactionReceiptResponse: Codable {
    var amount: Int
    var messageText: String
    var toUser: Int
    var fromUser: Int
    var updatedAt: String
    var createdAt: String
    var id: Int
    var status: Int
    
    enum CodingKeys: String, CodingKey {
        case amount
        case messageText = "message_text"
        case toUser = "to_user_id"
        case fromUser = "from_user_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
        case status
    }
}

