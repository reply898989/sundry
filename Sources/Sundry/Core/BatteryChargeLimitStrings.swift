// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

/// Strings for the battery charge limit feature. Same contract as the other
/// FeatureStrings structs: memberwise init with labeled arguments in
/// declaration order, one static per language, all in this file.
struct BatteryChargeLimitStrings {
    let pageTitle: String
    let hubDescription: String
    let experimentalBadge: String
    let experimentalWarning: String
    let enable: String
    let limitLabel: String             // "Stop charging at"
    let caption: String
    let statusHoldingFormat: String    // "Holding at %d%%"
    let statusChargingFormat: String   // "Charging to %d%%"
    let statusUnavailable: String
    let confirmTitle: String
    let confirmMessage: String
    let confirmEnableButton: String
    let cancelButton: String
}

extension FeatureStrings {
    static func batteryChargeLimit(_ language: AppLanguage) -> BatteryChargeLimitStrings {
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

extension BatteryChargeLimitStrings {
    static let enUS = BatteryChargeLimitStrings(
        pageTitle: "Battery charge limit",
        hubDescription: "Stops charging at a percentage you choose, to slow long-term battery wear.",
        experimentalBadge: "Experimental",
        experimentalWarning: "This writes to the battery controller directly and has only been tested on a limited set of Macs. Read the notes below before turning it on.",
        enable: "Limit charging",
        limitLabel: "Stop charging at",
        caption: "Sundry stops the flow of charge once the battery reaches this level; it does not force a discharge. Unplug and replug to charge past the limit once, for a trip.",
        statusHoldingFormat: "Holding at %d%%",
        statusChargingFormat: "Charging to %d%%",
        statusUnavailable: "Charge control isn’t available on this Mac.",
        confirmTitle: "Turn on the charge limit?",
        confirmMessage: "This feature writes directly to your Mac’s battery controller. It’s built on the same interface Apple’s own Optimized Battery Charging uses, but hasn’t been tested on every Mac model. If you notice anything unexpected, turn it off here immediately.",
        confirmEnableButton: "Turn On",
        cancelButton: "Cancel"
    )

    static let ptBR = BatteryChargeLimitStrings(
        pageTitle: "Limite de carga da bateria",
        hubDescription: "Interrompe o carregamento numa porcentagem à sua escolha, para desgastar menos a bateria a longo prazo.",
        experimentalBadge: "Experimental",
        experimentalWarning: "Isso grava diretamente no controlador da bateria e só foi testado num conjunto limitado de Macs. Leia as notas abaixo antes de ativar.",
        enable: "Limitar carregamento",
        limitLabel: "Parar de carregar em",
        caption: "O Sundry interrompe o fluxo de carga ao atingir este nível; ele não força uma descarga. Desconecte e reconecte para carregar além do limite uma vez, para uma viagem.",
        statusHoldingFormat: "Mantendo em %d%%",
        statusChargingFormat: "Carregando até %d%%",
        statusUnavailable: "O controle de carga não está disponível neste Mac.",
        confirmTitle: "Ativar o limite de carga?",
        confirmMessage: "Este recurso grava diretamente no controlador da bateria do seu Mac. Ele usa a mesma interface do Carregamento Otimizado da Apple, mas não foi testado em todos os modelos de Mac. Se notar algo inesperado, desative imediatamente aqui.",
        confirmEnableButton: "Ativar",
        cancelButton: "Cancelar"
    )

    static let tr = BatteryChargeLimitStrings(
        pageTitle: "Pil şarj sınırı",
        hubDescription: "Uzun vadeli pil aşınmasını yavaşlatmak için şarjı seçtiğiniz bir yüzdede durdurur.",
        experimentalBadge: "Deneysel",
        experimentalWarning: "Bu özellik doğrudan pil denetleyicisine yazar ve yalnızca sınırlı sayıda Mac’te test edilmiştir. Açmadan önce aşağıdaki notları okuyun.",
        enable: "Şarjı sınırla",
        limitLabel: "Şarjı şurada durdur",
        caption: "Sundry bu seviyeye ulaşınca şarj akışını durdurur; deşarj etmeye zorlamaz. Bir yolculuk için limiti aşarak şarj etmek üzere fişi çıkarıp tekrar takabilirsiniz.",
        statusHoldingFormat: "%%%d’de tutuluyor",
        statusChargingFormat: "%%%d’e şarj oluyor",
        statusUnavailable: "Bu Mac’te şarj denetimi kullanılamıyor.",
        confirmTitle: "Şarj sınırı açılsın mı?",
        confirmMessage: "Bu özellik doğrudan Mac’inizin pil denetleyicisine yazar. Apple’ın kendi Optimize Edilmiş Pil Şarjı ile aynı arabirim üzerine kuruludur, ancak her Mac modelinde test edilmemiştir. Beklenmedik bir şey fark ederseniz burada hemen kapatın.",
        confirmEnableButton: "Aç",
        cancelButton: "Vazgeç"
    )

    static let ru = BatteryChargeLimitStrings(
        pageTitle: "Ограничение заряда батареи",
        hubDescription: "Останавливает зарядку на выбранном вами проценте, замедляя долгосрочный износ батареи.",
        experimentalBadge: "Экспериментально",
        experimentalWarning: "Эта функция напрямую пишет в контроллер батареи и протестирована только на ограниченном наборе Mac. Прочитайте примечания ниже, прежде чем включать.",
        enable: "Ограничить зарядку",
        limitLabel: "Остановить зарядку на",
        caption: "Sundry останавливает поток заряда по достижении этого уровня; разряд принудительно не запускается. Отсоедините и подключите заново, чтобы зарядить сверх лимита один раз, для поездки.",
        statusHoldingFormat: "Удерживается на %d%%",
        statusChargingFormat: "Заряжается до %d%%",
        statusUnavailable: "Управление зарядом недоступно на этом Mac.",
        confirmTitle: "Включить ограничение заряда?",
        confirmMessage: "Эта функция пишет напрямую в контроллер батареи вашего Mac. Она построена на том же интерфейсе, что и собственная функция Apple «Оптимизированная зарядка батареи», но протестирована не на всех моделях Mac. Если заметите что-то необычное, сразу выключите её здесь.",
        confirmEnableButton: "Включить",
        cancelButton: "Отмена"
    )

    static let es = BatteryChargeLimitStrings(
        pageTitle: "Límite de carga de la batería",
        hubDescription: "Detiene la carga en un porcentaje que elijas, para reducir el desgaste de la batería a largo plazo.",
        experimentalBadge: "Experimental",
        experimentalWarning: "Esto escribe directamente en el controlador de la batería y solo se ha probado en un conjunto limitado de Mac. Lee las notas de abajo antes de activarlo.",
        enable: "Limitar la carga",
        limitLabel: "Detener la carga al",
        caption: "Sundry detiene el flujo de carga al alcanzar este nivel; no fuerza una descarga. Desconecta y vuelve a conectar para cargar más allá del límite una vez, para un viaje.",
        statusHoldingFormat: "Manteniendo en %d%%",
        statusChargingFormat: "Cargando hasta %d%%",
        statusUnavailable: "El control de carga no está disponible en este Mac.",
        confirmTitle: "¿Activar el límite de carga?",
        confirmMessage: "Esta función escribe directamente en el controlador de la batería de tu Mac. Se basa en la misma interfaz que usa la propia Carga optimizada de la batería de Apple, pero no se ha probado en todos los modelos de Mac. Si notas algo inusual, desactívala aquí de inmediato.",
        confirmEnableButton: "Activar",
        cancelButton: "Cancelar"
    )

    static let de = BatteryChargeLimitStrings(
        pageTitle: "Akku-Ladelimit",
        hubDescription: "Stoppt den Ladevorgang bei einem von dir gewählten Prozentsatz, um den langfristigen Akkuverschleiß zu verlangsamen.",
        experimentalBadge: "Experimentell",
        experimentalWarning: "Dies schreibt direkt auf den Akku-Controller und wurde nur an einer begrenzten Anzahl von Macs getestet. Lies die Hinweise unten, bevor du es aktivierst.",
        enable: "Laden begrenzen",
        limitLabel: "Laden stoppen bei",
        caption: "Sundry stoppt den Ladestrom, sobald der Akku dieses Niveau erreicht; es erzwingt keine Entladung. Zum Aufladen über das Limit hinaus (für eine Reise) einmal ab- und wieder anstecken.",
        statusHoldingFormat: "Gehalten bei %d%%",
        statusChargingFormat: "Lädt auf %d%%",
        statusUnavailable: "Ladesteuerung ist auf diesem Mac nicht verfügbar.",
        confirmTitle: "Ladelimit aktivieren?",
        confirmMessage: "Diese Funktion schreibt direkt auf den Akku-Controller deines Mac. Sie basiert auf derselben Schnittstelle wie Apples eigenes optimiertes Laden, wurde aber nicht mit jedem Mac-Modell getestet. Falls dir etwas Ungewöhnliches auffällt, schalte sie hier sofort aus.",
        confirmEnableButton: "Aktivieren",
        cancelButton: "Abbrechen"
    )

    static let fr = BatteryChargeLimitStrings(
        pageTitle: "Limite de charge de la batterie",
        hubDescription: "Arrête la charge à un pourcentage de votre choix, pour ralentir l’usure de la batterie à long terme.",
        experimentalBadge: "Expérimental",
        experimentalWarning: "Cette fonction écrit directement sur le contrôleur de batterie et n’a été testée que sur un nombre limité de Mac. Lisez les notes ci-dessous avant de l’activer.",
        enable: "Limiter la charge",
        limitLabel: "Arrêter la charge à",
        caption: "Sundry arrête le flux de charge une fois ce niveau atteint ; il ne force pas de décharge. Débranchez puis rebranchez pour charger au-delà de la limite une fois, pour un voyage.",
        statusHoldingFormat: "Maintenue à %d%%",
        statusChargingFormat: "Charge jusqu’à %d%%",
        statusUnavailable: "Le contrôle de charge n’est pas disponible sur ce Mac.",
        confirmTitle: "Activer la limite de charge ?",
        confirmMessage: "Cette fonction écrit directement sur le contrôleur de batterie de votre Mac. Elle repose sur la même interface que la Charge optimisée de la batterie d’Apple, mais n’a pas été testée sur tous les modèles de Mac. Si vous remarquez quoi que ce soit d’inhabituel, désactivez-la ici immédiatement.",
        confirmEnableButton: "Activer",
        cancelButton: "Annuler"
    )

    static let it = BatteryChargeLimitStrings(
        pageTitle: "Limite di carica della batteria",
        hubDescription: "Interrompe la carica a una percentuale scelta da te, per rallentare l’usura della batteria nel tempo.",
        experimentalBadge: "Sperimentale",
        experimentalWarning: "Questa funzione scrive direttamente sul controller della batteria ed è stata testata solo su un numero limitato di Mac. Leggi le note qui sotto prima di attivarla.",
        enable: "Limita la carica",
        limitLabel: "Interrompi la carica al",
        caption: "Sundry interrompe il flusso di carica al raggiungimento di questo livello; non forza una scarica. Scollega e ricollega per caricare oltre il limite una volta, per un viaggio.",
        statusHoldingFormat: "Mantenuta al %d%%",
        statusChargingFormat: "In carica fino al %d%%",
        statusUnavailable: "Il controllo della carica non è disponibile su questo Mac.",
        confirmTitle: "Attivare il limite di carica?",
        confirmMessage: "Questa funzione scrive direttamente sul controller della batteria del tuo Mac. Si basa sulla stessa interfaccia della Carica ottimizzata della batteria di Apple, ma non è stata testata su tutti i modelli di Mac. Se noti qualcosa di insolito, disattivala qui subito.",
        confirmEnableButton: "Attiva",
        cancelButton: "Annulla"
    )

    static let ja = BatteryChargeLimitStrings(
        pageTitle: "バッテリー充電制限",
        hubDescription: "選んだ割合で充電を止め、長期的なバッテリーの劣化を緩やかにします。",
        experimentalBadge: "試験的機能",
        experimentalWarning: "この機能はバッテリーコントローラーに直接書き込みます。限られた台数のMacでしかテストされていません。オンにする前に、以下の注意事項をお読みください。",
        enable: "充電を制限する",
        limitLabel: "充電を止める割合",
        caption: "Sundryはこの水準に達すると充電の流れを止めます。放電を強制するわけではありません。旅行などで一時的に制限を超えて充電したい場合は、一度電源を抜き差ししてください。",
        statusHoldingFormat: "%d%%で維持中",
        statusChargingFormat: "%d%%まで充電中",
        statusUnavailable: "このMacでは充電制御を利用できません。",
        confirmTitle: "充電制限をオンにしますか？",
        confirmMessage: "この機能はMacのバッテリーコントローラーに直接書き込みます。Apple純正の最適化されたバッテリー充電と同じ仕組みを利用していますが、すべてのMacモデルでテスト済みではありません。何か異常に気づいたら、ここですぐにオフにしてください。",
        confirmEnableButton: "オンにする",
        cancelButton: "キャンセル"
    )

    static let ko = BatteryChargeLimitStrings(
        pageTitle: "배터리 충전 제한",
        hubDescription: "선택한 비율에서 충전을 멈춰 장기적인 배터리 소모를 늦춥니다.",
        experimentalBadge: "실험적 기능",
        experimentalWarning: "이 기능은 배터리 컨트롤러에 직접 값을 씁니다. 제한된 수의 Mac에서만 테스트되었습니다. 켜기 전에 아래 안내를 읽어 주세요.",
        enable: "충전 제한하기",
        limitLabel: "충전 정지 비율",
        caption: "Sundry는 이 수준에 도달하면 충전 흐름을 멈출 뿐, 강제로 방전시키지 않습니다. 여행 등으로 제한을 넘겨 한 번 충전하려면 전원을 뽑았다가 다시 꽂으세요.",
        statusHoldingFormat: "%d%%로 유지 중",
        statusChargingFormat: "%d%%까지 충전 중",
        statusUnavailable: "이 Mac에서는 충전 제어를 사용할 수 없습니다.",
        confirmTitle: "충전 제한을 켤까요?",
        confirmMessage: "이 기능은 Mac의 배터리 컨트롤러에 직접 값을 씁니다. Apple의 최적화된 배터리 충전과 같은 인터페이스를 사용하지만 모든 Mac 모델에서 테스트되지는 않았습니다. 이상한 점을 발견하면 즉시 여기서 꺼 주세요.",
        confirmEnableButton: "켜기",
        cancelButton: "취소"
    )

    static let zhHans = BatteryChargeLimitStrings(
        pageTitle: "电池充电限制",
        hubDescription: "在您选择的百分比处停止充电，减缓电池的长期损耗。",
        experimentalBadge: "实验性功能",
        experimentalWarning: "此功能会直接写入电池控制器，仅在有限数量的 Mac 上测试过。开启前请阅读下方说明。",
        enable: "限制充电",
        limitLabel: "充电停止于",
        caption: "达到此水平后，Sundry 会停止充电，但不会强制放电。若因出行需要充满，可拔下电源再插上一次以突破限制。",
        statusHoldingFormat: "维持在 %d%%",
        statusChargingFormat: "正在充至 %d%%",
        statusUnavailable: "此 Mac 不支持充电控制。",
        confirmTitle: "要开启充电限制吗？",
        confirmMessage: "此功能会直接写入 Mac 的电池控制器。它使用的接口与 Apple 自带的“优化电池充电”相同，但并未在所有 Mac 机型上测试过。如发现任何异常，请立即在此关闭。",
        confirmEnableButton: "开启",
        cancelButton: "取消"
    )

    static let zhTW = BatteryChargeLimitStrings(
        pageTitle: "電池充電限制",
        hubDescription: "在您選擇的百分比停止充電，減緩電池的長期耗損。",
        experimentalBadge: "實驗性功能",
        experimentalWarning: "此功能會直接寫入電池控制器，僅在有限數量的 Mac 上測試過。開啟前請閱讀以下說明。",
        enable: "限制充電",
        limitLabel: "充電停止於",
        caption: "達到此水準後，Sundry 會停止充電，但不會強制放電。若因出差需要充滿，可拔下電源再插上一次以突破限制。",
        statusHoldingFormat: "維持在 %d%%",
        statusChargingFormat: "正在充至 %d%%",
        statusUnavailable: "這台 Mac 不支援充電控制。",
        confirmTitle: "要開啟充電限制嗎？",
        confirmMessage: "此功能會直接寫入 Mac 的電池控制器。它使用的介面與 Apple 內建的「最佳化電池充電」相同，但並未在所有 Mac 機型上測試過。如發現任何異常，請立即在此關閉。",
        confirmEnableButton: "開啟",
        cancelButton: "取消"
    )

    static let zhHK = BatteryChargeLimitStrings(
        pageTitle: "電池充電上限",
        hubDescription: "喺您選擇嘅百分比停止充電，減慢電池嘅長期耗損。",
        experimentalBadge: "實驗性功能",
        experimentalWarning: "呢個功能會直接寫入電池控制器，只喺有限數量嘅 Mac 上測試過。開啟前請閱讀以下說明。",
        enable: "限制充電",
        limitLabel: "充電停止於",
        caption: "達到呢個水平後，Sundry 會停止充電，但唔會強制放電。若因出行需要充滿，可以拔走電源再插一次以突破限制。",
        statusHoldingFormat: "維持喺 %d%%",
        statusChargingFormat: "正充至 %d%%",
        statusUnavailable: "呢部 Mac 唔支援充電控制。",
        confirmTitle: "要開啟充電限制嗎？",
        confirmMessage: "呢個功能會直接寫入您 Mac 嘅電池控制器。佢用緊嘅介面同 Apple 自家嘅「最佳化電池充電」一樣，但未喺所有 Mac 型號上測試過。如發現任何異常，請即刻喺呢度關閉。",
        confirmEnableButton: "開啟",
        cancelButton: "取消"
    )
}
