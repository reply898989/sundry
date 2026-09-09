// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2026 The Sundry project

import Foundation

/// Strings for saved window layout presets, a sub-feature of Window layout.
/// Same contract as the other FeatureStrings structs: memberwise init with
/// labeled arguments in declaration order, one static per language, all in
/// this file.
struct WindowLayoutPresetsStrings {
    let pageTitle: String
    let hubDescription: String
    let sectionTitle: String
    let caption: String
    let saveButton: String
    let saveNamePlaceholder: String
    let restoreTooltip: String
    let deleteTooltip: String
    let renameTooltip: String
    let emptyMessage: String
    let savedToastFormat: String       // "Saved “%@”"
    let restoredToastFormat: String    // "Restored “%@”"
    let deleteConfirmTitle: String
    let deleteConfirmMessage: String
    let deleteConfirmButton: String
    let cancelButton: String
    let windowCountFormat: String      // "%d windows"
}

extension FeatureStrings {
    static func windowLayoutPresets(_ language: AppLanguage) -> WindowLayoutPresetsStrings {
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

extension WindowLayoutPresetsStrings {
    static let enUS = WindowLayoutPresetsStrings(
        pageTitle: "Window layout presets",
        hubDescription: "Save a named window arrangement and restore every window to it with one click.",
        sectionTitle: "Presets",
        caption: "Captures the position and size of every window currently on screen, and restores all of them together.",
        saveButton: "Save current arrangement",
        saveNamePlaceholder: "Name this arrangement",
        restoreTooltip: "Restore this arrangement",
        deleteTooltip: "Delete",
        renameTooltip: "Rename",
        emptyMessage: "No saved arrangements yet. Arrange your windows the way you want, then save it.",
        savedToastFormat: "Saved “%@”",
        restoredToastFormat: "Restored “%@”",
        deleteConfirmTitle: "Delete this preset?",
        deleteConfirmMessage: "This only removes the saved arrangement. No windows are affected.",
        deleteConfirmButton: "Delete",
        cancelButton: "Cancel",
        windowCountFormat: "%d windows"
    )

    static let ptBR = WindowLayoutPresetsStrings(
        pageTitle: "Predefinições de layout de janelas",
        hubDescription: "Salve um arranjo de janelas com nome e restaure todas elas com um clique.",
        sectionTitle: "Predefinições",
        caption: "Registra a posição e o tamanho de cada janela na tela agora, e restaura todas juntas depois.",
        saveButton: "Salvar arranjo atual",
        saveNamePlaceholder: "Nome deste arranjo",
        restoreTooltip: "Restaurar este arranjo",
        deleteTooltip: "Excluir",
        renameTooltip: "Renomear",
        emptyMessage: "Nenhum arranjo salvo ainda. Organize suas janelas como quiser e salve.",
        savedToastFormat: "“%@” salvo",
        restoredToastFormat: "“%@” restaurado",
        deleteConfirmTitle: "Excluir esta predefinição?",
        deleteConfirmMessage: "Isso remove apenas o arranjo salvo. Nenhuma janela é afetada.",
        deleteConfirmButton: "Excluir",
        cancelButton: "Cancelar",
        windowCountFormat: "%d janelas"
    )

    static let tr = WindowLayoutPresetsStrings(
        pageTitle: "Pencere düzeni hazır ayarları",
        hubDescription: "Adlandırılmış bir pencere düzenini kaydedin ve tek tıkla tüm pencereleri o hale getirin.",
        sectionTitle: "Hazır ayarlar",
        caption: "Ekrandaki her pencerenin konumunu ve boyutunu kaydeder, sonra hepsini birlikte geri getirir.",
        saveButton: "Geçerli düzeni kaydet",
        saveNamePlaceholder: "Bu düzene bir ad verin",
        restoreTooltip: "Bu düzeni geri getir",
        deleteTooltip: "Sil",
        renameTooltip: "Yeniden adlandır",
        emptyMessage: "Henüz kaydedilmiş bir düzen yok. Pencerelerinizi istediğiniz gibi düzenleyip kaydedin.",
        savedToastFormat: "“%@” kaydedildi",
        restoredToastFormat: "“%@” geri getirildi",
        deleteConfirmTitle: "Bu hazır ayar silinsin mi?",
        deleteConfirmMessage: "Bu yalnızca kaydedilmiş düzeni kaldırır. Hiçbir pencere etkilenmez.",
        deleteConfirmButton: "Sil",
        cancelButton: "Vazgeç",
        windowCountFormat: "%d pencere"
    )

    static let ru = WindowLayoutPresetsStrings(
        pageTitle: "Пресеты расположения окон",
        hubDescription: "Сохраните расположение окон под именем и восстанавливайте его одним щелчком.",
        sectionTitle: "Пресеты",
        caption: "Запоминает положение и размер каждого открытого сейчас окна и восстанавливает их все разом.",
        saveButton: "Сохранить текущее расположение",
        saveNamePlaceholder: "Название расположения",
        restoreTooltip: "Восстановить это расположение",
        deleteTooltip: "Удалить",
        renameTooltip: "Переименовать",
        emptyMessage: "Сохранённых расположений пока нет. Расставьте окна как нужно и сохраните.",
        savedToastFormat: "«%@» сохранено",
        restoredToastFormat: "«%@» восстановлено",
        deleteConfirmTitle: "Удалить этот пресет?",
        deleteConfirmMessage: "Будет удалено только сохранённое расположение. Окна не затрагиваются.",
        deleteConfirmButton: "Удалить",
        cancelButton: "Отмена",
        windowCountFormat: "Окон: %d"
    )

    static let es = WindowLayoutPresetsStrings(
        pageTitle: "Preajustes de disposición de ventanas",
        hubDescription: "Guarda una disposición de ventanas con nombre y restáurala toda con un clic.",
        sectionTitle: "Preajustes",
        caption: "Registra la posición y el tamaño de cada ventana en pantalla ahora, y las restaura todas juntas.",
        saveButton: "Guardar disposición actual",
        saveNamePlaceholder: "Nombre de esta disposición",
        restoreTooltip: "Restaurar esta disposición",
        deleteTooltip: "Eliminar",
        renameTooltip: "Renombrar",
        emptyMessage: "Aún no hay disposiciones guardadas. Organiza tus ventanas como quieras y guárdalas.",
        savedToastFormat: "“%@” guardado",
        restoredToastFormat: "“%@” restaurado",
        deleteConfirmTitle: "¿Eliminar este preajuste?",
        deleteConfirmMessage: "Esto solo elimina la disposición guardada. Ninguna ventana se ve afectada.",
        deleteConfirmButton: "Eliminar",
        cancelButton: "Cancelar",
        windowCountFormat: "%d ventanas"
    )

    static let de = WindowLayoutPresetsStrings(
        pageTitle: "Fensteranordnungs-Voreinstellungen",
        hubDescription: "Speichere eine benannte Fensteranordnung und stelle alle Fenster mit einem Klick wieder her.",
        sectionTitle: "Voreinstellungen",
        caption: "Merkt sich Position und Größe jedes gerade geöffneten Fensters und stellt sie alle zusammen wieder her.",
        saveButton: "Aktuelle Anordnung speichern",
        saveNamePlaceholder: "Name für diese Anordnung",
        restoreTooltip: "Diese Anordnung wiederherstellen",
        deleteTooltip: "Löschen",
        renameTooltip: "Umbenennen",
        emptyMessage: "Noch keine gespeicherten Anordnungen. Ordne deine Fenster nach Wunsch an und speichere sie.",
        savedToastFormat: "„%@“ gespeichert",
        restoredToastFormat: "„%@“ wiederhergestellt",
        deleteConfirmTitle: "Diese Voreinstellung löschen?",
        deleteConfirmMessage: "Dadurch wird nur die gespeicherte Anordnung entfernt. Keine Fenster sind betroffen.",
        deleteConfirmButton: "Löschen",
        cancelButton: "Abbrechen",
        windowCountFormat: "%d Fenster"
    )

    static let fr = WindowLayoutPresetsStrings(
        pageTitle: "Préréglages de disposition des fenêtres",
        hubDescription: "Enregistrez une disposition de fenêtres nommée et restaurez-la toute entière en un clic.",
        sectionTitle: "Préréglages",
        caption: "Mémorise la position et la taille de chaque fenêtre actuellement à l’écran, puis les restaure toutes ensemble.",
        saveButton: "Enregistrer la disposition actuelle",
        saveNamePlaceholder: "Nom de cette disposition",
        restoreTooltip: "Restaurer cette disposition",
        deleteTooltip: "Supprimer",
        renameTooltip: "Renommer",
        emptyMessage: "Aucune disposition enregistrée pour l’instant. Organisez vos fenêtres à votre goût, puis enregistrez.",
        savedToastFormat: "« %@ » enregistrée",
        restoredToastFormat: "« %@ » restaurée",
        deleteConfirmTitle: "Supprimer ce préréglage ?",
        deleteConfirmMessage: "Seule la disposition enregistrée est supprimée. Aucune fenêtre n’est affectée.",
        deleteConfirmButton: "Supprimer",
        cancelButton: "Annuler",
        windowCountFormat: "%d fenêtres"
    )

    static let it = WindowLayoutPresetsStrings(
        pageTitle: "Preimpostazioni di disposizione finestre",
        hubDescription: "Salva una disposizione di finestre con un nome e ripristinala tutta con un clic.",
        sectionTitle: "Preimpostazioni",
        caption: "Registra la posizione e le dimensioni di ogni finestra attualmente sullo schermo e le ripristina tutte insieme.",
        saveButton: "Salva disposizione attuale",
        saveNamePlaceholder: "Nome di questa disposizione",
        restoreTooltip: "Ripristina questa disposizione",
        deleteTooltip: "Elimina",
        renameTooltip: "Rinomina",
        emptyMessage: "Nessuna disposizione salvata ancora. Disponi le finestre come preferisci, poi salvale.",
        savedToastFormat: "“%@” salvata",
        restoredToastFormat: "“%@” ripristinata",
        deleteConfirmTitle: "Eliminare questa preimpostazione?",
        deleteConfirmMessage: "Verrà rimossa solo la disposizione salvata. Nessuna finestra viene toccata.",
        deleteConfirmButton: "Elimina",
        cancelButton: "Annulla",
        windowCountFormat: "%d finestre"
    )

    static let ja = WindowLayoutPresetsStrings(
        pageTitle: "ウインドウレイアウトのプリセット",
        hubDescription: "名前を付けてウインドウの配置を保存し、ワンクリックですべてのウインドウを元に戻します。",
        sectionTitle: "プリセット",
        caption: "画面上のすべてのウインドウの位置とサイズを記録し、あとでまとめて復元します。",
        saveButton: "現在の配置を保存",
        saveNamePlaceholder: "この配置の名前",
        restoreTooltip: "この配置を復元",
        deleteTooltip: "削除",
        renameTooltip: "名前を変更",
        emptyMessage: "保存された配置はまだありません。ウインドウを好きなように配置してから保存してください。",
        savedToastFormat: "「%@」を保存しました",
        restoredToastFormat: "「%@」を復元しました",
        deleteConfirmTitle: "このプリセットを削除しますか？",
        deleteConfirmMessage: "保存された配置のみが削除されます。ウインドウには影響しません。",
        deleteConfirmButton: "削除",
        cancelButton: "キャンセル",
        windowCountFormat: "%d 個のウインドウ"
    )

    static let ko = WindowLayoutPresetsStrings(
        pageTitle: "창 배치 프리셋",
        hubDescription: "이름을 붙여 창 배치를 저장하고, 한 번의 클릭으로 모든 창을 그 배치로 되돌립니다.",
        sectionTitle: "프리셋",
        caption: "현재 화면의 모든 창 위치와 크기를 기록해 두었다가 나중에 한꺼번에 복원합니다.",
        saveButton: "현재 배치 저장",
        saveNamePlaceholder: "이 배치의 이름",
        restoreTooltip: "이 배치 복원",
        deleteTooltip: "삭제",
        renameTooltip: "이름 바꾸기",
        emptyMessage: "저장된 배치가 아직 없습니다. 창을 원하는 대로 배치한 다음 저장하세요.",
        savedToastFormat: "“%@” 저장됨",
        restoredToastFormat: "“%@” 복원됨",
        deleteConfirmTitle: "이 프리셋을 삭제할까요?",
        deleteConfirmMessage: "저장된 배치만 제거됩니다. 창에는 영향이 없습니다.",
        deleteConfirmButton: "삭제",
        cancelButton: "취소",
        windowCountFormat: "창 %d개"
    )

    static let zhHans = WindowLayoutPresetsStrings(
        pageTitle: "窗口布局预设",
        hubDescription: "为一组窗口排列命名并保存，一键即可把所有窗口恢复到该排列。",
        sectionTitle: "预设",
        caption: "记录当前屏幕上每个窗口的位置和大小，之后可一起恢复。",
        saveButton: "保存当前排列",
        saveNamePlaceholder: "为此排列命名",
        restoreTooltip: "恢复此排列",
        deleteTooltip: "删除",
        renameTooltip: "重命名",
        emptyMessage: "还没有已保存的排列。按您喜欢的方式排列窗口，然后保存。",
        savedToastFormat: "已保存“%@”",
        restoredToastFormat: "已恢复“%@”",
        deleteConfirmTitle: "删除此预设？",
        deleteConfirmMessage: "只会移除已保存的排列，不会影响任何窗口。",
        deleteConfirmButton: "删除",
        cancelButton: "取消",
        windowCountFormat: "%d 个窗口"
    )

    static let zhTW = WindowLayoutPresetsStrings(
        pageTitle: "視窗版面預設集",
        hubDescription: "為一組視窗排列命名並儲存，一鍵即可將所有視窗恢復成該排列。",
        sectionTitle: "預設集",
        caption: "記錄目前螢幕上每個視窗的位置與大小，之後可一併還原。",
        saveButton: "儲存目前排列",
        saveNamePlaceholder: "為此排列命名",
        restoreTooltip: "還原此排列",
        deleteTooltip: "刪除",
        renameTooltip: "重新命名",
        emptyMessage: "尚未儲存任何排列。依您喜歡的方式排列視窗，然後儲存。",
        savedToastFormat: "已儲存「%@」",
        restoredToastFormat: "已還原「%@」",
        deleteConfirmTitle: "刪除此預設集？",
        deleteConfirmMessage: "只會移除已儲存的排列，不會影響任何視窗。",
        deleteConfirmButton: "刪除",
        cancelButton: "取消",
        windowCountFormat: "%d 個視窗"
    )

    static let zhHK = WindowLayoutPresetsStrings(
        pageTitle: "視窗版面預設",
        hubDescription: "為一組視窗排列命名並儲存，一鍵即可將所有視窗還原成該排列。",
        sectionTitle: "預設",
        caption: "記錄目前螢幕上每個視窗嘅位置同大小，之後可以一齊還原。",
        saveButton: "儲存目前排列",
        saveNamePlaceholder: "為呢個排列命名",
        restoreTooltip: "還原呢個排列",
        deleteTooltip: "刪除",
        renameTooltip: "重新命名",
        emptyMessage: "仲未有儲存嘅排列。將視窗排列成您想要嘅樣子，然後儲存。",
        savedToastFormat: "已儲存「%@」",
        restoredToastFormat: "已還原「%@」",
        deleteConfirmTitle: "刪除呢個預設？",
        deleteConfirmMessage: "只會移除已儲存嘅排列，唔會影響任何視窗。",
        deleteConfirmButton: "刪除",
        cancelButton: "取消",
        windowCountFormat: "%d 個視窗"
    )
}
