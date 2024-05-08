import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQml 2.15

// Окно навигации приложения
Window
{
    id: root
    visible: true
    color: "#262626"
    width: 320
    height: 720

    // Коэфициенты растяжения для масштабирования интерфейса
    property int min: Math.min(width, height)
    property int max: Math.max(width, height)

    // Список для перехода к другим окнам
    property variant pages: ["/game.qml", "/game.qml", "/game.qml", "/game.qml"]

    // Основной элемент прямоугольника, содержащий остальные элементы
    Rectangle {
        id: rect
        width: root.width
        focus: true

        // При нажатии кнопки возврата назад закрываем текущее окно и открываем предыдущее
       // Keys.onPressed: event => {
        //    if (event.key === Qt.Key_Backspace || event.key === Qt.Key_Back) {
        //        root.close()
        //        var component = Qt.createComponent("/main.qml")
       //         var window = component.createObject(root)
       ///         window.show()
       //     }
      //  }

        // Вертикальная компоновка заголовка и элементов ссылок на окна
        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter

            // Заголовок для навигационного списка
            Text {
                id: navtxt
                text: qsTr("Навигация")
                font.pixelSize: root.min / 12
                color: "white"
                visible: true
                opacity: 0
                Layout.alignment: Qt.AlignHCenter

                // Анимация для изменения прозрачности текста
                PropertyAnimation on opacity {
                    from: 0
                    to: 1
                    duration: 3000
                    running: true
                }
            }

            // Прямоугольник с компоновкой элементов выбора ссылок на окна
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: root.min / 1.2
                implicitHeight: root.max / 1.09 - (width / 60)
                radius: 40
                color: "white"

                // Вертикальная компоновка элементов ссылок на окна
                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10

                    // Текстовый навигационный подзаголовок
                    Text {
                        text: qsTr("Куда пойдем?")
                        font.pixelSize: root.min / 14
                        Layout.alignment: Qt.AlignHCenter
                        color: "black"
                    }

                    // Повторитель кнопок перехода в другие окна
                    Repeater {
                        id: rptrms

                        model: ["Игровые комнаты", "Чат-комнаты", "Одиночная игра", "Настройки профиля",
                                "Архив партий", "Тегированные партии", "Статистика по турнирам", "Игроки в онлайне",
                                "Уроки Го", "Задачник", "Группы сообщества", "Мотивация"]

                        // Стилизованная кнопка перехода
                        Rectangle {
                            id: intbttn2

                            Text {
                                text: qsTr(modelData)
                                color: "white"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            gradient: Gradient {
                                orientation: Gradient.Horizontal

                                GradientStop {
                                    position: 0.03;
                                    color: "darkgrey"
                                }

                                GradientStop {
                                    position: 0.08;
                                    color: "black"
                                }

                                GradientStop {
                                    position: 0.92;
                                    color: "black"
                                }

                                GradientStop {
                                    position: 0.97;
                                    color: "darkgrey"
                                }
                            }

                            // Визуальный указатель на выбранную ссылку перехода
                            Image {
                                id: triangl2
                                anchors.verticalCenter: parent.verticalCenter
                                x: parent.width
                                width: root.min / 15
                                height: root.min / 16
                                source: "/graphic/triangle/triangle.svg"
                                visible: false
                            }

                            // Анимация нажатия при клике на кнопку
                            SequentialAnimation {
                                id: goanim2
                                running: false

                                PropertyAnimation {
                                    property: "opacity"
                                    target: intbttn2
                                    from: 0
                                    to: 1
                                    duration: 300
                                }

                                // По завершении анимации закрываем окно навигации и
                                // перемещаемся в другое выбранное окно
                                onFinished: {
                                    triangl2.visible = false

                                    root.close()
                                    var component = Qt.createComponent(pages[index])
                                    var window = component.createObject(root)
                                    window.show()
                                }
                            }

                            implicitWidth: root.min / 2
                            implicitHeight: root.max / 18
                            radius: 40
                            Layout.alignment: Qt.AlignHCenter

                            // Делаем визуальный указатель на выбранную ссылку видимым
                            // при нажатии на неё
                            MouseArea {
                                anchors.fill: parent

                                onClicked:
                                {
                                    triangl2.visible = true
                                    goanim2.running = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
