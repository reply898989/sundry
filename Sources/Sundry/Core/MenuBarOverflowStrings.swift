// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

/// Strings for the menu bar overflow feature: Sundry’s own menu bar items
/// collapse behind a chevron. Same contract as the other FeatureStrings
/// structs: memberwise init with labeled arguments in declaration order, one
/// static per language, all in this file.
struct MenuBarOverflowStrings {
    let pageTitle: String
    let hubDescription: String
    let enable: String
    let caption: String
    let sectionTitle: String
    let visibleLabel: String
    let hiddenLabel: String
    let showTemporarily: String
    let dragHint: String
}

extension FeatureStrings {
    static func menuBarOverflow(_ language: AppLanguage) -> MenuBarOverflowStrings {
        switch language {
        case .enUS: return .enUS
        case .ptBR: return .ptBR
        case .tr: return .tr
        case .ru: return .ru
        case .es: return .es
        case .de: return .de
        case .fr: return .fr
        case .it: return .it
        case .ja: return .ja
        case .ko: return .ko
        case .zhHans: return .zhHans
        case .zhTW: return .zhTW
        case .zhHK: return .zhHK
        }
    }
}

extension MenuBarOverflowStrings {
    static let enUS = MenuBarOverflowStrings(
        pageTitle: "Menu bar overflow",
        hubDescription: "Tucks Sundry’s own menu bar items behind a chevron, so an installed feature you rarely glance at stops crowding the bar.",
        enable: "Collapse extra items behind a chevron",
        caption: "Only affects items Sundry itself adds. Click the chevron to reveal everything temporarily.",
        sectionTitle: "Menu bar items",
        visibleLabel: "Always visible",
        hiddenLabel: "Behind the chevron",
        showTemporarily: "Show hidden items",
        dragHint: "Drag an item between the two groups."
    )

    static let ptBR = MenuBarOverflowStrings(
        pageTitle: "Barra de menus com transbordo",
        hubDescription: "Esconde os próprios itens do Sundry na barra de menus atrás de um chevron, para que um recurso instalado que você raramente olha pare de lotar a barra.",
        enable: "Recolher itens extras atrás de um chevron",
        caption: "Afeta apenas os itens que o próprio Sundry adiciona. Clique no chevron para revelar tudo temporariamente.",
        sectionTitle: "Itens da barra de menus",
        visibleLabel: "Sempre visível",
        hiddenLabel: "Atrás do chevron",
        showTemporarily: "Mostrar itens ocultos",
        dragHint: "Arraste um item entre os dois grupos."
    )

    static let tr = MenuBarOverflowStrings(
        pageTitle: "Menü çubuğu taşması",
        hubDescription: "Sundry’nin kendi menü çubuğu öğelerini bir şevronun arkasına gizler, böylece nadiren baktığınız yüklü bir özellik çubuğu doldurmayı bırakır.",
        enable: "Fazladan öğeleri bir şevronun arkasında topla",
        caption: "Yalnızca Sundry’nin kendi eklediği öğeleri etkiler. Her şeyi geçici olarak göstermek için şevrona tıklayın.",
        sectionTitle: "Menü çubuğu öğeleri",
        visibleLabel: "Her zaman görünür",
        hiddenLabel: "Şevronun arkasında",
        showTemporarily: "Gizli öğeleri göster",
        dragHint: "Bir öğeyi iki grup arasında sürükleyin."
    )

    static let ru = MenuBarOverflowStrings(
        pageTitle: "Переполнение строки меню",
        hubDescription: "Прячет собственные значки Sundry в строке меню за шевроном, чтобы редко используемая функция не загромождала строку.",
        enable: "Скрывать лишние значки за шевроном",
        caption: "Влияет только на значки, которые добавляет сам Sundry. Нажмите шеврон, чтобы временно показать всё.",
        sectionTitle: "Значки в строке меню",
        visibleLabel: "Всегда видимые",
        hiddenLabel: "За шевроном",
        showTemporarily: "Показать скрытые значки",
        dragHint: "Перетащите значок между двумя группами."
    )

    static let es = MenuBarOverflowStrings(
        pageTitle: "Desbordamiento de la barra de menús",
        hubDescription: "Oculta los propios íconos de Sundry en la barra de menús tras un chevron, para que una función instalada que rara vez miras deje de llenar la barra.",
        enable: "Ocultar íconos extra tras un chevron",
        caption: "Solo afecta a los íconos que el propio Sundry agrega. Haz clic en el chevron para mostrarlos todos temporalmente.",
        sectionTitle: "Íconos de la barra de menús",
        visibleLabel: "Siempre visible",
        hiddenLabel: "Tras el chevron",
        showTemporarily: "Mostrar íconos ocultos",
        dragHint: "Arrastra un ícono entre los dos grupos."
    )

    static let de = MenuBarOverflowStrings(
        pageTitle: "Menüleisten-Überlauf",
        hubDescription: "Verstaut Sundrys eigene Menüleistensymbole hinter einem Chevron, damit eine selten beachtete installierte Funktion die Leiste nicht mehr überfüllt.",
        enable: "Zusätzliche Symbole hinter einem Chevron einklappen",
        caption: "Betrifft nur Symbole, die Sundry selbst hinzufügt. Klicke auf den Chevron, um alles vorübergehend anzuzeigen.",
        sectionTitle: "Menüleistensymbole",
        visibleLabel: "Immer sichtbar",
        hiddenLabel: "Hinter dem Chevron",
        showTemporarily: "Verborgene Symbole anzeigen",
        dragHint: "Ziehe ein Symbol zwischen den beiden Gruppen."
    )

    static let fr = MenuBarOverflowStrings(
        pageTitle: "Débordement de la barre de menus",
        hubDescription: "Range les propres icônes de Sundry dans la barre de menus derrière un chevron, pour qu’une fonctionnalité installée que vous regardez rarement cesse d’encombrer la barre.",
        enable: "Replier les icônes en trop derrière un chevron",
        caption: "N’affecte que les icônes ajoutées par Sundry lui-même. Cliquez sur le chevron pour tout afficher temporairement.",
        sectionTitle: "Icônes de la barre de menus",
        visibleLabel: "Toujours visible",
        hiddenLabel: "Derrière le chevron",
        showTemporarily: "Afficher les icônes masquées",
        dragHint: "Faites glisser une icône entre les deux groupes."
    )

    static let it = MenuBarOverflowStrings(
        pageTitle: "Overflow della barra dei menu",
        hubDescription: "Nasconde le icone di Sundry nella barra dei menu dietro un chevron, così una funzione installata che guardi raramente smette di affollare la barra.",
        enable: "Comprimi le icone extra dietro un chevron",
        caption: "Riguarda solo le icone aggiunte da Sundry stesso. Fai clic sul chevron per mostrarle tutte temporaneamente.",
        sectionTitle: "Icone della barra dei menu",
        visibleLabel: "Sempre visibile",
        hiddenLabel: "Dietro il chevron",
        showTemporarily: "Mostra icone nascoste",
        dragHint: "Trascina un’icona tra i due gruppi."
    )

    static let ja = MenuBarOverflowStrings(
        pageTitle: "メニューバーのオーバーフロー",
        hubDescription: "Sundry自身のメニューバー項目をシェブロンの後ろにまとめ、あまり見ない機能でメニューバーが混雑しないようにします。",
        enable: "余分な項目をシェブロンの後ろに折りたたむ",
        caption: "Sundry自身が追加した項目のみに影響します。シェブロンをクリックすると一時的にすべて表示されます。",
        sectionTitle: "メニューバー項目",
        visibleLabel: "常に表示",
        hiddenLabel: "シェブロンの後ろ",
        showTemporarily: "隠れている項目を表示",
        dragHint: "項目を2つのグループ間でドラッグしてください。"
    )

    static let ko = MenuBarOverflowStrings(
        pageTitle: "메뉴 막대 오버플로",
        hubDescription: "Sundry 자체 메뉴 막대 항목을 셰브론 뒤로 모아, 자주 보지 않는 설치된 기능이 막대를 어지럽히지 않게 합니다.",
        enable: "추가 항목을 셰브론 뒤로 접기",
        caption: "Sundry가 직접 추가한 항목에만 적용됩니다. 셰브론을 클릭하면 일시적으로 모두 표시됩니다.",
        sectionTitle: "메뉴 막대 항목",
        visibleLabel: "항상 표시",
        hiddenLabel: "셰브론 뒤",
        showTemporarily: "숨겨진 항목 표시",
        dragHint: "항목을 두 그룹 사이로 드래그하세요."
    )

    static let zhHans = MenuBarOverflowStrings(
        pageTitle: "菜单栏溢出",
        hubDescription: "把 Sundry 自己的菜单栏项目收进一个箭头图标后面，让您很少留意的已安装功能不再挤占菜单栏。",
        enable: "把多余的项目收进箭头图标后面",
        caption: "只影响 Sundry 自己添加的项目。点击箭头图标可临时显示全部项目。",
        sectionTitle: "菜单栏项目",
        visibleLabel: "始终显示",
        hiddenLabel: "收进箭头图标",
        showTemporarily: "显示隐藏的项目",
        dragHint: "在两组之间拖动项目。"
    )

    static let zhTW = MenuBarOverflowStrings(
        pageTitle: "選單列溢出",
        hubDescription: "將 Sundry 自己的選單列項目收進一個箭頭圖示後面，讓您很少留意的已安裝功能不再擠佔選單列。",
        enable: "將多餘的項目收進箭頭圖示後面",
        caption: "只影響 Sundry 自己新增的項目。點按箭頭圖示可暫時顯示全部項目。",
        sectionTitle: "選單列項目",
        visibleLabel: "永遠顯示",
        hiddenLabel: "收進箭頭圖示",
        showTemporarily: "顯示隱藏的項目",
        dragHint: "在兩組之間拖曳項目。"
    )

    static let zhHK = MenuBarOverflowStrings(
        pageTitle: "選單列溢出",
        hubDescription: "將 Sundry 自己嘅選單列項目收埋喺一個箭嘴圖示後面，等您好少留意嘅已安裝功能唔再迫爆選單列。",
        enable: "將多餘嘅項目收埋喺箭嘴圖示後面",
        caption: "只影響 Sundry 自己新增嘅項目。撳箭嘴圖示可以暫時顯示全部項目。",
        sectionTitle: "選單列項目",
        visibleLabel: "永遠顯示",
        hiddenLabel: "收埋喺箭嘴圖示",
        showTemporarily: "顯示隱藏嘅項目",
        dragHint: "喺兩組之間拖曳項目。"
    )
}
