import Foundation
import SwiftUI

enum FirebaseError: Error {
    case noAuthDataResult
    case noCurrentUser
    case noDocumentSnapshot
    case noQuerySnapshot
    case noSnapshotData
    case noUser
}

extension FirebaseError: LocalizedError {
    // This will provide a specific localized description for the FireStoreError
    var errorDescription: String? {
        switch self {
        case .noAuthDataResult:
            return NSLocalizedString("No Auth Data Result", comment: "")
        case .noCurrentUser:
            return NSLocalizedString("No Current User", comment: "")
        case .noDocumentSnapshot:
            return NSLocalizedString("No Document Snapshot", comment: "")
        case .noQuerySnapshot:
            return NSLocalizedString("No Query Snapshot", comment: "")
        case .noSnapshotData:
            return NSLocalizedString("No Snapshot Data", comment: "")
        case .noUser:
            return NSLocalizedString("No User", comment: "")
        }
    }
}


//
//// Signin email errors
//enum EmailAuthError: Error {
//    case incorrectPassword
//    case invalidEmail
//    case accoundDoesNotExist
//    case unknownError
//    case couldNotCreate
//    case extraDataNotCreated
//}
//
//extension EmailAuthError: LocalizedError {
//    // This will provide a specific localized description for the EmailAuthError
//    var errorDescription: String? {
//        switch self {
//        case .incorrectPassword:
//            return NSLocalizedString("Incorrect Password for this account", comment: "")
//            
//        case .invalidEmail:
//             return NSLocalizedString("Not a valid email address.", comment: "")
//            
//        case .accoundDoesNotExist:
//            return NSLocalizedString("No matching email in our database. Please check that you have entered your email correctly", comment: "")
//            
//        case .unknownError:
//            return NSLocalizedString("Unknown error. Cannot log in.", comment: "")
//            
//        case .couldNotCreate:
//            return NSLocalizedString("Could not create user at this time.", comment: "")
//            
//        case .extraDataNotCreated:
//            return NSLocalizedString("Could not save user's full name.", comment: "")
//        }
//    }
//}
