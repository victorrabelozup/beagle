//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ListViewEntity: ComponentConvertibleEntity {
    
    let rows: [AnyDecodableContainer]
    let direction: Direction?
    
    enum Direction: String, ComponentEntity, UIEnumModelConvertible {
        case vertical = "VERTICAL"
        case horizontal = "HORIZONTAL"
    }
    
    func mapToComponent() throws -> ServerDrivenComponent {
        
        let rows = try self.rows.compactMap {
            try ($0.content as? ComponentConvertibleEntity)?.mapToComponent()
        }
        let direction = try self.direction?.mapToUIModel(ofType: ListView.Direction.self)
        
        return ListView(
            rows: rows,
            direction: direction ?? .vertical
        )
    }
}
