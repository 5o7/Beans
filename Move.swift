import Foundation

class Move {
    var fromLoc: BoardLoc
    var toLoc: BoardLoc
    
    init(_ fromLoc: BoardLoc, _ toLoc: BoardLoc) {
        self.fromLoc = fromLoc
        self.toLoc = toLoc
    }
}
