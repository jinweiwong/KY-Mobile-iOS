import Foundation
import FirebaseFirestore
import FirebaseStorage

class FBCurrent {
    
    // Upload new event
    // Takes in boolean variables to see if the event has a Start and End time.
    static func uploadNewEvent(newEvent: NewEvent,
                               boolAllDay: Bool,
                               boolStart: Bool,
                               boolEnd: Bool,
                               completion: @escaping (Result<Bool, Error>) -> () ) {
        
        var _newEvent = newEvent.convertAllToString()
        
        if boolAllDay {
            _newEvent.StartTime = ""
            _newEvent.EndTime = ""
        }
        
        if !boolStart {
            _newEvent.StartDate = ""
            _newEvent.StartTime = ""
        }
        
        if !boolEnd {
            _newEvent.EndDate = ""
            _newEvent.EndTime = ""
        }
        
        // Document name is (TimeStamp)_(Title)
        let reference = Firestore
            .firestore()
            .collection("Events")
            .document("\(_newEvent.TimeStamp)_\(_newEvent.Title.replacingOccurrences(of: " ", with: ""))")
        
        reference.setData(_newEvent.eventToDict(), merge: true) { (error) in
            if error != nil {
                completion(.failure(error!))
                return
            }
            print("EventToDict: \(_newEvent.eventToDict())")
            completion(.success(true))
        }
    }
}
