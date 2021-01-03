import Foundation

struct Notice: Identifiable {
    var id = UUID()
    var Title: String
    var Exco: String  // eg. Academic, Welfare, General
    var Body: String
    var TimeStamp: String // Epoch Time
    
    init() {
        self.Title = ""
        self.Exco = ""
        self.Body = ""
        self.TimeStamp = ""
    }
    
    init(Title: String, Exco: String, Body: String, TimeStamp: String) {
        self.Title = Title
        self.Exco = Exco
        self.Body = Body
        self.TimeStamp = TimeStamp
    }
    
    func noticeToDict() -> [String: Any] {
        return ["Title": self.Title,
                "Exco": self.Exco,
                "Body": self.Body,
                "TimeStamp": self.TimeStamp]
    }
    
    func noticeWithRandomTimeStamp() -> Notice {
            return Notice(Title: self.Title,
                          Exco: self.Exco,
                          Body: self.Body,
                          TimeStamp: "1597666032353")
        }
}
