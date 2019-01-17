import UIKit
import Foundation
/*:
 ### ECE 564 HW1 assignment
 In this first assignment, you are going to create a base data model for storing information about the students, TAs and professors in ECE 564. You need to populate your data model with at least 3 records, but can add more.  You will also provide a search function ("whoIs") to search an array of those objects by first name and last name.
 I suggest you create a new class called `DukePerson` and have it subclass `Person`.  You also need to abide by 2 protocols:
 1. BlueDevil
 2. CustomStringConvertible
 
 I also suggest you try to follow good OO practices by containing any properties and methods that deal with `DukePerson` within the class definition.
 */
/*:
 In addition to the properties required by `Person`, `CustomStringConvertible` and `BlueDevil`, you need to include the following information about each person:
 * Their degree, if applicable
 * Up to 3 of their best programming languages as an array of `String`s (like `hobbies` that is in `BlueDevil`)
 */
/*:
 I suggest you create an array of `DukePerson` objects, and you **must** have at least 4 entries in your array for me to test:
 1. Yourself
 2. Me (my info is in the Class Handbook)
 3. The TAs (also in Class Handbook)
 */
/*:
 Your program must contain the following:
 - You must include 4 of the following - array, dictionary, set, class, function, closure expression, enum, struct
 - You must include 4 different types, such as string, character, int, double, bool, float
 - You must include 4 different control flows, such as for/in, while, repeat/while, if/else, switch/case
 - You must include 4 different operators from any of the various categories of assignment, arithmatic, comparison, nil coalescing, range, logical
 */
/*: 
 Base grade is a 45 but more points can be earned by adding additional functions besides whoIs (like additional search), extensive error checking, concise code, excellent OO practices, and/or excellent, unique algorithms
 */
/*:
 Below is an example of what the string output from `whoIs' should look like:
 
     Ric Telford is from Morrisville, NC and is a Professor. He is proficient in Swift, C and C++. When not in class, Ric enjoys Biking, Hiking and Golf.
 */

enum Gender {
    case Male
    case Female
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
}

enum DukeRole : String {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
}

protocol BlueDevil {
    var hobbies : [String] { get }
    var role : DukeRole { get }
}
//: ### START OF HOMEWORK 
//: Do not change anything above.
//: Put your code here:

//This enum are error types for me to throw exceptions
enum MyError: Error {
    case toMuchBestProgramming
    case noSuchRole
    case noValidHeight
}

/* This DukePerson class contains basic information for Duke people. It contains information
 * such as a person's name, role, degree and email adress. It also contains a description to
 * help user print all information inside a DukePerson. To initiate an instanse of a
 * DukePerson, you must provide first name, last name, best programming languages (no more
 * than 3) and hobbies of that person.
 */

class DukePerson : Person, BlueDevil, CustomStringConvertible{
    var hobbies: [String] = []
    
    var role: DukeRole
    
    var description: String {
        var res: String = ""
        res = res + "name: " + firstName + " " + lastName + "\n" + "where: " + whereFrom
        res = res + "\n" + "gender: " + (gender == Gender.Male ? "M" : "F")
        res = res + "\n" + "hobbies: " + hobbies.description + "\n" + "role: " + role.rawValue
        res = res + "\n" + "degree: " + degree + "\n" + "programming: " + bestProgrammingLanguages.description
        res = res + "\n" + "email: " + emailAddresses.description + "\n"
        res = res + "last name char: " + String(firstCharOfLastName) + "\n" + "height: " + String(height ?? 0)
        return res
    }
    
    var degree: String = ""
    
    var bestProgrammingLanguages: [String] = []
    
    var emailAddresses = Set<String>()
    
    var firstCharOfLastName: Character
    
    var height: Float?
    
    
    init(f firstName: String, l lastName: String, role: DukeRole, p programming: [String], h hobbies: [String]) throws{
        self.role = role
        firstCharOfLastName = lastName[lastName.startIndex]
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        guard programming.count <= 3 else {
            print("Best programming languages can not be more than 3")
            throw MyError.toMuchBestProgramming
        }
        self.bestProgrammingLanguages = programming
        self.hobbies = hobbies
        if(programming.count > 3) {
            
        }
    }
    
}


/* Professor is a special role of DukePerson. A professor can teach classes.
 * So I provided a map to represent the courses a professor teach. Use the
 * courseTeaching map like this [course number : course name]. An example is
 * ["ECE564" : "MOBILE APP DEVELOPMENT"]
 */
class Professor: DukePerson {
    var courseTeaching: [String: String] = [:]
}

/* Student is a special role of DukePerson. A student can take courses.
 * So I provided a map to represent the courses a student take. Use the
 * courseTaken map like this [course number : course name]. An example is
 * ["ECE564" : "MOBILE APP DEVELOPMENT"]. Use isTA to show if the student
 * is a TA
 */
class Student: DukePerson {
    var courseTaken: [String: String] = [:]
    var isTA: Bool = false
}


/* This is a ToolBox to provide some useful tools. Use sortByHeight function
 * to help sort a collection of DukePerson by their heights from tallest to
 * shortest. I also provide a basic calculator function for fun. This is just
 * a basic calculator, so please only input valid expressions. An expression
 * can contain '(', ')', '+', '-', ' ' and non-negative integers.This function
 * will calculate a final result of the expression. Use "1 + 1" will return 2
 */
class ToolBox {
    static func sortByHeight(_ s1: DukePerson, _ s2: DukePerson) throws -> Bool{
        guard(s1.height != nil && s2.height != nil) else {
            print("no valid height")
            throw MyError.noValidHeight
        }
        return s1.height! > s2.height!
    }
    
    static func calculate(_ str: String) -> Int {
        let stack = Stack<Int>()
        var res: Int = 0
        var num: Int = 0
        var sign: Int = 1
        var count: Int = 0
        while(count < str.count) {
            let idx = str.index(str.startIndex, offsetBy: count)
            let cur: Character = str[idx]
            switch cur {
            case "0"..."9":
                num = 10 * num + Int(String(cur))!
            case "+":
                num *= sign
                res += num
                sign = 1
                num = 0
            case "-":
                num *= sign
                res += num
                sign = -1
                num = 0
            case "(":
                stack.push(res)
                stack.push(sign)
                sign = 1
                res = 0
            case ")":
                num *= sign
                num = res + num
                sign = stack.pop()!
                res = stack.pop()!
            case " ":
                break
            default:
                print("invalid input")
                return 0
            }
            count += 1
        }
        res = res + sign * num
        return res
    }
}

/* This is a generic stack data structure.
 */
class Stack<Element> {
    var arr: [Element] = []
    var size: Int {
        return arr.count
    }
    
    var isEmpty: Bool {
        return arr.isEmpty
    }
    
    func push(_ obj: Element) {
        arr.append(obj)
    }
    
    func pop() -> Element? {
        return arr.popLast()
    }
    
    func peek() -> Element? {
        return arr.last
    }
    
}


/* I created 4 people for testing. And I put them into the 'personArray'.
 */
 var Ric = try Professor(f: "Ric", l: "Telford", role: DukeRole.Professor, p: ["Swift", "C", "C++"], h: ["Biking", "Hiking", "Golf"])
 var Walker = try Student(f: "Walker", l: "Eacho", role: DukeRole.TA, p: ["Swift", "Objective-C", "Javascript"], h: ["sailing", "climbing", "baking"])
 var Niral = try Student(f: "Niral", l: "Shah", role: DukeRole.TA, p: ["Swift", "Python", "Java"], h: ["Computer Vision projects", "Tennis", "Traveling"])
 var Yuanyuan = try Student(f: "Yuanyuan", l: "Yu", role: DukeRole.Student, p: ["Java", "C++", "C"], h: ["Baseball", "Fencing", "Golf", "Fishing"])

Ric.whereFrom = "Morrisville, NC"
Ric.degree = "Phd"
Walker.isTA = true
Walker.whereFrom = "Chevy Chase, Maryland"
Walker.degree = "BS"
Niral.isTA = true
Niral.whereFrom = "Central New Jersey"
Niral.degree = "MS"
Yuanyuan.gender = .Female
Yuanyuan.whereFrom = "China"
Yuanyuan.emailAddresses = ["yy194@duke.edu"]
Yuanyuan.courseTaken = ["ECE564":"IOS APP"]
Yuanyuan.degree = "MS"

var personArray : [DukePerson] = [Ric, Walker, Niral, Yuanyuan]
var count: Int = personArray.count


/* This is a helper function for printPerson function. The input should
 * be an array contains hobbies or programming languages of a DukePerson.
 * It will return a String to represent the corresponding array.
 */
func printArr(_ arr: [String]) -> String {
    let count = arr.count
    var result: String = ""
    if count == 1 {
        result = result + " " + arr[0] + "."
    } else {
        for pcount in 0..<count {
            if(pcount == count - 2) {
                result = result + " " + arr[pcount] + " and " + arr[pcount + 1] + "."
                break
            } else {
                result = result +  " " + arr[pcount] + ","
            }
        }
    }
    return result
}

/* This is a helper function for whoIs function. It will return a string
 * contains basic information of a DukePerson.
 */
func printPerson(_ person: DukePerson) -> String {
    var personInfo: String = ""
    personInfo = person.firstName + " " + person.lastName + " is from " + person.whereFrom + " and is a " + person.role.rawValue + ". "
    let programmingCount: Int = person.bestProgrammingLanguages.count
    let hobbiesCount: Int = person.hobbies.count
    if programmingCount > 0 {
        personInfo += person.gender == Gender.Male ? "He" : "She"
        personInfo += " is proficient in"
        personInfo += printArr(person.bestProgrammingLanguages)
    }
    if hobbiesCount > 0 {
        personInfo = personInfo + " When not in class, " + person.firstName + " enjoys"
        personInfo += printArr(person.hobbies)
    }
    return personInfo
}

func printAllPerson(_ name: String) -> String{
    var personInfo: String = ""
    for person in personArray {
        personInfo = personInfo + printPerson(person) + "\n"
    }
    return personInfo
}

/* This function allows a user to search a certain DukePerson by his or her
 * full name. You can also use a wildcard '*' to search the information of
 * all person in the 'personArray'
 */
func whoIs(_ name: String) -> String {
    if(name == "*") {
        return printAllPerson(name)
    }
    var fullName = name.components(separatedBy: " ")
    if(fullName.count != 2) {
        print("no such person")
        return ""
    }
    let firstName: String = fullName[0]
    let lastName: String = fullName[1]
    var personInfo: String = ""
    var findPerson: Bool = false
    for person in personArray {
        if(person.firstName == firstName && person.lastName == lastName) {
            personInfo = printPerson(person)
            findPerson = true
        }
    }
    if !findPerson {
        print("no such person")
        return ""
    }
    return personInfo
}

/* This function can be used to search specific DukePerson by degree.
 * The valid degree contains "BS", "MS" and "Phd". This function
 * returns a string of all qualified person splited by "."
 */
func findByDegree(_ degree: String) -> String {
    if(degree != "MS" && degree != "Phd" && degree != "BS") {
        print("invalid degree")
        return ""
    }
    var res: String = ""
    for person in personArray {
        if person.degree == degree {
            res += person.firstName
            res.append(" ")
            res += person.lastName
            res += ". "
        }
    }
    return res
}

// This function can be used to test sorting an array of DukePerson by height
func testSortByHeight(_ arr: [DukePerson]) {
    Yuanyuan.height = 1
    Ric.height = 4
    Walker.height = 3
    Niral.height = 2
    do {
        var sortedArr : [DukePerson]
        sortedArr = try arr.sorted(by: ToolBox.sortByHeight)
        for person in sortedArr {
            print(person.height!)
        }
    } catch {
        
    }
}

// This function test the basic calculator in the toolBox.
func testCalculate() {
    print("1 + 1 is " + String(ToolBox.calculate("1 + 1")))
    print("1 + 2 + (3 + 4) + 5 + 6 is" + String(ToolBox.calculate("1 + 2 + (3 + 4) + 5 + 6")))
    print("1 + 2 + (3 - 4) + 5 + 6 is " + String(ToolBox.calculate("1 + 2 + (3 - 4) + 5 + 6")))
}

// Call functions below to test
//testSortByHeight(personArray)
//testCalculate()
//print(Yuanyuan.description)
//print(findByDegree("MS"))
//print(whoIs("Yuanyuan Yu"))
//print(whoIs("*"))
//Yuanyuan = try Student(f: "Yuanyuan", l: "Yu", role: DukeRole.Student, p: ["Java", "C++", "C", "Swift"], h: ["Baseball", "Fencing", "Golf", "Fishing"])



//: ### END OF HOMEWORK
//: Uncomment the line below to test your homework.
//: The "whoIs" function should be defined as `func whoIs(_ name: String) -> String {   }`

 print(whoIs("Ric Telford"))

