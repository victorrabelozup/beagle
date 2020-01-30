//
//  Copyright © 2019 Daniel Tes. All rights reserved.
//

struct ListViewEntity: WidgetConvertibleEntity {
    
    let rows: [AnyDecodableContainer]
    let remoteDataSource: String?
    let loadingState: AnyDecodableContainer?
    
    enum Direction: String, WidgetEntity {
        case vertical
        case horizontal
    }
    
    func mapToWidget() throws -> Widget {
        
        let rows = try self.rows.compactMap {
            try ($0.content as? WidgetConvertibleEntity)?.mapToWidget()
        }
        
        let widgetEntity = self.loadingState?.content as? WidgetConvertibleEntity
        let loadingState = try widgetEntity?.mapToWidget()
        
        let direction = ListView.Direction.vertical
        
        return ListView(
            rows: rows,
            remoteDataSource: remoteDataSource,
            loadingState: loadingState,
            direction: direction
        )
    }
}
