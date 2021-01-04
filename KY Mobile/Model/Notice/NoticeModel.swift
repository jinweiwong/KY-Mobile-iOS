import Foundation

struct Notice {
    var UUID: String
    var Title: String
    var Exco: String  // eg. Academic, Welfare, General
    var Body: String
    var TimeStamp: String // Epoch Time
    
    init() {
        self.UUID = Foundation.UUID().uuidString
        self.Title = ""
        self.Exco = ""
        self.Body = ""
        self.TimeStamp = ""
    }
    
    init(UUID: String, Title: String, Exco: String, Body: String, TimeStamp: String) {
        self.UUID = UUID
        self.Title = Title
        self.Exco = Exco
        self.Body = Body
        self.TimeStamp = TimeStamp
    }
    
    func noticeToDict() -> [String: Any] {
        return ["UUID": self.UUID,
                "Title": self.Title,
                "Exco": self.Exco,
                "Body": self.Body,
                "TimeStamp": self.TimeStamp]
    }
    
    func noticeWithRandomTimeStamp() -> Notice {
        return Notice(UUID: self.UUID,
                      Title: self.Title,
                      Exco: self.Exco,
                      Body: self.Body,
                      TimeStamp: "1597666032353")
    }
}
