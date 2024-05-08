import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {
    id: root
    visible: true
    color: "black"
    width: 320
    height: 760

    Button {
        id: bttn
        text: qsTr("<- Back")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        background: Rectangle {
            id: bckbttn
            color: "white"
            radius: 30
        }

        SequentialAnimation {
            id: backanim
            running: false

            PropertyAnimation {
                property: "color"
                target: bckbttn
                to: "grey"
                duration: 100
            }

            PropertyAnimation {
                property: "color"
                target: bckbttn
                to: "white"
                duration: 100
            }

            // Open about window by animation end
            onFinished: {
                root.hide()
            }
        }

        // Animation by button click
        MouseArea {
            anchors.fill: parent
            onClicked: {
                backanim.running = true;
            }
        }
    }
}
