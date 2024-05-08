import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.0
import QtQuick.Layouts 1.12
import QtQml 2.15
import QtQml.Models

//import com.weigo.GoBoard 1.0

// Данный компонент QML занимается непосредственно отрисовкой доски, координат

Window
{
    id: root
    color: "#262626"
    width: dp(320)
    height: dp(720)

    // Коэфициенты растяжения для масштабирования интерфейса
    property int min: Math.min(width, height)
    property int max: Math.max(width, height)

    // Current stone color, odd - black; even - white
    property int currentPosition: 0
    property var lastCoords: [0, 0];
    property int lastPos: -10
    property int whiteCaptives: 0
    property int blackCaptives: 0
    property int manipulatorFlag: 1
    property int xPos: 0
    property int yPos: 0
    property bool soundOn: true
    property int dpi: Screen.pixelDensity * 25.4

    function dp(x){
            if(dpi < 120) {
                return x; // Для обычного монитора компьютера
            } else {
                return x*(dpi/160);
            }
        }

    property variant coordinates_x: []
    property variant coordinates_y: []


    // Создаем доску с графическими изображениями камней 21x21 (стандартная доска 19x19, с дополнительными
    // 80 пунктами поверх неё для поддержания невидимых граничных камней - искусственный шаг для убийства
    // угловых камней и камней, стоящих вплотную к сторонам доски)
    property variant stoneMatrix:      [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]
    property variant coordinateMatrix: [[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]]

    property string currentManipulator: "/graphic/manipulators/blhand.svg"




    Rectangle
    {
        id: brrect
        anchors.fill: parent
        color: root.color
        focus: true

        PinchArea {
            id: pinchboard
            anchors.fill: parent
            pinch.target: boardborder
            pinch.minimumScale: 0.1
            pinch.maximumScale: 10
            pinch.dragAxis: Pinch.XAndYAxis
        }

//        Keys.onPressed: event => {
//                            if (event.key === Qt.Key_Backspace || event.key === Qt.Key_Back) {
//                                root.close()
//                                var component = Qt.createComponent("/rooms.qml")
//                                var window = component.createObject(root)
//                                window.show()
//                            }
//                        }







        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            RowLayout
            {
                //Layout.bottomMargin: 10000
                Layout.alignment: Qt.AlignHCenter
                spacing: dp(20)

                Rectangle {
                    color: "white"
                    width: dp(60)
                    height: dp(60)
                    radius: 100
                    Layout.alignment: Qt.AlignBottom
                   // Layout.bottomMargin: 10000

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("White: " + whiteCaptives)
                        color: "black"
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                    }
                }

                Rectangle {
                    color: "black"
                    width: dp(60)
                    height: dp(60)
                    radius: 100
                    Layout.alignment: Qt.AlignBottom
                    //Layout.bottomMargin: 10000

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("Black: " + blackCaptives)
                        color: "white"
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                    }
                }
            }




            Rectangle {
                id: boardborder
                color: "#f2b06d"
                border.color: "black"
                radius: 10
                implicitWidth: root.min / 1.02
                implicitHeight: root.min / 1.02
                antialiasing: true


                Rectangle {
                    id: gamefield
                    color: "#f2b06d"
                    border.color: "black"
                    anchors.centerIn: parent

                    implicitWidth: root.min / 1.1
                    implicitHeight: root.min / 1.1

                    Canvas {
                        id: canvgrid

                        renderStrategy: Canvas.Cooperative
                        width: parent.implicitWidth
                        height: parent.implicitHeight

                        onPaint: {
                            //canvgrid.requestPaint()
                            var context = getContext("2d")


                            context.lineWidth = 1.2
                            context.strokeStyle = "black"
                            context.beginPath()


                            var cols = 19

                            for (var i = 0; i < cols; i++) {
                                context.moveTo(i * root.min / 19.8, 0);
                                context.lineTo(i * root.min / 19.8, height);
                                context.moveTo(0, i * root.min / 19.8);
                                context.lineTo(width, i * root.min / 19.8);
                            }

                            context.roundedRect(root.min / 7, root.min / 7.06, root.min / 60, root.min / 60, 100, 100)
                            context.roundedRect(root.min / 2.241, root.min / 7.06, root.min / 60, root.min / 60, 100, 100)
                            context.roundedRect(root.min / 1.335, root.min / 7.06, root.min / 60, root.min / 60, 100, 100)

                            context.roundedRect(root.min / 7, root.min / 2.24, root.min / 60, root.min / 60, 100, 100)
                            context.roundedRect(root.min / 2.241, root.min / 2.24, root.min / 60, root.min / 60, 100, 100)
                            context.roundedRect(root.min / 1.335, root.min / 2.24, root.min / 60, root.min / 60, 100, 100)

                            context.roundedRect(root.min / 7, root.min / 1.335, root.min / 60, root.min / 60, 100, 100)
                            context.roundedRect(root.min / 2.241, root.min / 1.335, root.min / 60, root.min / 60, 100, 100)
                            context.roundedRect(root.min / 1.335, root.min / 1.335, root.min / 60, root.min / 60, 100, 100)

                            context.fill()
                            context.stroke()

                        }






                    }


                    Component.onCompleted: {
                        for (var i = 0; i < 21; i++) {
                            for (var k = 0; k < 21; k++) {
                                stoneGrid.model.append({})
                                stoneMatrix[i][k] = -1
                            }
                        }
                    }

//                    Text
//                    {
//                        anchors.bottom: parent.bottom
//                        rightPadding: 30

//                        text: "A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T"
//                        font.pixelSize: 10
//                    }



                    Rectangle
                    {
                        width: parent.implicitWidth + root.min / dp(25)
                        height: parent.implicitHeight
                        color: "transparent"

                        GridView {
                            id: stoneGrid
                            anchors.fill: parent
                            interactive: false

                            anchors.margins: -root.min / dp(39.75)
                            cellHeight: root.min / dp(19.8)
                            cellWidth: root.min / dp(19.8)

                            model: ListModel {}

                            delegate: Rectangle {
                                visible: false
                                width: root.min / dp(19.8)
                                height: root.min / dp(19.8)
                                color: "black"
                                radius: 100
                                border.color: "black"
                            }
                        }




                    }


                    Image {
                        id: manipulator
                        width: root.min / dp(1.4)
                        height: root.min / dp(1.05)
                        x: dp(point1.x) - root.min / dp(1.5)
                        y: dp(point1.y) - root.min / dp(1.15)
                        source: root.currentManipulator
                        visible: false

                        Shape {
                            ShapePath {
                                id: shapePath
                                strokeColor: "black"
                                strokeStyle: ShapePath.DashLine
                                dashPattern: [6, 8]
                                fillColor: "transparent"
                                strokeWidth: 1.8

                                PathAngleArc {
                                    centerX: 0.795 * Math.abs(dp(point1.y) / dp(2) - dp(manipulator.y) / dp(2))
                                    centerY: Math.abs(dp(point1.y) / dp(3.5) - dp(manipulator.y) / dp(3.5))
                                   // centerY: point1.y
                                  //  centerX: Math.sqrt(Math.pow(point1.x - manipulator.x, 2) + Math.pow(point1.y - manipulator.x, 2))
                                 //   centerY: Math.sqrt(Math.pow(point1.x - manipulator.x, 2) + Math.pow(point1.y - manipulator.y, 2))

                                    radiusX: root.min / dp(35);
                                    radiusY: root.min / dp(35);

                                    NumberAnimation on startAngle {
                                        from: 0
                                        to: 720
                                        duration: 3000
                                        easing.type: Easing.OutInQuint
                                        loops: Animation.Infinite
                                        running: true
                                    }

                                    NumberAnimation on sweepAngle {
                                        from: -720
                                        to: 0
                                        duration: 3000
                                        easing.type: Easing.OutInQuint
                                        loops: Animation.Infinite
                                        running: true
                                    }
                                }

                                PathAngleArc {
                                    centerX: 0.795 * Math.abs(point1.y / 2 - manipulator.y / 2)
                                    centerY: Math.abs(point1.y / 3.5 - manipulator.y / 3.5)

                                    radiusX: root.min / dp(35);
                                    radiusY: root.min / dp(35);

                                    NumberAnimation on startAngle {
                                        from: -720
                                        to: 0
                                        duration: 3000
                                        easing.type: Easing.InCirc
                                        loops: Animation.Infinite
                                        running: true
                                    }

                                    NumberAnimation on sweepAngle {
                                        from: 0
                                        to: 720
                                        duration: 3000
                                        easing.type: Easing.InCirc
                                        loops: Animation.Infinite
                                        running: true
                                    }

                                }
                            }
                        }
                    }



                    Rectangle {
                        id: playArea
                        color: "transparent"
                        anchors.centerIn: parent
                        radius: 10
                        implicitWidth: root.min / dp(0.65)
                        implicitHeight: root.min / dp(0.65)
                        antialiasing: true
                    }



                    MultiPointTouchArea {
                        id: multiPoint1
                        anchors.fill: playArea

                        touchPoints: [
                            TouchPoint
                            {
                                id: point1
                            },

                            TouchPoint
                            {
                                id: point2
                            }


                        ]


                        onTouchUpdated:
                        {
                            console.log('3')
                            if (point2.pressed)
                            {
                                manipulator.visible = false
                                return
                            }

                            if (point1.pressed)
                            {
                                var xx, yy, dpxx, dpyy, stone;
                                if (manipulatorFlag === 1)
                                {
                                    manipulator.visible = true
                                    xx = dp(point1.x) - root.min / 3.4
                                    yy = dp(point1.y) - root.min / 1.68
                                }
                                else
                                {
                                    xx = dp(point1.x) - root.min / 3.45
                                    yy = dp(point1.y) - root.min / 3.4
                                }




                                // NEW CODE



                                dpxx = dp(xx) - dp(xx) / 50
                                dpyy = dp(yy) + dp(yy) / 50

                                //console.log(xx, yy)


                                var stoneIndex = stoneGrid.indexAt(dpxx, dpyy)

                                if (stoneGrid.itemAt(dpxx, dpyy) === null ||
                                        stoneGrid.itemAt(dpxx, dpyy).visible === true
                                        || stoneIndex > 360)
                                    return

                                var previousStone = stoneGrid.itemAt(root.lastCoords[0], root.lastCoords[1])

                                if (previousStone === null)
                                {
                                    stone = stoneGrid.itemAt(dpxx, dpyy)
                                    stone.visible = false

                                    return
                                }


                                var equal_1 = !(Math.abs(xx - root.lastCoords[0]) < Number.EPSILON);
                                var equal_2 = !(Math.abs(yy - root.lastCoords[1]) < Number.EPSILON);

                                if (root.currentPosition % 2 === 0)
                                {
                                    stone = stoneGrid.itemAt(dpxx, dpyy)

                                    // ПРОБЛЕМА! Ставит прозрачный камень и передает управление другому цвету
                                    if ((stone.visible !== true || stone.opacity !== 1))
                                    {
                                        stone.color = "black"
                                        stone.visible = true
                                        stone.opacity = 0.5
                                    }


                                    if (equal_1 && equal_2)
                                    {

                                        if (previousStone.opacity !== 1)
                                            previousStone.visible = false



                                    }


                                    root.lastCoords[0] = dpxx
                                    root.lastCoords[1] = dpyy

                                }
                                else
                                {
                                    stone = stoneGrid.itemAt(dpxx, dpyy)

                                    if ((stone.visible !== true || stone.opacity !== 1))
                                    {
                                        stone.color = "white"
                                        stone.visible = true
                                        stone.opacity = 0.5
                                    }


                                    if (equal_1 && equal_2)
                                    {

                                        if (previousStone.opacity !== 1)
                                            previousStone.visible = false



                                    }


                                    root.lastCoords[0] = dpxx
                                    root.lastCoords[1] = dpyy
                                }

                            }

                        }


                        onReleased:
                        {




                            manipulator.visible = false
                            if (point2.pressed)
                                return
                            if (!point1.pressed) {

                                var xx, yy;

                                if (manipulatorFlag === 1)
                                {
                                    xx = dp(point1.x) - root.min / 3.4
                                    yy = dp(point1.y) - root.min / 1.68
                                }
                                else
                                {
                                    xx = dp(point1.x) - root.min / 3.45
                                    yy = dp(point1.y) - root.min / 3.4
                                }

                                var dpxx = dp(xx) - dp(xx) / 50
                                var dpyy = dp(yy) + dp(yy) / 50

                                var current = stoneGrid.itemAt(dpxx, dpyy)





                                var stoneIndex = stoneGrid.indexAt(dpxx, dpyy)

                                if (stoneGrid.itemAt(dpxx, dpyy) === null)
                                    return


                                if (current.opacity !== 1)
                                {
                                    current.opacity = 1
                                    current.visible = false
                                }



                                if (stoneGrid.itemAt(dpxx, dpyy).visible === true || stoneIndex > 360)
                                    return

                                root.coordinates_x[root.currentPosition] = dpxx
                                root.coordinates_y[root.currentPosition] = dpyy

                                for (var h = 0; h < 21; h++)
                                    for (var m = 0; m < 21; m++)
                                        if (m == 0 || m == 20 || h == 0 || h == 20)
                                            stoneMatrix[h][m] = root.currentPosition % 2


                               // var stoneIndex = stoneGrid.indexAt(xx, yy)

                                var currentStoneIndex = stoneIndex

                                while (currentStoneIndex >= 19) {
                                    currentStoneIndex -= 19
                                    stoneIndex += 2
                                }

                                stoneIndex += 22

                               // console.log(stoneIndex)

                                // Evaluating indexes for 2d array
                                var k = 0, j = 0
                                for (var i = 0; i < stoneIndex; i++) {
                                    if (j < 20) {
                                        j++;
                                    }
                                    else {
                                        k++;
                                        j = 0;
                                    }
                                }

                                if (root.currentPosition % 2 === 0) {
                                    var black_stone = stoneGrid.itemAt(dpxx, dpyy)
                                    black_stone.color = "black"
                                    black_stone.visible = true
                                    root.currentManipulator = "/graphic/manipulators/whhand.svg"
                                    shapePath.strokeColor = "white"
                                    stoneMatrix[k][j] = 1
                                    coordinateMatrix[k][j] = black_stone
                                }
                                else {
                                    var white_stone = stoneGrid.itemAt(dpxx, dpyy)
                                    white_stone.color = "white"
                                    white_stone.visible = true
                                    root.currentManipulator = "/graphic/manipulators/blhand.svg"
                                    shapePath.strokeColor = "black"
                                    stoneMatrix[k][j] = 0
                                    coordinateMatrix[k][j] = white_stone
                                }

                                console.log(typeof(stoneMatrix))

                                if (root.currentPosition % 2 === 0)
                                    goBoard.makeRules(stoneMatrix, k, j, stoneIndex, 1)
                                else
                                    goBoard.makeRules(stoneMatrix, k, j, stoneIndex, 0)

                                root.currentPosition += 1

                            }
                        }





                        PinchHandler
                        {
                            id: pinchboardHandler
                            target: boardborder

                            minimumRotation: 0
                            maximumRotation: 0

                            onUpdated:
                            {
                                manipulator.visible = false
                            }


                        }
                        mouseEnabled: true

                    }




                }
            }

            RowLayout
            {
                spacing: 30
                Layout.alignment: Qt.AlignHCenter
                Rectangle
                {
                    color: "white"
                    width: 50
                    height: 50
                    radius: 100

                    visible: true

                    Text {
                        anchors.centerIn: parent
                        text: qsTr("Undo")
                        color: "black"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            // Высчитываем позицию положения камня на доске
                            if (root.currentPosition > 0) {
                                var stone = stoneGrid.itemAt(root.coordinates_x[root.currentPosition - 1], root.coordinates_y[root.currentPosition - 1])
                                var stoneIndex = stoneGrid.indexAt(root.coordinates_x[root.currentPosition - 1], root.coordinates_y[root.currentPosition - 1])
                                stone.visible = false

                                var currentStoneIndex = stoneIndex

                                while (currentStoneIndex >= 19) {
                                    currentStoneIndex -= 19
                                    stoneIndex += 2
                                }

                                stoneIndex += 22
                                console.log(stoneIndex)

                                // Вычисляем индексы матрицы индексов камней
                                var k = 0, j = 0
                                for (var i = 0; i < stoneIndex; i++) {
                                    if (j < 20) {
                                        j++;
                                    }
                                    else {
                                        k++;
                                        j = 0;
                                    }
                                }

                                stoneMatrix[k][j] = -1







                                // Здесь нужно обнулить флаг КО, чтобы предыдущие камни могли быть съедены

                                // Также нужно запоминать координаты групп всех съеденных камней


                                if (root.currentManipulator === "/graphic/manipulators/blhand.svg") {
                                    root.currentManipulator = "/graphic/manipulators/whhand.svg"
                                    shapePath.strokeColor = "white"
                                }
                                else {
                                    root.currentManipulator = "/graphic/manipulators/blhand.svg"
                                    shapePath.strokeColor = "black"
                                }

                                root.currentPosition -= 1
                            }

                            console.log("!FAF")
                        }
                    }




                }

                Rectangle
                {
                    color: "white"

                    width: 50
                    height: 50
                    radius: 100

                    visible: true

                    Text
                    {
                        text: qsTr("Hand")
                        anchors.centerIn: parent
                        color: "black"
                    }

                    MouseArea
                    {
                        anchors.fill: parent

                        onClicked:
                        {
                            manipulatorFlag = 1
                        }
                    }
                }

                Rectangle
                {
                    color: "white"
                    width: 50
                    height: 50
                    radius: 100

                    visible: true

                    Text
                    {
                        text: qsTr("Click")
                        anchors.centerIn: parent
                        color: "black"
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            manipulatorFlag = 0
                        }
                    }
                }

            }




        }

        // Ask window (unactive)
        Rectangle {
            id: abrct
            width: root.width - root.min / 10
            height: root.max / 8 + (width / 2.4)
            color: "#1a1a1a"
            visible: false
            radius: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            focus: true

            Column {
                anchors.centerIn: parent
                spacing: 60

                // Text inside about window
                Text {
                    width: root.width / 1.5
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: root.min / 18
                    wrapMode: Text.WordWrap
                    color: "white"
                    text: qsTr("Are you sure?")
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Button {
                        text: qsTr("Yes")
                        Layout.alignment: Qt.AlignHCenter
                        implicitWidth: root.min / 4
                        implicitHeight: root.min / 10

                        // About button background properties
                        background: Rectangle {
                            id: yesbutton
                            color: "white"
                            radius: 100
                            border.color: "black"
                        }

                        MouseArea {
                            anchors.fill: parent

                            onPressed: {
                                abrct.visible = false
                            }
                        }
                    }

                    Button {
                        text: qsTr("No")
                        Layout.alignment: Qt.AlignHCenter
                        implicitWidth: root.min / 4
                        implicitHeight: root.min / 10

                        // About button background properties
                        background: Rectangle {
                            id: nobutton
                            color: "white"
                            radius: 100
                            border.color: "black"
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                abrct.visible = false
                                gamefield.enabled = true
                            }
                        }
                    }
                }


            }

            // Animation on window visible
            PropertyAnimation on opacity {
                id: opvisible
                from: 0
                to: 1
                duration: 500
                running: false
            }

        }

        Connections {
            target: goBoard

            function onDeleteStone(deadStone) {
                var k = 0, j = 0
                for (var i = 0; i < deadStone; i++) {
                    if (j < 20) {
                        j++;
                    }
                    else {
                        k++;
                        j = 0;
                    }
                }

                coordinateMatrix[k][j].visible = false
                stoneMatrix[k][j] = -1
            }

            function onUpdateCaptiveStones(posX, posY, value, color) {
                if (color % 2 === 0)
                {
                    if (stoneMatrix[posX][posY] !== -1)
                        blackCaptives += value
                }
                else
                {
                    if (stoneMatrix[posX][posY] !== -1)
                        whiteCaptives += value
                }
            }

            function onGetBackMove() {
                root.currentPosition -= 1
                if (root.currentPosition % 2 === 0)
                {
                    root.currentManipulator = "/graphic/manipulators/whhand.svg"
                    shapePath.strokeColor = "white"
                }
                else
                {
                    root.currentManipulator = "/graphic/manipulators/blhand.svg"
                    shapePath.strokeColor = "black"
                }
            }

        }
    }
}
