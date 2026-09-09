// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

/// Strings for pinning a window above every other window. Same contract as
/// the other FeatureStrings structs: memberwise init with labeled arguments
/// in declaration order, one static per language, all in this file.
struct WindowPinStrings {
    let pageTitle: String
    let hubDescription: String
    let enable: String
    let caption: String
    let pinMenuItem: String
    let unpinMenuItem: String
    let shortcutLabel: String
    let pinnedIndicator: String
}

extension FeatureStrings {
    static func windowPin(_ language: AppLanguage) -> WindowPinStrings {
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

extension WindowPinStrings {
    static let enUS = WindowPinStrings(
        pageTitle: "Pin window",
        hubDescription: "Keeps a chosen window floating above every other window on its Space.",
        enable: "Enable window pinning",
        caption: "A pinned window stays visible while you work in something else, and unpins itself when its app quits.",
        pinMenuItem: "Pin window",
        unpinMenuItem: "Unpin window",
        shortcutLabel: "Pin the frontmost window",
        pinnedIndicator: "Pinned"
    )

    static let ptBR = WindowPinStrings(
        pageTitle: "Fixar janela",
        hubDescription: "Mantém uma janela escolhida flutuando acima de todas as outras no seu Espaço.",
        enable: "Ativar fixação de janelas",
        caption: "Uma janela fixada continua visível enquanto você trabalha em outra coisa, e se desafixa sozinha quando o app fecha.",
        pinMenuItem: "Fixar janela",
        unpinMenuItem: "Desafixar janela",
        shortcutLabel: "Fixar a janela em primeiro plano",
        pinnedIndicator: "Fixada"
    )

    static let tr = WindowPinStrings(
        pageTitle: "Pencereyi sabitle",
        hubDescription: "Seçilen bir pencereyi, bulunduğu Alandaki diğer tüm pencerelerin üzerinde tutar.",
        enable: "Pencere sabitlemeyi etkinleştir",
        caption: "Sabitlenmiş bir pencere başka bir şey üzerinde çalışırken görünür kalır ve uygulaması kapandığında kendiliğinden sabitlemesi kalkar.",
        pinMenuItem: "Pencereyi sabitle",
        unpinMenuItem: "Sabitlemeyi kaldır",
        shortcutLabel: "En öndeki pencereyi sabitle",
        pinnedIndicator: "Sabit"
    )

    static let ru = WindowPinStrings(
        pageTitle: "Закрепить окно",
        hubDescription: "Держит выбранное окно поверх всех остальных в пределах его Пространства.",
        enable: "Включить закрепление окон",
        caption: "Закреплённое окно остаётся видимым, пока вы работаете в другом, и открепляется само, когда его приложение закрывается.",
        pinMenuItem: "Закрепить окно",
        unpinMenuItem: "Открепить окно",
        shortcutLabel: "Закрепить активное окно",
        pinnedIndicator: "Закреплено"
    )

    static let es = WindowPinStrings(
        pageTitle: "Fijar ventana",
        hubDescription: "Mantiene una ventana elegida flotando sobre todas las demás en su Espacio.",
        enable: "Activar la fijación de ventanas",
        caption: "Una ventana fijada permanece visible mientras trabajas en otra cosa, y se desfija sola cuando su app se cierra.",
        pinMenuItem: "Fijar ventana",
        unpinMenuItem: "Dejar de fijar ventana",
        shortcutLabel: "Fijar la ventana en primer plano",
        pinnedIndicator: "Fijada"
    )

    static let de = WindowPinStrings(
        pageTitle: "Fenster anheften",
        hubDescription: "Hält ein ausgewähltes Fenster über allen anderen auf seinem Space.",
        enable: "Fenster anheften aktivieren",
        caption: "Ein angeheftetes Fenster bleibt sichtbar, während du in etwas anderem arbeitest, und löst sich selbst, wenn seine App beendet wird.",
        pinMenuItem: "Fenster anheften",
        unpinMenuItem: "Anheften aufheben",
        shortcutLabel: "Vorderstes Fenster anheften",
        pinnedIndicator: "Angeheftet"
    )

    static let fr = WindowPinStrings(
        pageTitle: "Épingler la fenêtre",
        hubDescription: "Garde une fenêtre choisie au-dessus de toutes les autres dans son Espace.",
        enable: "Activer l’épinglage de fenêtres",
        caption: "Une fenêtre épinglée reste visible pendant que vous travaillez ailleurs, et se désépingle d’elle-même quand son app quitte.",
        pinMenuItem: "Épingler la fenêtre",
        unpinMenuItem: "Désépingler la fenêtre",
        shortcutLabel: "Épingler la fenêtre au premier plan",
        pinnedIndicator: "Épinglée"
    )

    static let it = WindowPinStrings(
        pageTitle: "Blocca finestra in primo piano",
        hubDescription: "Mantiene una finestra scelta sopra tutte le altre nel suo Spazio.",
        enable: "Attiva il blocco delle finestre in primo piano",
        caption: "Una finestra bloccata resta visibile mentre lavori altrove, e si sblocca da sola quando la sua app si chiude.",
        pinMenuItem: "Blocca finestra in primo piano",
        unpinMenuItem: "Sblocca finestra",
        shortcutLabel: "Blocca la finestra in primo piano",
        pinnedIndicator: "Bloccata"
    )

    static let ja = WindowPinStrings(
        pageTitle: "ウインドウをピン留め",
        hubDescription: "選んだウインドウを、そのスペース内で常に他のウインドウより手前に表示します。",
        enable: "ウインドウのピン留めを有効にする",
        caption: "ピン留めしたウインドウは他の作業中も表示され続け、そのアプリを終了すると自動的にピン留めが解除されます。",
        pinMenuItem: "ウインドウをピン留め",
        unpinMenuItem: "ピン留めを解除",
        shortcutLabel: "最前面のウインドウをピン留め",
        pinnedIndicator: "ピン留め中"
    )

    static let ko = WindowPinStrings(
        pageTitle: "창 고정",
        hubDescription: "선택한 창을 같은 스페이스 안에서 항상 다른 모든 창 위에 띄워 둡니다.",
        enable: "창 고정 켜기",
        caption: "고정된 창은 다른 작업을 하는 동안에도 계속 보이며, 해당 앱이 종료되면 자동으로 고정이 풀립니다.",
        pinMenuItem: "창 고정",
        unpinMenuItem: "창 고정 해제",
        shortcutLabel: "맨 앞 창 고정",
        pinnedIndicator: "고정됨"
    )

    static let zhHans = WindowPinStrings(
        pageTitle: "窗口置顶",
        hubDescription: "让选中的窗口在其所在 Space 内始终浮在其他所有窗口之上。",
        enable: "启用窗口置顶",
        caption: "置顶的窗口在您处理其他内容时仍保持可见，其所属应用退出时会自动取消置顶。",
        pinMenuItem: "置顶窗口",
        unpinMenuItem: "取消置顶",
        shortcutLabel: "置顶最前面的窗口",
        pinnedIndicator: "已置顶"
    )

    static let zhTW = WindowPinStrings(
        pageTitle: "視窗釘選",
        hubDescription: "讓選定的視窗在其所在 Space 內永遠浮在其他所有視窗之上。",
        enable: "啟用視窗釘選",
        caption: "已釘選的視窗在您處理其他內容時仍會保持可見，其所屬應用程式結束時會自動取消釘選。",
        pinMenuItem: "釘選視窗",
        unpinMenuItem: "取消釘選",
        shortcutLabel: "釘選最前面的視窗",
        pinnedIndicator: "已釘選"
    )

    static let zhHK = WindowPinStrings(
        pageTitle: "視窗釘選",
        hubDescription: "令選定嘅視窗喺其所在 Space 內永遠浮喺其他所有視窗之上。",
        enable: "啟用視窗釘選",
        caption: "已釘選嘅視窗喺您處理其他內容時仍會保持可見，其所屬應用程式結束時會自動取消釘選。",
        pinMenuItem: "釘選視窗",
        unpinMenuItem: "取消釘選",
        shortcutLabel: "釘選最前面嘅視窗",
        pinnedIndicator: "已釘選"
    )
}
