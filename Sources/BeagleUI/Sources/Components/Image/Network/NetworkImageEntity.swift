//
//  Copyright © 2019 Zup IT. All rights reserved.
//

public struct NetworkImageEntity: WidgetEntity {

    public let path: String
    public let contentMode: ImageEntityContentMode?

    public let appearance: AppearanceEntity?
    public var flex: FlexEntity?
    public var accessibility: AccessibilityEntity?
    public var id: String?

    public init(
        path: String,
        contentMode: ImageEntityContentMode? = nil,
        appearance: AppearanceEntity? = nil,
        flex: FlexEntity? = nil,
        accessibility: AccessibilityEntity? = nil,
        id: String? = nil
    ) {
        self.path = path
        self.contentMode = contentMode
        self.appearance = appearance
        self.flex = flex
        self.accessibility = accessibility
        self.id = id
    }
    
    public func mapToComponent() throws -> ServerDrivenComponent {
        let contentMode = try self.contentMode?.mapToUIModel(ofType: ImageContentMode.self)
        let appearance = try self.appearance?.mapToUIModel()
        let accessibility = try self.accessibility?.mapToUIModel()
        let flex = try self.flex?.mapToUIModel()

        return NetworkImage(
            path: path,
            contentMode: contentMode,
            id: id,
            appearance: appearance,
            flex: flex,
            accessibility: accessibility
        )
    }
}
