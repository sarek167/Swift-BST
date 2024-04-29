import Foundation

class Container {
    var nextIndex: Int = 0;
    var root: Node?;
    
    init(){
        print("Container is born");
    }
    
    deinit {
        print("Container dies");
    }
    
    func addNode(_ data: Any, _ key: Int, _ nodeToCheckGiven: Node? = nil) {
        // variable necessary to assign value of nodeToCheck as given value is not mutable
        var nodeToCheck: Node?;
        
        // if root is nil, add Node as root Node
        if root == nil {
            root = Node(data, key, nextIndex, nil);
            nextIndex += 1;
        } else {
            // if nodeToCheckGiven is nil (not recursive function call) assign root as the node to start checking
            // if it's not nil assign given parameter
            if nodeToCheckGiven == nil {
                nodeToCheck = root;
            } else {
                nodeToCheck = nodeToCheckGiven;
            }
            
            // check if key of the node is smaller or equal
            if nodeToCheck!.key <= key {
                // if there is no smaller or equal element assign node there
                if nodeToCheck!.smallerOrEqual == nil {
                    nodeToCheck!.smallerOrEqual = Node(data, key, self.nextIndex, nodeToCheck);
                    nextIndex += 1;
                // if there is smaller element assign it as node to start checking and call function recursively
                } else {
                    self.addNode(data, key, nodeToCheck!.smallerOrEqual);
                }
            // check if the key of the node is greater
            } else {
                // if there is no greater element assign node there
                if nodeToCheck!.greater == nil {
                    nodeToCheck!.greater = Node(data, key, self.nextIndex, nodeToCheck);
                    nextIndex += 1;
                // if there is greater elemeent assign it as a node to start checking and call function recursively
                } else {
                    self.addNode(data, key, nodeToCheck!.greater);
                }
            }
        }
    }
    
}

class Node {
    // should have key, data, greater, smaller or equal element
    let index: Int;
    let key: Int;
    var greater: Node?;
    var smallerOrEqual: Node?;
    weak var parent: Node?;
    var data: Any;
    
    init(_ dataToAssign: Any, _ keyToAssign: Int, _ nextIndex: Int, _ parentToAssign: Node?) {
        index = nextIndex;
        key = keyToAssign;
        data = dataToAssign;
        parent = parentToAssign;
        if parent == nil {
            print("Node " + String(self.index) + " as root with key and data is born");
        } else {
            print("Node " + String(self.index) + " with parent " + String(self.parent!.index) + " with key and data is born");
        }
        print(self.key);
        print(self.data);
    }
    
    deinit {
        print("Node " + String(self.index) + " with key and data dies");
        print(self.key);
        print(self.data);
    }
}
// test BST with correct destructing
var container: Container? = Container();
container!.addNode("text", 345);
container!.addNode(145, 65);
container!.addNode(1.5, 987);
container!.addNode("new text", 154);

container = nil;
