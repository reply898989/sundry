// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

/// Strings for the Dark mode schedule feature. Same contract as the other
/// FeatureStrings structs: memberwise init with labeled arguments in
/// declaration order, one static per language, all in this file.
struct DarkModeScheduleStrings {
    let pageTitle: String
    let hubDescription: String
    let enable: String
    let lightLabel: String
    let darkLabel: String
    let nextChangeFormat: String   // "Next change: %@"
    let caption: String
}

extension FeatureStrings {
    static func darkModeSchedule(_ language: AppLanguage) -> DarkModeScheduleStrings {
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

extension DarkModeScheduleStrings {
    static let enUS = DarkModeScheduleStrings(
        pageTitle: "Dark mode schedule",
        hubDescription: "Switches light and dark mode automatically at two times you choose.",
        enable: "Switch appearance on a schedule",
        lightLabel: "Light mode at",
        darkLabel: "Dark mode at",
        nextChangeFormat: "Next change: %@",
        caption: "Applies immediately when turned on, and again after sleep or a clock change."
    )

    static let ptBR = DarkModeScheduleStrings(
        pageTitle: "Agenda do modo escuro",
        hubDescription: "Alterna entre os modos claro e escuro automaticamente em dois horários à sua escolha.",
        enable: "Alternar a aparência por agenda",
        lightLabel: "Modo claro às",
        darkLabel: "Modo escuro às",
        nextChangeFormat: "Próxima mudança: %@",
        caption: "Aplica-se imediatamente ao ativar, e de novo após o repouso ou uma mudança de horário."
    )

    static let tr = DarkModeScheduleStrings(
        pageTitle: "Karanlık mod zamanlaması",
        hubDescription: "Seçtiğiniz iki saatte açık ve karanlık modu otomatik olarak değiştirir.",
        enable: "Görünümü zamanlamayla değiştir",
        lightLabel: "Açık mod saati",
        darkLabel: "Karanlık mod saati",
        nextChangeFormat: "Sonraki değişiklik: %@",
        caption: "Açıldığında hemen, uykudan sonra veya saat değişince yeniden uygulanır."
    )

    static let ru = DarkModeScheduleStrings(
        pageTitle: "Расписание тёмного режима",
        hubDescription: "Автоматически переключает светлый и тёмный режим в два выбранных вами времени.",
        enable: "Переключать оформление по расписанию",
        lightLabel: "Светлый режим в",
        darkLabel: "Тёмный режим в",
        nextChangeFormat: "Следующее переключение: %@",
        caption: "Применяется сразу при включении, а также после сна или смены времени."
    )

    static let es = DarkModeScheduleStrings(
        pageTitle: "Horario del modo oscuro",
        hubDescription: "Alterna el modo claro y oscuro automáticamente en dos horas que elijas.",
        enable: "Cambiar la apariencia según un horario",
        lightLabel: "Modo claro a las",
        darkLabel: "Modo oscuro a las",
        nextChangeFormat: "Próximo cambio: %@",
        caption: "Se aplica de inmediato al activarlo, y de nuevo tras el reposo o un cambio de hora."
    )

    static let de = DarkModeScheduleStrings(
        pageTitle: "Zeitplan für den dunklen Modus",
        hubDescription: "Wechselt automatisch zwischen hellem und dunklem Modus zu zwei von dir gewählten Uhrzeiten.",
        enable: "Erscheinungsbild nach Zeitplan wechseln",
        lightLabel: "Heller Modus um",
        darkLabel: "Dunkler Modus um",
        nextChangeFormat: "Nächster Wechsel: %@",
        caption: "Wird beim Einschalten sofort angewendet, ebenso nach dem Ruhezustand oder einer Zeitänderung."
    )

    static let fr = DarkModeScheduleStrings(
        pageTitle: "Programmation du mode sombre",
        hubDescription: "Bascule automatiquement entre le mode clair et le mode sombre à deux heures de votre choix.",
        enable: "Changer l’apparence selon un horaire",
        lightLabel: "Mode clair à",
        darkLabel: "Mode sombre à",
        nextChangeFormat: "Prochain changement : %@",
        caption: "S’applique immédiatement à l’activation, et de nouveau après la veille ou un changement d’heure."
    )

    static let it = DarkModeScheduleStrings(
        pageTitle: "Programma modalità scura",
        hubDescription: "Alterna automaticamente la modalità chiara e scura in due orari a tua scelta.",
        enable: "Cambia aspetto in base a un programma",
        lightLabel: "Modalità chiara alle",
        darkLabel: "Modalità scura alle",
        nextChangeFormat: "Prossimo cambio: %@",
        caption: "Si applica subito all’attivazione, e di nuovo dopo lo stop o un cambio di orario."
    )

    static let ja = DarkModeScheduleStrings(
        pageTitle: "ダークモードのスケジュール",
        hubDescription: "選んだ2つの時刻でライトモードとダークモードを自動的に切り替えます。",
        enable: "スケジュールで外観を切り替える",
        lightLabel: "ライトモードにする時刻",
        darkLabel: "ダークモードにする時刻",
        nextChangeFormat: "次の切り替え: %@",
        caption: "オンにすると即座に適用され、スリープ復帰や時刻変更のたびにも再適用されます。"
    )

    static let ko = DarkModeScheduleStrings(
        pageTitle: "다크 모드 일정",
        hubDescription: "선택한 두 시각에 라이트 모드와 다크 모드를 자동으로 전환합니다.",
        enable: "일정에 따라 화면 모드 전환",
        lightLabel: "라이트 모드 시작 시각",
        darkLabel: "다크 모드 시작 시각",
        nextChangeFormat: "다음 전환: %@",
        caption: "켜면 즉시 적용되며, 잠자기 복귀나 시각 변경 후에도 다시 적용됩니다."
    )

    static let zhHans = DarkModeScheduleStrings(
        pageTitle: "深色模式时间表",
        hubDescription: "在您选择的两个时间点自动切换浅色和深色模式。",
        enable: "按时间表切换外观",
        lightLabel: "浅色模式时间",
        darkLabel: "深色模式时间",
        nextChangeFormat: "下次切换：%@",
        caption: "开启后立即生效，睡眠唤醒或时间变更后也会重新应用。"
    )

    static let zhTW = DarkModeScheduleStrings(
        pageTitle: "深色模式時間表",
        hubDescription: "在您選擇的兩個時間點自動切換淺色和深色模式。",
        enable: "依時間表切換外觀",
        lightLabel: "淺色模式時間",
        darkLabel: "深色模式時間",
        nextChangeFormat: "下次切換：%@",
        caption: "開啟後立即套用，喚醒或時間變更後也會重新套用。"
    )

    static let zhHK = DarkModeScheduleStrings(
        pageTitle: "深色模式時間表",
        hubDescription: "喺您選擇嘅兩個時間自動切換淺色同深色模式。",
        enable: "按時間表切換外觀",
        lightLabel: "淺色模式時間",
        darkLabel: "深色模式時間",
        nextChangeFormat: "下次切換：%@",
        caption: "開啟後即時生效，喚醒或時間變更後都會重新套用。"
    )
}
