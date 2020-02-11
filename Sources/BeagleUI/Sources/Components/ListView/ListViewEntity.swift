//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ListViewEntity: ComponentConvertibleEntity {
    
    let rows: [AnyDecodableContainer]
    let remoteDataSource: String?
    let loadingState: AnyDecodableContainer?
    
    enum Direction: String, ComponentEntity {
        case vertical
        case horizontal
    }
    
    func mapToComponent() throws -> ServerDrivenComponent {
        
        let rows = try self.rows.compactMap {
            try ($0.content as? ComponentConvertibleEntity)?.mapToComponent()
        }
        
        let componentEntity = self.loadingState?.content as? ComponentConvertibleEntity
        let loadingState = try componentEntity?.mapToComponent()
        
        let direction = ListView.Direction.vertical
        
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
}
