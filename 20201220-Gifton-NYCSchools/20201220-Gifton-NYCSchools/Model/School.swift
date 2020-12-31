
import Foundation

// MARK: - School
struct School: Codable {
    let dbn, schoolName, overviewParagraph, neighborhood: String
    let location, phoneNumber, schoolEmail, website: String
    let finalgrades, totalStudents, extracurricularActivities, schoolSports: String
    let attendanceRate, primaryAddressLine1, city: String

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case neighborhood, location
        case phoneNumber = "phone_number"
        case schoolEmail = "school_email"
        case website, finalgrades
        case totalStudents = "total_students"
        case extracurricularActivities = "extracurricular_activities"
        case schoolSports = "school_sports"
        case attendanceRate = "attendance_rate"
        case primaryAddressLine1 = "primary_address_line_1"
        case city
        case testScores
    }
    
    private(set) var testScores: TestScores?
    
    public mutating func setScores(_ scores: TestScores) {
        testScores = scores
    }
}

// MARK: School convenience initializers and mutators

extension School {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(School.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}


typealias Schools = [School]

extension Array where Element == Schools.Element {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Schools.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
