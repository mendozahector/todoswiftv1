import Foundation

class TodoItem {
    var name = ""
    var added = ""
}

var list = [TodoItem]()

let filePath = "/Users/hectormendoza/Desktop/Spring 2021/Applied Programming/todoswiftv1/swift/todov1swift/todolist.txt"
var myCounter: Int
do {
    let contents = try String(contentsOfFile: filePath)
    let lines = contents.split(separator:"\n")
    myCounter = lines.count
    
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

func showList(list: [TodoItem]) {
    print("This is your TODO list:")
    
    var count = 1
    for item in list {
        print("\(count) - \(item.name).")
        count += 1
    }
}

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

func delete() -> Int {
    showList(list: list)
    
    print("Enter item index you would like to delete. Enter zero (0) to cancel:")
    return Int(readLine() ?? "-1") ?? -1
}

let menu = """
    Welcome to your TODO organizer app. Please select your option:
    1. View TODO items.
    2. Add new TODO item.
    3. Delete TODO item.
    0. Exit.
    """

print(menu)

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