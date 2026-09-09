// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

/// Strings for the Focus timer feature. Same contract as the other
/// FeatureStrings structs: memberwise init with labeled arguments in
/// declaration order, one static per language, all in this file.
struct FocusTimerStrings {
    let pageTitle: String
    let hubDescription: String
    let workLabel: String
    let breakLabel: String
    let startButton: String
    let pauseButton: String
    let resumeButton: String
    let skipButton: String
    let resetButton: String
    let autoStartNext: String
    let sessionCompleteTitle: String
    let sessionCompleteBody: String
    let breakCompleteTitle: String
    let breakCompleteBody: String
    let statusWorkFormat: String    // "Focus · %@"
    let statusBreakFormat: String   // "Break · %@"
    let idleLabel: String
    let sessionsTodayFormat: String // "%d sessions today"
}

extension FeatureStrings {
    static func focusTimer(_ language: AppLanguage) -> FocusTimerStrings {
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

extension FocusTimerStrings {
    static let enUS = FocusTimerStrings(
        pageTitle: "Focus timer",
        hubDescription: "A work and break countdown in the menu bar, with a notification when each side ends.",
        workLabel: "Focus session",
        breakLabel: "Break",
        startButton: "Start",
        pauseButton: "Pause",
        resumeButton: "Resume",
        skipButton: "Skip",
        resetButton: "Reset",
        autoStartNext: "Start the next session automatically",
        sessionCompleteTitle: "Focus session complete",
        sessionCompleteBody: "Time for a break.",
        breakCompleteTitle: "Break’s over",
        breakCompleteBody: "Ready for another session?",
        statusWorkFormat: "Focus · %@",
        statusBreakFormat: "Break · %@",
        idleLabel: "Not running",
        sessionsTodayFormat: "%d sessions today"
    )

    static let ptBR = FocusTimerStrings(
        pageTitle: "Cronômetro de foco",
        hubDescription: "Uma contagem regressiva de trabalho e pausa na barra de menus, com um aviso ao fim de cada uma.",
        workLabel: "Sessão de foco",
        breakLabel: "Pausa",
        startButton: "Iniciar",
        pauseButton: "Pausar",
        resumeButton: "Continuar",
        skipButton: "Pular",
        resetButton: "Reiniciar",
        autoStartNext: "Iniciar a próxima sessão automaticamente",
        sessionCompleteTitle: "Sessão de foco concluída",
        sessionCompleteBody: "Hora de uma pausa.",
        breakCompleteTitle: "Pausa terminada",
        breakCompleteBody: "Pronto para outra sessão?",
        statusWorkFormat: "Foco · %@",
        statusBreakFormat: "Pausa · %@",
        idleLabel: "Parado",
        sessionsTodayFormat: "%d sessões hoje"
    )

    static let tr = FocusTimerStrings(
        pageTitle: "Odak zamanlayıcısı",
        hubDescription: "Menü çubuğunda çalışma ve mola geri sayımı, her biri bittiğinde bildirimle.",
        workLabel: "Odak oturumu",
        breakLabel: "Mola",
        startButton: "Başlat",
        pauseButton: "Duraklat",
        resumeButton: "Devam Et",
        skipButton: "Atla",
        resetButton: "Sıfırla",
        autoStartNext: "Sonraki oturumu otomatik başlat",
        sessionCompleteTitle: "Odak oturumu tamamlandı",
        sessionCompleteBody: "Mola zamanı.",
        breakCompleteTitle: "Mola bitti",
        breakCompleteBody: "Başka bir oturuma hazır mısınız?",
        statusWorkFormat: "Odak · %@",
        statusBreakFormat: "Mola · %@",
        idleLabel: "Çalışmıyor",
        sessionsTodayFormat: "Bugün %d oturum"
    )

    static let ru = FocusTimerStrings(
        pageTitle: "Таймер фокуса",
        hubDescription: "Обратный отсчёт работы и перерыва в строке меню, с уведомлением по завершении каждого.",
        workLabel: "Сессия фокуса",
        breakLabel: "Перерыв",
        startButton: "Начать",
        pauseButton: "Пауза",
        resumeButton: "Продолжить",
        skipButton: "Пропустить",
        resetButton: "Сбросить",
        autoStartNext: "Начинать следующую сессию автоматически",
        sessionCompleteTitle: "Сессия фокуса завершена",
        sessionCompleteBody: "Время для перерыва.",
        breakCompleteTitle: "Перерыв окончен",
        breakCompleteBody: "Готовы к ещё одной сессии?",
        statusWorkFormat: "Фокус · %@",
        statusBreakFormat: "Перерыв · %@",
        idleLabel: "Не запущен",
        sessionsTodayFormat: "Сегодня сессий: %d"
    )

    static let es = FocusTimerStrings(
        pageTitle: "Temporizador de enfoque",
        hubDescription: "Una cuenta regresiva de trabajo y descanso en la barra de menús, con un aviso al terminar cada una.",
        workLabel: "Sesión de enfoque",
        breakLabel: "Descanso",
        startButton: "Iniciar",
        pauseButton: "Pausar",
        resumeButton: "Reanudar",
        skipButton: "Saltar",
        resetButton: "Reiniciar",
        autoStartNext: "Iniciar la siguiente sesión automáticamente",
        sessionCompleteTitle: "Sesión de enfoque completada",
        sessionCompleteBody: "Hora de un descanso.",
        breakCompleteTitle: "Descanso terminado",
        breakCompleteBody: "¿Listo para otra sesión?",
        statusWorkFormat: "Enfoque · %@",
        statusBreakFormat: "Descanso · %@",
        idleLabel: "Detenido",
        sessionsTodayFormat: "%d sesiones hoy"
    )

    static let de = FocusTimerStrings(
        pageTitle: "Fokus-Timer",
        hubDescription: "Ein Arbeits- und Pausen-Countdown in der Menüleiste, mit einer Benachrichtigung am Ende jeder Phase.",
        workLabel: "Fokus-Sitzung",
        breakLabel: "Pause",
        startButton: "Start",
        pauseButton: "Pause",
        resumeButton: "Fortsetzen",
        skipButton: "Überspringen",
        resetButton: "Zurücksetzen",
        autoStartNext: "Nächste Sitzung automatisch starten",
        sessionCompleteTitle: "Fokus-Sitzung abgeschlossen",
        sessionCompleteBody: "Zeit für eine Pause.",
        breakCompleteTitle: "Pause vorbei",
        breakCompleteBody: "Bereit für eine weitere Sitzung?",
        statusWorkFormat: "Fokus · %@",
        statusBreakFormat: "Pause · %@",
        idleLabel: "Nicht aktiv",
        sessionsTodayFormat: "%d Sitzungen heute"
    )

    static let fr = FocusTimerStrings(
        pageTitle: "Minuteur de concentration",
        hubDescription: "Un compte à rebours de travail et de pause dans la barre de menus, avec une notification à la fin de chacun.",
        workLabel: "Session de concentration",
        breakLabel: "Pause",
        startButton: "Démarrer",
        pauseButton: "Suspendre",
        resumeButton: "Reprendre",
        skipButton: "Passer",
        resetButton: "Réinitialiser",
        autoStartNext: "Démarrer la session suivante automatiquement",
        sessionCompleteTitle: "Session de concentration terminée",
        sessionCompleteBody: "L’heure est à la pause.",
        breakCompleteTitle: "Pause terminée",
        breakCompleteBody: "Prêt pour une autre session ?",
        statusWorkFormat: "Concentration · %@",
        statusBreakFormat: "Pause · %@",
        idleLabel: "Arrêté",
        sessionsTodayFormat: "%d sessions aujourd’hui"
    )

    static let it = FocusTimerStrings(
        pageTitle: "Timer di concentrazione",
        hubDescription: "Un conto alla rovescia di lavoro e pausa nella barra dei menu, con una notifica alla fine di ciascuno.",
        workLabel: "Sessione di concentrazione",
        breakLabel: "Pausa",
        startButton: "Avvia",
        pauseButton: "Pausa",
        resumeButton: "Riprendi",
        skipButton: "Salta",
        resetButton: "Reimposta",
        autoStartNext: "Avvia automaticamente la sessione successiva",
        sessionCompleteTitle: "Sessione di concentrazione completata",
        sessionCompleteBody: "È ora di una pausa.",
        breakCompleteTitle: "Pausa terminata",
        breakCompleteBody: "Pronto per un’altra sessione?",
        statusWorkFormat: "Concentrazione · %@",
        statusBreakFormat: "Pausa · %@",
        idleLabel: "Non in esecuzione",
        sessionsTodayFormat: "%d sessioni oggi"
    )

    static let ja = FocusTimerStrings(
        pageTitle: "フォーカスタイマー",
        hubDescription: "メニューバーに作業と休憩のカウントダウンを表示し、それぞれの終了時に通知します。",
        workLabel: "フォーカスセッション",
        breakLabel: "休憩",
        startButton: "開始",
        pauseButton: "一時停止",
        resumeButton: "再開",
        skipButton: "スキップ",
        resetButton: "リセット",
        autoStartNext: "次のセッションを自動的に開始する",
        sessionCompleteTitle: "フォーカスセッション終了",
        sessionCompleteBody: "休憩の時間です。",
        breakCompleteTitle: "休憩終了",
        breakCompleteBody: "次のセッションを始めますか？",
        statusWorkFormat: "フォーカス · %@",
        statusBreakFormat: "休憩 · %@",
        idleLabel: "停止中",
        sessionsTodayFormat: "本日 %d セッション"
    )

    static let ko = FocusTimerStrings(
        pageTitle: "포커스 타이머",
        hubDescription: "메뉴 막대에 작업과 휴식 카운트다운을 표시하고, 각각이 끝나면 알림을 보냅니다.",
        workLabel: "포커스 세션",
        breakLabel: "휴식",
        startButton: "시작",
        pauseButton: "일시정지",
        resumeButton: "재개",
        skipButton: "건너뛰기",
        resetButton: "초기화",
        autoStartNext: "다음 세션 자동 시작",
        sessionCompleteTitle: "포커스 세션 완료",
        sessionCompleteBody: "휴식할 시간입니다.",
        breakCompleteTitle: "휴식 종료",
        breakCompleteBody: "다음 세션을 시작할까요?",
        statusWorkFormat: "포커스 · %@",
        statusBreakFormat: "휴식 · %@",
        idleLabel: "실행 중 아님",
        sessionsTodayFormat: "오늘 %d회 세션"
    )

    static let zhHans = FocusTimerStrings(
        pageTitle: "专注计时器",
        hubDescription: "在菜单栏显示工作与休息倒计时，每个阶段结束时通知您。",
        workLabel: "专注时段",
        breakLabel: "休息",
        startButton: "开始",
        pauseButton: "暂停",
        resumeButton: "继续",
        skipButton: "跳过",
        resetButton: "重置",
        autoStartNext: "自动开始下一时段",
        sessionCompleteTitle: "专注时段结束",
        sessionCompleteBody: "该休息一下了。",
        breakCompleteTitle: "休息结束",
        breakCompleteBody: "准备好开始下一时段了吗？",
        statusWorkFormat: "专注 · %@",
        statusBreakFormat: "休息 · %@",
        idleLabel: "未运行",
        sessionsTodayFormat: "今日已完成 %d 个时段"
    )

    static let zhTW = FocusTimerStrings(
        pageTitle: "專注計時器",
        hubDescription: "在選單列顯示工作與休息倒數計時，每個階段結束時通知您。",
        workLabel: "專注時段",
        breakLabel: "休息",
        startButton: "開始",
        pauseButton: "暫停",
        resumeButton: "繼續",
        skipButton: "略過",
        resetButton: "重設",
        autoStartNext: "自動開始下一時段",
        sessionCompleteTitle: "專注時段結束",
        sessionCompleteBody: "該休息一下了。",
        breakCompleteTitle: "休息結束",
        breakCompleteBody: "準備好開始下一時段了嗎？",
        statusWorkFormat: "專注 · %@",
        statusBreakFormat: "休息 · %@",
        idleLabel: "未執行",
        sessionsTodayFormat: "今日已完成 %d 個時段"
    )

    static let zhHK = FocusTimerStrings(
        pageTitle: "專注計時器",
        hubDescription: "喺選單列顯示工作同休息倒數計時，每個階段結束時通知您。",
        workLabel: "專注時段",
        breakLabel: "休息",
        startButton: "開始",
        pauseButton: "暫停",
        resumeButton: "繼續",
        skipButton: "略過",
        resetButton: "重設",
        autoStartNext: "自動開始下一時段",
        sessionCompleteTitle: "專注時段結束",
        sessionCompleteBody: "係時候休息一下。",
        breakCompleteTitle: "休息結束",
        breakCompleteBody: "準備好開始下一時段未？",
        statusWorkFormat: "專注 · %@",
        statusBreakFormat: "休息 · %@",
        idleLabel: "未執行",
        sessionsTodayFormat: "今日已完成 %d 個時段"
    )
}
