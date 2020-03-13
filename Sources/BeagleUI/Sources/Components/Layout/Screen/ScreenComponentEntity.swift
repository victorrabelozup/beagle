//
//  Copyright © 2019 Zup IT. All rights reserved.
//

struct ScreenComponentEntity: ComponentConvertibleEntity {
    
    let identifier: String?
    let appearance: AppearanceEntity?
    let safeArea: SafeAreaEntity?
    let navigationBar: NavigationBarEntity?
    let header: AnyDecodableContainer?
    let child: AnyDecodableContainer
    let footer: AnyDecodableContainer?
    
    func mapToComponent() throws -> ServerDrivenComponent {
    
        let appearance = try self.appearance?.mapToUIModel()
        let safeArea = self.safeArea?.toSafeArea()
        let navigationBar = self.navigationBar?.toNavigationBar()
        
        let headerEntity = self.header?.content as? ComponentConvertibleEntity
        let header = try headerEntity?.mapToComponent()
        
        let childEntity = self.child.content as? ComponentConvertibleEntity
        let child = try childEntity?.mapToComponent() ?? AnyComponent(value: self.child.content)
        
        let footerEntity = self.footer?.content as? ComponentConvertibleEntity
        let footer = try footerEntity?.mapToComponent()

        return ScreenComponent(
            identifier: identifier,
            appearance: appearance,
            safeArea: safeArea,
            navigationBar: navigationBar,
            header: header,
            child: child,
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
