import QtQuick 2.7
import QtQuick.Controls 2.2
import "../"

Rectangle {
    id: root

    // public interface

    property int skillId: 0
    property int skillQueueNum: 1
    property int skillRank: 1
    property int skillLevelActive: 1
    property int skillLevelTrained: 1
    property string skillName: "Skill name"
    property string skillSpCurrent: "0"
    property string skillSpTotal: "1000"
    property int skillSpPerHour: 2200
    property string skillTrainingTimeLeft: "" // "1d 12h 56s"
    property bool isInProgress: true
    property bool isQueued: false

    property double progressStart: 0.0
    property double progressEnd: 0.5

    property color textColor: AppStyle.textDefaultColor
    property color textQueuedColor: "#6595ea"
    property color backColor: AppStyle.bgColor
    property color backColorAlt: "#d3d3d3"
    property color backColorTrainingNow: "#EEFFEE"
    property bool useAltBackColor: false
    property string fontFamily: AppStyle.fontFamily
    property int fontSize: AppStyle.textSizeH4

    property color levelIndicatorColor: "black"

    // private part
    color: isInProgress ? backColorTrainingNow : (useAltBackColor ? backColorAlt : backColor)
    implicitHeight: txtSkillName.height + txtSp.height + 3*AppStyle.marginSmall
    implicitWidth: txtSp.width + txtSpPerHour.width + txtTrainingTime.width + rcLevelIndicator.width + 4*AppStyle.marginBig + 5
    property int index: 0
    property int lvlIndSmallRectSize: 15
    property int lvlIndSmallSpacing: 3

    Rectangle {
        id: rcLevelIndicator
        width: lvlIndSmallRectSize*5 + lvlIndSmallSpacing*6
        height: lvlIndSmallRectSize + lvlIndSmallSpacing*2
        border { width: 1; color: levelIndicatorColor }
        anchors {
            top: parent.top
            right: parent.right
            margins: lvlIndSmallSpacing
        }

        Rectangle {
            id: rclv5
            width: lvlIndSmallRectSize
            height: lvlIndSmallRectSize
            color: (isQueued && (skillLevelTrained == 4)) ? textQueuedColor : "black"
            anchors {
                right: parent.right
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            visible: (skillLevelTrained >= 5) || (isQueued && (skillLevelTrained == 4))
        }
        Rectangle {
            id: rclv4
            width: lvlIndSmallRectSize
            height: lvlIndSmallRectSize
            color: (isQueued && (skillLevelTrained == 3)) ? textQueuedColor : "black"
            anchors {
                right: rclv5.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            visible: (skillLevelTrained >= 4) || (isQueued && (skillLevelTrained == 3))
        }
        Rectangle {
            id: rclv3
            width: lvlIndSmallRectSize
            height: lvlIndSmallRectSize
            color: (isQueued && (skillLevelTrained == 2)) ? textQueuedColor : "black"
            anchors {
                right: rclv4.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            visible: (skillLevelTrained >= 3) || (isQueued && (skillLevelTrained == 2))
        }
        Rectangle {
            id: rclv2
            width: lvlIndSmallRectSize
            height: lvlIndSmallRectSize
            color: (isQueued && (skillLevelTrained == 1)) ? textQueuedColor : "black"
            anchors {
                right: rclv3.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            visible: (skillLevelTrained >= 2) || (isQueued && (skillLevelTrained == 1))
        }
        Rectangle {
            id: rclv1
            width: lvlIndSmallRectSize
            height: lvlIndSmallRectSize
            color: (isQueued && (skillLevelTrained == 0)) ? textQueuedColor : "black"
            anchors {
                right: rclv2.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            visible: (skillLevelTrained >= 1) || (isQueued && (skillLevelTrained == 0))
        }
    }

    Text {
        id: txtSkillName
        anchors {
            top: parent.top
            left: parent.left
            topMargin: AppStyle.marginSmall
            rightMargin: AppStyle.marginSmall
            bottomMargin: AppStyle.marginSmall
            leftMargin: (skillQueueNum > 0) ? AppStyle.marginSmall : AppStyle.marginBig
        }
        font {
            bold: true
            family: fontFamily
            pointSize: fontSize
        }
        text: ((skillQueueNum > 0) ? (skillQueueNum + ". " + skillName) : skillName) + "   " + qsTr("lv.") + " " + skillLevelActive
        color: isQueued ? textQueuedColor : textColor
    }

    Text {
        id: txtRank
        anchors {
            top: parent.top
            left: txtSkillName.right
            margins: AppStyle.marginSmall
        }
        font {
            bold: false
            pointSize: fontSize
        }
        text: "(" + qsTr("Rank") + " " + skillRank + ")"
        color: isQueued ? textQueuedColor : textColor
    }

    Text {
        id: txtSp
        anchors {
            top: txtSkillName.bottom
            left: txtSkillName.left
            topMargin: AppStyle.marginSmall
            rightMargin: AppStyle.marginSmall
            bottomMargin: AppStyle.marginSmall
            leftMargin: (skillQueueNum > 0) ? AppStyle.marginBig : 0
        }
        font {
            bold: false
            pointSize: fontSize
        }
        text: "SP: " + Number(skillSpCurrent).toLocaleString(Qt.locale(),'f',0) + " / " + Number(skillSpTotal).toLocaleString(Qt.locale(),'f',0)
        color: isQueued ? textQueuedColor : textColor
    }

    Text {
        id: txtSpPerHour
        anchors {
            top: txtSkillName.bottom
            left: txtSp.right
            topMargin: AppStyle.marginSmall
            rightMargin: AppStyle.marginSmall
            bottomMargin: AppStyle.marginSmall
            leftMargin: AppStyle.marginBig
        }
        font {
            bold: false
            pointSize: fontSize
        }
        text: qsTr("SP/Hour") + ": " + skillSpPerHour
        color: isQueued ? textQueuedColor : textColor
        visible: isInProgress
    }

    Text {
        id: txtTrainingTime
        anchors {
            top: txtSkillName.bottom
            left: txtSpPerHour.right
            topMargin: AppStyle.marginSmall
            rightMargin: AppStyle.marginSmall
            bottomMargin: AppStyle.marginSmall
            leftMargin: AppStyle.marginBig
        }
        font {
            bold: false
            pointSize: fontSize
        }
        text: qsTr("Training time") + ": " + skillTrainingTimeLeft
        color: isQueued ? textQueuedColor : textColor
        visible: isInProgress
    }
}
