import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQml 2.15

Window {
    id: root
    visible: true
    color: "#262626"
    width: 320
    height: 720

    // Minimal scale factor
    property int min: Math.min(width, height)

    // Maximal scale factor
    property int max: Math.max(width, height)

    Rectangle {
        id: rect
        width: root.width
        focus: true

        Keys.onPressed: event => {
                            if (event.key === Qt.Key_Backspace || event.key === Qt.Key_Back) {
                                root.close()
                                var component = Qt.createComponent("/navigation.qml")
                                var window = component.createObject(root)
                                window.show()
                            }
                        }

        ColumnLayout {
            //y: rect.height / 2
            anchors.horizontalCenter: parent.horizontalCenter

            // Rooms text
            Text {
                // Text properties
                id: rmstxt
                text: qsTr("Rooms List")
                font.pixelSize: root.min / 12
                color: "white"
                visible: true
                opacity: 0
                Layout.alignment: Qt.AlignHCenter

                // Change text opacity animation
                PropertyAnimation on opacity {
                    from: 0
                    to: 1
                    duration: 3000
                    running: true
                }
            }

            Rectangle {
                clip: true
                Layout.alignment: Qt.AlignHCenter
                implicitWidth: root.min / 1.2
                implicitHeight: root.max / 1.09 - (width / 60)
                radius: 40
                color: "white"

                //Image
                //{
                //    source: "/../../Desktop/0d42eeb83ad3a56c97468d69721b2c18.jpg"
                //    anchors.fill: parent
                //}

                SwipeView {
                    id: scrlview
                    anchors.fill: parent
                    currentIndex: 0

                    Item {
                        id: firstPage

                        ScrollView {
                            width: firstPage.width
                            height: firstPage.height
                            contentWidth: parent.width
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                            clip: true

                            ColumnLayout {
                                id: colmnlyt
                                anchors.horizontalCenter: parent.horizontalCenter

                                spacing: root.min / 30

                                Text {
                                    text: qsTr("National Rooms")
                                    font.pixelSize: root.min / 14
                                    Layout.alignment: Qt.AlignHCenter
                                    color: "black"
                                }

                                Repeater {

                                    model: ["International", "American", "Chinese", "Vietnamese",
                                        "Japanese", "Korean", "Russian", "Ukrainian",
                                        "Belarusian", "French", "Italian", "German",
                                        "Hungarian", "Brazilian", "Arabian", "Romanian",
                                        "Czechian", "Croatian", "Thailand"]

                                    Rectangle {
                                        id: intbttn

                                        Text {
                                            text: qsTr(modelData + " Room")
                                            color: "white"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        gradient: Gradient {
                                            orientation: Gradient.Horizontal

                                            GradientStop {
                                                position: 0.03;
                                                color: "red"
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
                                                color: "red"
                                            }
                                        }

                                        Image {
                                            id: triangl
                                            anchors.verticalCenter: parent.verticalCenter
                                            x: parent.width
                                            width: root.min / 15
                                            height: root.min / 16
                                            source: "/graphic/triangle/triangle.svg"
                                            visible: false
                                        }

                                        // Click animation on button click
                                        SequentialAnimation {
                                            id: goanim
                                            running: false

                                            PropertyAnimation {
                                                property: "opacity"
                                                target: intbttn
                                                from: 0
                                                to: 1
                                                duration: 300
                                            }

                                            // Open rooms window by animation end
                                            onFinished: {
                                                //var component = Qt.createComponent("/rooms.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                                triangl.visible = false

                                                root.close()
                                                var component = Qt.createComponent("/game.qml")

                                                if (component.status === Component.Ready) {
                                                    var window = component.createObject(root)
                                                    window.show()
                                                }
                                                else {
                                                    console.log(component.errorString())
                                                }
                                                
                                                //var component = Qt.createComponent("/registration.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                            }
                                        }

                                        implicitWidth: root.min / 2
                                        implicitHeight: root.max / 18
                                        radius: 40
                                        Layout.alignment: Qt.AlignHCenter

                                        MouseArea {
                                            anchors.fill: parent

                                            onClicked: {
                                                triangl.visible = true
                                                goanim.running = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Item {
                        id: secondPage

                        ScrollView {
                            width: secondPage.width
                            height: secondPage.height
                            contentWidth: parent.width
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            clip: true

                            ColumnLayout {
                                id: colmnlyt2
                                anchors.horizontalCenter: parent.horizontalCenter

                                spacing: root.min / 30

                                Text {
                                    text: qsTr("Global Rooms")
                                    color: "black"
                                    font.pixelSize: root.min / 14
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                Repeater {

                                    model: ["International", "American", "Chinese", "Vietnamese",
                                        "Japanese", "Korean", "Russian", "Ukrainian",
                                        "Belarusian", "French", "Italian", "German",
                                        "Hungarian", "Brazilian", "Arabian", "Romanian",
                                        "Czechian", "Croatian", "Thailand"]


                                    Rectangle {
                                        id: intbttn2

                                        Text {
                                            text: qsTr(modelData + " Room")
                                            color: "white"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        gradient: Gradient {
                                            orientation: Gradient.Horizontal

                                            GradientStop {
                                                position: 0.03;
                                                color: "blue"
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
                                                color: "blue"
                                            }
                                        }

                                        Image {
                                            id: triangl2
                                            anchors.verticalCenter: parent.verticalCenter
                                            x: parent.width
                                            width: root.min / 15
                                            height: root.min / 16
                                            source: "/graphic/triangle/triangle.svg"
                                            visible: false
                                        }

                                        // Click animation on button click
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

                                            // Open rooms window by animation end
                                            onFinished: {
                                                //var component = Qt.createComponent("/rooms.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                                triangl2.visible = false

                                                //var component = Qt.createComponent("/registration.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                            }
                                        }

                                        implicitWidth: root.min / 2
                                        implicitHeight: root.max / 18
                                        radius: 40
                                        Layout.alignment: Qt.AlignHCenter

                                        MouseArea {
                                            anchors.fill: parent

                                            onClicked: {
                                                triangl2.visible = true
                                                goanim2.running = true
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: plusbttn
                            x: root.min / 25
                            y: root.max / 1.18
                            color: "black"
                            radius: 100
                            implicitWidth: root.min / 8
                            implicitHeight: root.min / 8
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            border.color: "white"

                            Text {
                                text: qsTr("+")
                                color: "white"
                                font.pixelSize: root.min / 6
                                anchors.centerIn: parent
                            }

                            RotationAnimation {
                                id: plusbttnanim
                                target: plusbttn
                                from: 0
                                to: 360
                                duration: 1000
                                running: false
                                easing.type: Easing.OutInSine

                                onFinished: {
                                    crrct.visible = true
                                    crvisible.running = true
                                    opaddnewtxt.running = true
                                }
                            }

                            MouseArea {
                                anchors.fill: parent

                                onClicked:
                                {
                                    plusbttnanim.running = true
                                }
                            }
                        }
                    }

                    Item {
                        id: thirdPage

                        ScrollView {
                            width: thirdPage.width
                            height: thirdPage.height
                            contentWidth: parent.width
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            clip: true

                            ColumnLayout {
                                id: colmnlyt3
                                anchors.horizontalCenter: parent.horizontalCenter

                                spacing: root.min / 30

                                Text {
                                    text: qsTr("Tournament Rooms")
                                    color: "black"
                                    font.pixelSize: root.min / 14
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                Repeater {

                                    model: ["International", "American", "Chinese", "Vietnamese",
                                        "Japanese", "Korean", "Russian", "Ukrainian",
                                        "Belarusian", "French", "Italian", "German",
                                        "Hungarian", "Brazilian", "Arabian", "Romanian",
                                        "Czechian", "Croatian", "Thailand"]


                                    Rectangle {
                                        id: intbttn3

                                        Text {
                                            text: qsTr(modelData + " Room")
                                            color: "white"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        gradient: Gradient {
                                            orientation: Gradient.Horizontal

                                            GradientStop {
                                                position: 0.03;
                                                color: "green"
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
                                                color: "green"
                                            }
                                        }

                                        Image {
                                            id: triangl3
                                            anchors.verticalCenter: parent.verticalCenter
                                            x: parent.width
                                            width: root.min / 15
                                            height: root.min / 16
                                            source: "/graphic/triangle/triangle.svg"
                                            visible: false
                                        }

                                        // Click animation on button click
                                        SequentialAnimation {
                                            id: goanim3
                                            running: false

                                            PropertyAnimation {
                                                property: "opacity"
                                                target: intbttn3
                                                from: 0
                                                to: 1
                                                duration: 300
                                            }

                                            // Open rooms window by animation end
                                            onFinished: {
                                                //var component = Qt.createComponent("/rooms.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                                triangl3.visible = false

                                                //var component = Qt.createComponent("/registration.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                            }
                                        }

                                        implicitWidth: root.min / 2
                                        implicitHeight: root.max / 18
                                        radius: 40
                                        Layout.alignment: Qt.AlignHCenter

                                        MouseArea {
                                            anchors.fill: parent

                                            onClicked: {
                                                triangl3.visible = true
                                                goanim3.running = true
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: plusbttn2
                            x: root.min / 25
                            y: root.max / 1.18
                            color: "black"
                            radius: 100
                            implicitWidth: root.min / 8
                            implicitHeight: root.min / 8
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            border.color: "white"

                            Text {
                                text: qsTr("+")
                                color: "white"
                                font.pixelSize: root.min / 6
                                anchors.centerIn: parent
                            }

                            RotationAnimation {
                                id: plusbttnanim2
                                target: plusbttn2
                                from: 0
                                to: 360
                                duration: 1000
                                running: false
                                easing.type: Easing.OutInSine

                                onFinished: {
                                    crrct.visible = true
                                    crvisible.running = true
                                    opaddnewtxt.running = true
                                }
                            }

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    plusbttnanim2.running = true
                                }
                            }
                        }

                    }

                    Item {
                        id: fourthPage

                        ScrollView {
                            width: fourthPage.width
                            height: fourthPage.height
                            contentWidth: parent.width
                            ScrollBar.vertical.policy: ScrollBar.AlwaysOff
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            clip: true

                            ColumnLayout {
                                id: colmnlyt4
                                anchors.horizontalCenter: parent.horizontalCenter

                                spacing: root.min / 30

                                Text {
                                    text: qsTr("Own Rooms")
                                    color: "black"
                                    font.pixelSize: root.min / 14
                                    Layout.alignment: Qt.AlignHCenter
                                }

                                Repeater {

                                    model: ["International", "American", "Chinese", "Vietnamese",
                                        "Japanese", "Korean", "Russian", "Ukrainian",
                                        "Belarusian", "French", "Italian", "German",
                                        "Hungarian", "Brazilian", "Arabian", "Romanian",
                                        "Czechian", "Croatian", "Thailand"]

                                    Rectangle {
                                        id: intbttn4

                                        Text {
                                            text: qsTr(modelData + " Room")
                                            color: "white"
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        gradient: Gradient {
                                            orientation: Gradient.Horizontal

                                            GradientStop {
                                                position: 0.03;
                                                color: "orange"
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
                                                color: "orange"
                                            }
                                        }

                                        Image {
                                            id: triangl4
                                            anchors.verticalCenter: parent.verticalCenter
                                            x: parent.width
                                            width: root.min / 15
                                            height: root.min / 16
                                            source: "/graphic/triangle/triangle.svg"
                                            visible: false
                                        }

                                        // Click animation on button click
                                        SequentialAnimation {
                                            id: goanim4
                                            running: false

                                            PropertyAnimation {
                                                property: "opacity"
                                                target: intbttn4
                                                from: 0
                                                to: 1
                                                duration: 300
                                            }

                                            // Open rooms window by animation end
                                            onFinished: {
                                                //var component = Qt.createComponent("/rooms.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                                triangl4.visible = false

                                                //var component = Qt.createComponent("/registration.qml")
                                                //var window = component.createObject(root)
                                                //window.show()
                                            }
                                        }

                                        implicitWidth: root.min / 2
                                        implicitHeight: root.max / 18
                                        radius: 40
                                        Layout.alignment: Qt.AlignHCenter

                                        MouseArea {
                                            anchors.fill: parent

                                            onClicked: {
                                                triangl4.visible = true
                                                goanim4.running = true
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Rectangle {
                            id: plusbttn3
                            x: root.min / 25
                            y: root.max / 1.18
                            color: "black"
                            radius: 100
                            implicitWidth: root.min / 8
                            implicitHeight: root.min / 8
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            border.color: "white"

                            Text {
                                text: qsTr("+")
                                color: "white"
                                font.pixelSize: root.min / 6
                                anchors.centerIn: parent
                            }

                            RotationAnimation {
                                id: plusbttnanim3
                                target: plusbttn3
                                from: 0
                                to: 360
                                duration: 1000
                                running: false
                                easing.type: Easing.OutInSine

                                onFinished: {
                                    crrct.visible = true
                                    crvisible.running = true
                                    opaddnewtxt.running = true
                                }
                            }

                            MouseArea {
                                anchors.fill: parent

                                onClicked: {
                                    plusbttnanim3.running = true
                                }
                            }
                        }
                    }
                }

                PageIndicator {
                    id: indicator
                    count: scrlview.count
                    currentIndex: scrlview.currentIndex
                    y: root.min / 20
                    anchors.left: scrlview.left
                    anchors.verticalCenter: scrlview.verticalCenter
                    rotation: 90

                    delegate: Rectangle {
                        implicitWidth: root.min / 40
                        implicitHeight: root.min / 40
                        radius: 100
                        color: "#000000"
                        opacity: index == indicator.currentIndex ? 0.95 : pressed ? 0.9 : 0.45

                        Behavior on opacity {
                            OpacityAnimator {
                                duration: 650
                            }
                        }
                    }
                }

                // Add New Room window
                Rectangle {
                    id: crrct
                    width: root.width - root.min / 5
                    height: root.max / 2 + (width / 2.4)
                    color: "#1a1a1a"
                    visible: false
                    radius: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: crcross
                        source: "/graphic/buttons/close.svg"
                        sourceSize: Qt.size(root.min / 15, root.min / 15)
                        x: root.min / 20
                        y: root.max / 80

                        RotationAnimation {
                            id: crcrossanim
                            target: crcross
                            from: 0
                            to: 360
                            duration: 1000
                            running: false
                            easing.type: Easing.InOutCubic

                            onFinished: {
                                crrct.visible = false
                                rect.visible = true
                            }
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                crcrossanim.running = true
                            }
                        }
                    }

                    ColumnLayout {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top

                        // Text inside about window
                        Text {
                            // Text properties
                            id: addnewtxt
                            text: qsTr("New Room")
                            font.pixelSize: root.min / 12
                            color: "white"
                            visible: true
                            opacity: 0

                            // Change text opacity animation
                            PropertyAnimation on opacity {
                                id: opaddnewtxt
                                from: 0
                                to: 1
                                duration: 3000
                                running: false
                            }
                        }
                    }

                    // Animation on window visible
                    PropertyAnimation on opacity {
                        id: crvisible
                        from: 0
                        to: 1
                        duration: 1500
                        running: false
                    }
                }
            }
        }
    }
}
