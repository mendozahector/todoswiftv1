import Foundation

// Todo Item class containing name and date added (MM-dd-yyy).
class TodoItem {
    var name = ""
    var added = ""
}

// Array containing all of our todo items.
var list = [TodoItem]()

// This is our local file containing our data.
// Please update according to your directory.
// Will be updated to a realtime database in v3.
let filePath = "/Users/hectormendoza/Desktop/Spring 2021/Applied Programming/todoswiftv1/swift/todov1swift/todolist.txt"

// We try to load the text file (todolist.txt).
// If we are unable to load the text file, we exit the program.
do {
    let contents = try String(contentsOfFile: filePath)
    let lines = contents.split(separator:"\n")
    
    for line in lines {
        let item = line.split(separator: ",")
        let newItem = TodoItem()
        
        newItem.name = String(item[0])
        newItem.added = String(item[1])
        
        list.append(newItem)
    }
    
    } catch {
        print(error.localizedDescription)
        exit(0)
    }

// Function displaying all of the todo items to the user.
func showList(list: [TodoItem]) {
    print("This is your TODO list:")
    
    var count = 1
    for item in list {
        print("\(count) - \(item.name).")
        count += 1
    }
}

// View Todo Items Menu
// User is able to view the details of each todo item,
// after selecting the index of the item.
func view() {
    showList(list: list)
    
    print("Please select a number to see details. Enter zero (0) to exit.")

    while let input = readLine() {
        guard input != "0" else {
                break
            }
        
        if (Int(input) ?? 0 < list.count + 1 && Int(input) ?? 0 > 0) {
            print("""
                * Name: \(list[Int(input)! - 1].name)
                * Added: \(list[Int(input)! - 1].added)
                """)
        }
        
        print("\nPlease select another number to see details. Enter zero (0) to exit.")
    }
}

// Add Todo Item Menu
// User is prompted for the name of the todo item.
// Date is automatically added with format MM-dd-yyyy.
// New TodoItem is stored into the list array.
func add() -> TodoItem {
    let newItem = TodoItem()
    print("Enter new item name:")
    
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyy"
    
    newItem.name = readLine() ?? "New Item"
    newItem.added = dateFormatter.string(from: date)
    
    print("New item has been added to the list. Thank you.")
    
    return newItem
}

// Delete Todo Item Menu
// User is prompted for TodoItem index to be deleted.
// If valid, we delete the TodoItem.
func delete() -> Int {
    showList(list: list)
    
    print("Enter item index you would like to delete. Enter zero (0) to cancel:")
    return Int(readLine() ?? "-1") ?? -1
}

// Our Main Menu with the program options.
let menu = """
    Welcome to your TODO organizer app. Please select your option:
    1. View TODO items.
    2. Add new TODO item.
    3. Delete TODO item.
    0. Exit.
    """

print(menu)

// Main Menu logic, we keep the program running under user enter zero (0).
while let input = readLine() {
    guard input != "0" else {
        try FileManager.default.removeItem(atPath: filePath)
        var items = ""
        for item in list {
            let line = item.name + "," + item.added + "\n"
            items.append(line)
        }
        try items.write(to: URL(fileURLWithPath: filePath), atomically: false, encoding: .utf8)
        break
    }
    
    print()
    
    // Depending on user input, we access the corresponding menu item.
    // 1 - We go to the view TodoItems function.
    // 2 - We go to the add TodoItems function.
    // 3 - We go to the delete TodoItems function.
    // User can only delete and view TodoItems if the TodoItem list is not empty.
    switch input {
    case "1":
        if list.count < 1 {
            print("TODO list is empty. Please add new item first.")
        } else {
            view()
        }
    case "2":
        list.append(add())
    case "3":
        if list.count < 1 {
            print("TODO list is empty. Please add new item first.")
        } else {
            let i = delete()
            if i > 0 && i <= list.count {
                list.remove(at: i - 1)
                print("Item at index \(i) has been deleted.")
            } else {
                print("Incorrect index number.")
            }
        }
        
    default:
        break
    }
    
    print("\n\(menu)")
}
