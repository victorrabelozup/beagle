//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ScreenWidgetEntity: WidgetConvertibleEntity {
    
    let safeArea: SafeAreaEntity?
    let navigationBar: ScreenNavigationBarEntity?
    let header: AnyDecodableContainer?
    let content: AnyDecodableContainer
    let footer: AnyDecodableContainer?
    
    func mapToWidget() throws -> Widget {
    
        let safeArea = self.safeArea?.toSafeArea()
        let navigationBar = self.navigationBar?.toNavigationBar()
        
        let headerEntity = self.header?.content as? WidgetConvertibleEntity
        let header = try headerEntity?.mapToWidget()
        
        let contentEntity = self.content.content as? WidgetConvertibleEntity
        let content = try contentEntity?.mapToWidget() ?? AnyWidget(value: self.content.content)
        
        let footerEntity = self.footer?.content as? WidgetConvertibleEntity
        let footer = try footerEntity?.mapToWidget()

        return ScreenWidget(
            safeArea: safeArea,
            navigationBar: navigationBar,
            header: header,
            content: content,
            footer: footer
        )
    }
}

struct SafeAreaEntity: Decodable {
    
    public let top: Bool?
    public let left: Bool?
    public let bottom: Bool?
    public let trailing: Bool?
    
    func toSafeArea() -> SafeArea {
        return SafeArea(
            top: self.top,
            leading: self.left,
            bottom: self.bottom,
            trailing: self.trailing
        )
    }
}

struct ScreenNavigationBarEntity: Decodable {
    
    let title: String
    let style: String?
    let showBackButton: Bool?
    
    func toNavigationBar() -> NavigationBar {
        return NavigationBar(
            title: title,
            style: style,
            showBackButton: showBackButton
        )
    }
}
