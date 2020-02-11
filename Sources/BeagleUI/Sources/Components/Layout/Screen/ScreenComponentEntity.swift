//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ScreenComponentEntity: ComponentConvertibleEntity {
    
    let safeArea: SafeAreaEntity?
    let navigationBar: NavigationBarEntity?
    let header: AnyDecodableContainer?
    let content: AnyDecodableContainer
    let footer: AnyDecodableContainer?
    
    func mapToComponent() throws -> ServerDrivenComponent {
    
        let safeArea = self.safeArea?.toSafeArea()
        let navigationBar = self.navigationBar?.toNavigationBar()
        
        let headerEntity = self.header?.content as? ComponentConvertibleEntity
        let header = try headerEntity?.mapToComponent()
        
        let contentEntity = self.content.content as? ComponentConvertibleEntity
        let content = try contentEntity?.mapToComponent() ?? AnyComponent(value: self.content.content)
        
        let footerEntity = self.footer?.content as? ComponentConvertibleEntity
        let footer = try footerEntity?.mapToComponent()

        return ScreenComponent(
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

struct NavigationBarEntity: Decodable {
    
    let title: String
    let style: String?
    let showBackButton: Bool?
    let navigationBarItems: [NavigationBarItemEntity]?
    
    func toNavigationBar() -> NavigationBar {
        let items = navigationBarItems?.compactMap { try? $0.mapToUIModel() }
        return NavigationBar(
            title: title,
            style: style,
            showBackButton: showBackButton,
            navigationBarItems: items
        )
    }
}

struct NavigationBarItemEntity: Decodable {
    
    public let image: String?
    public let text: String
    public let action: AnyDecodableContainer

}

extension NavigationBarItemEntity: UIModelConvertible {
        
    func mapToUIModel() throws -> NavigationBarItem {
        let actionEntity = self.action.content as? ActionConvertibleEntity
        let action = try actionEntity?.mapToAction() ?? AnyAction(value: self.action.content)
        return NavigationBarItem(
            image: image,
            text: text,
            action: action
        )
    }
    
}
