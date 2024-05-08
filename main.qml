import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 2.12
import QtQml 2.15

// Главное окно приложения
Window {
    id: root
    visible: true
    color: "#cccccc"
    width: 320
    height: 720

    // Коэфициенты растяжения для масштабирования интерфейса
    property int min: Math.min(width, height)
    property int max: Math.max(width, height)

    // Анимация для плавного изменения фона экрана с белого на темно-серый
    ColorAnimation on color {
        id: blanim
        to: "#262626"
        duration: 3000
    }

    // Группировка и позиционирование объектов в окне
    Item {
        id: positioningItem
        anchors.fill: parent

        // Поля логина и пароля, кнопка для гостевого входа и кнопка
        // информации о приложении
        ColumnLayout {
            id: clmfields
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: root.min / 25

            // Изображение логотипа
            Image {
                id: logo
                Layout.alignment: Qt.AlignHCenter
                sourceSize: Qt.size(root.min / 3, root.min / 4.5)
                source: "/graphic/logo/weigo.svg"


                /*
            // Logo fly out animation
            PropertyAnimation on x
            {
                id: flyout
                from: -root.width
                to: (root.width - logo.width) / 2
                duration: 3000
                easing.type: Easing.InOutCubic

                onFinished:
                {
                    logo.anchors.horizontalCenter = clmfields.anchors.horizontalCenter
                }
            }
            

            // Animation on logo visible
            PropertyAnimation on visible
            {
                from: false
                to: true
                duration: 500
            }

            */

                // Анимация вращения логотипа
                RotationAnimation {
                    id: logoanim
                    targets: [logo, playtxt]
                    from: 0
                    to: 360
                    duration: 1000
                    running: false
                    easing.type: Easing.InOutCubic
                }

                // Запуск анимации вращения логотипа при клике
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        logoanim.running = true
                    }
                }
            }

            // Текст под логотипом
            Text {
                id: playtxt
                text: qsTr("Play. Feel.")
                font.pixelSize: root.min / 15
                color: "white"
                Layout.alignment: Qt.AlignHCenter
                opacity: 0

                // Анимация изменения прозрачности текста под логотипом
                PropertyAnimation on opacity {
                    from: 0
                    to: 1
                    duration: 5000
                }
            }

            // Поле логина
            TextField {
                id: login
                width: root.min / 2
                height: root.max / 30
                placeholderText: qsTr("Логин")
                color: "black"
                EnterKey.type: Qt.Key_Enter
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                implicitWidth: logrect.width
                implicitHeight: logrect.height

                // Округлая облицовка поля
                background: Rectangle {
                    id: logrect
                    width: root.min / 2
                    height: root.max / 30
                    color: "white"
                    border.color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 10
                }
            }

            // Поле пароля
            TextField {
                id: password
                width: root.min / 2
                height: root.max / 30
                placeholderText: qsTr("Пароль")
                color: "black"
                EnterKey.type: Qt.Key_Enter
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                implicitWidth: passrect.width
                implicitHeight: passrect.height
                echoMode: TextInput.Password

                // Округлая облицовка поля
                background: Rectangle {
                    id: passrect
                    width: root.min / 2
                    height: root.max / 30
                    color: "white"
                    radius: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    border.color: "black"
                }

                // Кликабельный текст для восстановления пароля
                Text {
                    id: frgtxt
                    text: qsTr("Забыли?")
                    color: "white"
                    font.pixelSize: root.min / 30
                    anchors.top: parent.bottom
                    anchors.right: parent.right

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Клац!")
                        }
                    }
                }
            }

            // Кнопки входа для зарегистрированных пользователей и для гостей
            RowLayout {
                Layout.alignment: Qt.AlignCenter

                // Кнопка входа для зарегистрированных пользователей
                Button {
                    implicitWidth: gobttn.width
                    implicitHeight: gobttn.height

                    // Параметры фона кнопки
                    background: Rectangle {
                        id: gobttn
                        width: root.min / 10
                        height: root.max / 25
                        color: "white"
                        radius: 30
                        border.color: "black"

                        Text {
                            text: qsTr("GO")
                            anchors.centerIn: parent
                        }
                    }

                    // Анимация нажатия при клике на кнопку
                    SequentialAnimation {
                        id: goanim
                        running: false

                        PropertyAnimation {
                            property: "color"
                            target: gobttn
                            to: "grey"
                            duration: 100
                        }

                        PropertyAnimation {
                            property: "color"
                            target: gobttn
                            to: "white"
                            duration: 100
                        }

                        // По завершении анимации закрываем главное окно и открываем основное
                        // навигационное окно
                        onFinished: {
                            root.close()
                            var component = Qt.createComponent("/game.qml")
                            var window = component.createObject(root)
                            window.show()
                        }
                    }

                    // Запускаем анимацию при клике на кнопку
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            goanim.running = true;
                        }
                    }
                }

                // Кнопка входа для гостей
                Button {
                    text: qsTr("Войти как гость")

                    // Параметры фона кнопки
                    background: Rectangle {
                        id: signbttn
                        color: "white"
                        radius: 30
                        border.color: "black"
                    }

                    // Анимация нажатия при клике на кнопку
                    SequentialAnimation {
                        id: signanim
                        running: false

                        PropertyAnimation {
                            property: "color"
                            target: signbttn
                            to: "grey"
                            duration: 100
                        }

                        PropertyAnimation {
                            property: "color"
                            target: signbttn
                            to: "white"
                            duration: 100
                        }

                        // По завершении анимации закрываем главное окно и открываем основное
                        // навигационное окно
                        onFinished: {
                            var component = Qt.createComponent("/game.qml")
                            var window = component.createObject(root)
                            window.show()
                        }
                    }

                    // Запускаем анимацию при клике на кнопку
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            signanim.running = true;
                        }
                    }
                }
            }

            // Текст под кнопками входа для зарегистрированных пользователей и для гостей
            Text {
                id: nacctxt
                text: qsTr("Нет аккаунта?")
                color: "white"
                font.pixelSize: root.min / 25
                Layout.alignment: Qt.AlignHCenter
            }

            // Кнопка регистрации
            Button {
                text: qsTr("Регистрация")
                Layout.alignment: Qt.AlignHCenter

                // Параметры фона кнопки
                background: Rectangle {
                    id: regbttn
                    color: "white"
                    radius: 30
                    border.color: "black"
                }

                // Анимация нажатия при клике на кнопку
                SequentialAnimation {
                    id: reganim
                    running: false

                    PropertyAnimation {
                        property: "color"
                        target: regbttn
                        to: "grey"
                        duration: 100
                    }

                    PropertyAnimation {
                        property: "color"
                        target: regbttn
                        to: "white"
                        duration: 100
                    }

                    // По завершении анимации закрываем главное окно и открываем
                    // регистрационное окно
                    onFinished: {
                        var component = Qt.createComponent("/game.qml")
                        var window = component.createObject(root)
                        window.show()
                    }
                }

                // Запускаем анимацию при клике на кнопку
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        reganim.running = true;
                    }
                }
            }

            // Кнопка настроек
            Button {
                text: qsTr("Настройки")
                Layout.alignment: Qt.AlignHCenter

                // Параметры фона кнопки
                background: Rectangle {
                    id: settbttn
                    color: "white"
                    radius: 30
                    border.color: "black"
                }

                // Анимация нажатия при клике на кнопку
                SequentialAnimation {
                    id: setanim
                    running: false

                    PropertyAnimation {
                        property: "color"
                        target: settbttn
                        to: "grey"
                        duration: 100
                    }

                    PropertyAnimation {
                        property: "color"
                        target: settbttn
                        to: "white"
                        duration: 100
                    }

                    // По завершении анимации открываем окно настроек
                    onFinished: {
                        chkrct.visible = true
                        stvisible.running = true
                        settxtanim.running = true
                        positioningItem.visible = false
                    }
                }

                // Запускаем анимацию при клике на кнопку
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        setanim.running = true;
                    }
                }
            }

            // Информационная кнопка о приложении
            Button {
                text: qsTr("О приложении")
                Layout.alignment: Qt.AlignHCenter

                // Параметры фона кнопки
                background: Rectangle {
                    id: abbttn
                    color: "white"
                    radius: 30
                    border.color: "black"
                }

                // Анимация нажатия при клике на кнопку
                SequentialAnimation {
                    id: abanim
                    running: false

                    PropertyAnimation {
                        property: "color"
                        target: abbttn
                        to: "grey"
                        duration: 100

                    }

                    PropertyAnimation {
                        property: "color"
                        target: abbttn
                        to: "white"
                        duration: 100
                    }

                    // По завершении анимации открываем информационное окно
                    onFinished: {
                        abrct.visible = true
                        opvisible.running = true
                        positioningItem.visible = false
                    }
                }

                // Запускаем анимацию при клике на кнопку
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        abanim.running = true;
                    }
                }
            }
        }
    }

    // Информационное окно
    Rectangle {
        id: abrct
        width: root.width - root.min / 10
        height: root.max / 8 + (width / 2.4)
        color: "#1a1a1a"
        visible: false
        radius: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        // Кнопка для закрытия окна
        Image {
            id: abcross
            source: "/graphic/buttons/close.svg"
            sourceSize: Qt.size(root.min / 15, root.min / 15)
            x: root.min / 20
            y: root.max / 80

            // Анимация вращения кнопки
            RotationAnimation {
                id: abcrossanim
                target: abcross
                from: 0
                to: 360
                duration: 1000
                running: false
                easing.type: Easing.InOutCubic

                onFinished: {
                    abrct.visible = false
                    positioningItem.visible = true
                }
            }

            // Запускаем анимацию при клике на кнопку
            MouseArea {
                anchors.fill: parent

                onClicked: {
                    abcrossanim.running = true
                }
            }
        }

        // Вертикальная компоновка с информационным текстом
        Column {
            anchors.centerIn: parent

            Text {
                width: root.width / 1.5
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: root.min / 18
                wrapMode: Text.WordWrap
                color: "white"
                text: qsTr("Добро пожаловать!\n Это бесплатное приложение для игры в Го Weigo. Weigo открытый и бесплатный для всех желающих.")
            }
        }

        // Анимация для изменения прозрачности текста
        PropertyAnimation on opacity {
            id: opvisible
            from: 0
            to: 1
            duration: 1500
            running: false
        }
    }

    // Окно настроек приложения
    Rectangle {
        id: chkrct
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#1a1a1a"
        width: root.min / 1.2
        height: root.max / 2.5 + (width / 2.4)
        visible: false
        radius: 40

        // Кнопка для закрытия окна
        Image {
            id: stcross
            source: "/graphic/buttons/close.svg"
            sourceSize: Qt.size(root.min / 15, root.min / 15)
            x: root.min / 20
            y: root.max / 80

            // Анимация вращения кнопки
            RotationAnimation {
                id: stcrossanim
                target: stcross
                from: 0
                to: 360
                duration: 1000
                running: false
                easing.type: Easing.InOutCubic

                onFinished: {
                    chkrct.visible = false
                    positioningItem.visible = true
                }
            }

            // Запускаем анимацию при клике на кнопку
            MouseArea {
                anchors.fill: parent

                onClicked: {
                    stcrossanim.running = true
                }
            }
        }

        // Анимация изменения позиции окна настроек по оси Oy
        PropertyAnimation on y {
            id: stvisible
            from: root.height * 2
            to: root.height / 5
            duration: 600
            easing.type: Easing.InOutCubic
            running: false

            onFinished: {
                parent: root.Overlay.overlay
                chkrct.anchors.verticalCenter = root.verticalCenter
            }
        }

        // Компоновка с элементами выбора настроек
        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            spacing: root.min / 40

            // Заголовок текста настроек
            Text {
                id: settxt
                text: qsTr("Настройки")
                color: "white"
                font.pixelSize: root.min / 10
                Layout.alignment: Qt.AlignHCenter
                visible: true
                opacity: 0

                // Анимация для изменения прозрачности текста
                PropertyAnimation on opacity {
                    id: settxtanim
                    from: 0
                    to: 1
                    duration: 4000
                    running: false
                }
            }

            // Повторитель элементов выбора настроек
            Repeater {
                model: [qsTr("Выключить звук"), qsTr("Отключить глобальный чат"), qsTr("Показывать координаты доски"),
                    "Любой может пригласить меня играть", "Записывать мои игры",
                    "Отображать мое интернет-соединение",
                    "Предупреждать моих оппонентов о \nвозникших проблемах с соединением"]

                // Элементы выбора настроек
                CheckBox {
                    id: chkbttn
                    text: qsTr(modelData)
                    font.pixelSize: root.min / 40 - root.max / 40

                    // Параметры текста элементов
                    contentItem: Text {
                        text: chkbttn.text
                        font: chkbttn.font
                        color: "white"
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: chkbttn.indicator.width + chkbttn.spacing
                    }

                    // Параметры круглого индикатора выбора
                    indicator: Rectangle {
                        id: chckrect
                        width: root.min / 16
                        height: root.min / 16
                        radius: 100
                        border.color: chkbttn.down ? "#FFFFFF" : "#000000"
                        anchors.verticalCenter: chkbttn.verticalCenter

                        Rectangle {
                            width: root.min / 25
                            height: root.min / 25
                            anchors.centerIn: parent
                            radius: 100
                            color: chkbttn.down ? "#FFFFFF" : "#000000"
                            visible: chkbttn.checked
                        }
                    }
                }
            }

            // Кнопка сохранения настроек приложения
            Button
            {
                text: qsTr("Сохранить настройки")
                Layout.alignment: Qt.AlignHCenter

                // Параметры фона кнопки
                background: Rectangle {
                    id: savbttn
                    color: "white"
                    radius: 30
                    border.color: "black"
                }

                // Анимация нажатия при клике на кнопку
                SequentialAnimation {
                    id: savanim
                    running: false

                    PropertyAnimation {
                        property: "color"
                        target: savbttn
                        to: "grey"
                        duration: 100
                    }

                    PropertyAnimation {
                        property: "color"
                        target: savbttn
                        to: "white"
                        duration: 100
                    }

                    // По завершении анимации закрываем окно настроек
                    onFinished: {
                        // Save settings
                        chkrct.visible = false
                        positioningItem.visible = true
                    }
                }

                // Запускаем анимацию при клике на кнопку
                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        savanim.running = true;
                    }
                }
            }
        }
    }
}
