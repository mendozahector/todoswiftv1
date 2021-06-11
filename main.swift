import Foundation

class TodoItem {
    var name = ""
    var added = Date()
}

var list = [TodoItem]()

var item = TodoItem()
item.name = "Learn Swift"
list.append(item)

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
    newItem.name = readLine() ?? "New Item"
    
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