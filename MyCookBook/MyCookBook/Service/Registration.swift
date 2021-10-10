import Foundation

enum PasswordLine: Int {
    case veryWeak
    case weak
    case notVeryWeak
    case notVeryStrong
    case VeryStrong
}

class Registration {
    static var userName = "1"
    static let userPassword = "1"
    static let userEmail = "1"

    static let passWeak = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static let passNotVeryStrong = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    static let passNotVeryWeak = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    static let passVeryStrong = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"

    static func checkPassword(pass: String) -> PasswordLine {
        if NSPredicate(format: "SELF MATCHES %@", passVeryStrong).evaluate(with: pass) {
            return .VeryStrong
        } else if NSPredicate(format: "SELF MATCHES %@", passNotVeryStrong).evaluate(with: pass) {
            return .notVeryStrong
        } else if NSPredicate(format: "SELF MATCHES %@", passNotVeryWeak).evaluate(with: pass) {
            return .notVeryWeak
        } else if NSPredicate(format: "SELF MATCHES %@", passWeak).evaluate(with: pass) {
            return .weak
        } else {
            return .veryWeak
        }
    }
    
    static func checkEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        guard let textEmail = email else { return true }
        return emailPred.evaluate(with: textEmail)
    }
    static func checkName(_ name: String?) -> Bool {
        let nameRegEx = "[A-Za-z]+ [A-Za-z]{2,18}"
        guard let textName = name else { return true }
        return NSPredicate(format: "SELF MATCHES %@", nameRegEx).evaluate(with: textName)
    }

    

    static func checkEconPass(_ pas: String?, _ pasTwo: String?) -> Bool {
        guard let textPass = pas else { return true }
        guard let textPassTwo = pasTwo else { return true }
        return textPass == textPassTwo
    }
}

