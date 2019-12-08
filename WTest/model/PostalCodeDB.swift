import RealmSwift

class PostalCode: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var numCodPostal: String = ""
    @objc dynamic var extCodPostal: String = ""
    @objc dynamic var desigPostal: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
