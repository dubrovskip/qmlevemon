import QtQuick 2.7
import QtQuick.Controls 2.2
import "../"
import "../utils.js" as Utils

Rectangle {
    id: root

    // public interface

    // set to true, if used to display skills in queue
    // set to false, if used to display skills list
    property bool modeSkillQueue: false

    // required parameters
    property int skillId: 0
    property int skillQueueNum: 0
    property int skillRank: 0
    property int skillLevelActive: 0
    property int skillLevelTrained: 0
    property int skillLevelTraining: 0
    property string skillName: "Skill name"
    property string skillSpCurrent: "0"
    property string skillSpTotal: "1000"
    property int skillSpPerHour: 2200
    property string skillTrainingTimeLeft: "" // "1d 12h 56s"
    property int skillPrimaryAttribute: 0
    property int skillSecondaryAttribute: 0
    property bool isInProgress: true  // is currently in training
    property bool isQueued: false     // is in queue at all
    property double trainPercent: 0.0  // to display progress bar under level indicator
    property double ladderPercentStart: 0.0  // to display ladder under container rect
    property double ladderPercentEnd: 1.0

    // customizable colors
    property color textColor: AppStyle.textDefaultColor
    property color textQueuedColor: AppStyle.textQueuedSkillColor
    property color backColor: AppStyle.bgColor
    property color backColorAlt: AppStyle.bgLightColor
    property color backColorTrainingNow: AppStyle.bgColorTrainingNow
    property bool useAltBackColor: false
    property color alphaColor: AppStyle.textAlphaSkillColor
    property color levelIndicatorColor: AppStyle.textDefaultColor
    // customizable fonts
    property string fontFamily: AppStyle.fontFamily
    property int fontSize: AppStyle.textSizeH4
    // customizable sizes
    property int ladderRectHeight: 7
    property int lvlIndSmallRectSize: 15
    property int lvlIndSmallSpacing: 3
    property int lvlIndProgressHeight: 10
    property int attributeIconSize: 32

    // private part
    color: (!modeSkillQueue && isInProgress) ? backColorTrainingNow : (useAltBackColor ? backColorAlt : backColor)
    implicitHeight: txtSkillName.height + txtSp.height + 3*AppStyle.marginSmall
                    + (modeSkillQueue ? ladderRectHeight : 0)
    implicitWidth: txtSp.width + txtSpPerHour.width + txtTrainingTime.width + rcLevelIndicator.width + 4*AppStyle.marginBig + 5
    property int index: 0

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

        SkillLevelIndicatorRect {
            id: rclv5
            size: lvlIndSmallRectSize
            anchors {
                right: parent.right
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            rectLevel: 5
            skillLevelTraining: root.skillLevelTraining
            skillLevelTrained: root.skillLevelTrained
            skillLevelActive: root.skillLevelActive
            isQueued: root.isQueued
            isInProgress: root.isInProgress
            queuedColor: textQueuedColor
            normalColor: textColor
            alphaColor: root.alphaColor
        }
        SkillLevelIndicatorRect {
            id: rclv4
            size: lvlIndSmallRectSize
            anchors {
                right: rclv5.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            rectLevel: 4
            skillLevelTraining: root.skillLevelTraining
            skillLevelTrained: root.skillLevelTrained
            skillLevelActive: root.skillLevelActive
            isQueued: root.isQueued
            isInProgress: root.isInProgress
            queuedColor: textQueuedColor
            normalColor: textColor
            alphaColor: root.alphaColor
        }
        SkillLevelIndicatorRect {
            id: rclv3
            size: lvlIndSmallRectSize
            anchors {
                right: rclv4.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            rectLevel: 3
            skillLevelTraining: root.skillLevelTraining
            skillLevelTrained: root.skillLevelTrained
            skillLevelActive: root.skillLevelActive
            isQueued: root.isQueued
            isInProgress: root.isInProgress
            queuedColor: textQueuedColor
            normalColor: textColor
            alphaColor: root.alphaColor
        }
        SkillLevelIndicatorRect {
            id: rclv2
            size: lvlIndSmallRectSize
            anchors {
                right: rclv3.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            rectLevel: 2
            skillLevelTraining: root.skillLevelTraining
            skillLevelTrained: root.skillLevelTrained
            skillLevelActive: root.skillLevelActive
            isQueued: root.isQueued
            isInProgress: root.isInProgress
            queuedColor: textQueuedColor
            normalColor: textColor
            alphaColor: root.alphaColor
        }
        SkillLevelIndicatorRect {
            id: rclv1
            size: lvlIndSmallRectSize
            anchors {
                right: rclv2.left
                rightMargin: lvlIndSmallSpacing
                top: parent.top
                topMargin: lvlIndSmallSpacing
            }
            rectLevel: 1
            skillLevelTraining: root.skillLevelTraining
            skillLevelTrained: root.skillLevelTrained
            skillLevelActive: root.skillLevelActive
            isQueued: root.isQueued
            isInProgress: root.isInProgress
            queuedColor: textQueuedColor
            normalColor: textColor
            alphaColor: root.alphaColor
        }
    }

    Rectangle {
        id: rcLevelProgress
        height: lvlIndProgressHeight
        anchors {
            top: rcLevelIndicator.bottom
            left: rcLevelIndicator.left
            right: parent.right
            topMargin: lvlIndSmallSpacing
            rightMargin: lvlIndSmallSpacing
        }
        border { width: 1; color: levelIndicatorColor }

        Rectangle {
            visible: trainPercent > 0.0
            anchors {
                top: parent.top
                left: parent.left
            }
            width: (parent.width - 2) * trainPercent
            height: parent.height - 1
            color: levelIndicatorColor
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
        text: ((skillQueueNum > 0) ? (skillQueueNum + ". " + skillName) : skillName)
              + "   " + qsTr("lv.") + " " + skillLevelActive
              + (modeSkillQueue ? (" -> " + skillLevelTraining) : "")
        color: modeSkillQueue ? textColor : ( isQueued ? textQueuedColor : textColor )
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
        color: modeSkillQueue ? textColor : ( isQueued ? textQueuedColor : textColor )
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
        color: modeSkillQueue ? textColor : ( isQueued ? textQueuedColor : textColor )
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
        color: modeSkillQueue ? textColor : ( isQueued ? textQueuedColor : textColor )
        visible: isQueued
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
        color: modeSkillQueue ? textColor : ( isQueued ? textQueuedColor : textColor )
        visible: isQueued && modeSkillQueue
    }

    Image {
        id: imgPrimaryAttr
        anchors {
            right: imgSecondaryAttr.left
            rightMargin: evemonapp.isDesktopPlatform ? AppStyle.marginSmall : 2
            top: parent.top
            topMargin: evemonapp.isDesktopPlatform ? AppStyle.marginSmall : 2
        }
        visible: skillPrimaryAttribute > 0
        source: "qrc:///img/char_attributes/" + Utils.getAttributePicture(skillPrimaryAttribute) + ".png"
        width: attributeIconSize
        height: attributeIconSize
    }
    Image {
        id: imgSecondaryAttr
        anchors {
            right: rcLevelIndicator.left
            rightMargin: evemonapp.isDesktopPlatform ? AppStyle.marginBig : AppStyle.marginSmall
            top: parent.top
            topMargin: evemonapp.isDesktopPlatform ? AppStyle.marginSmall : 2
        }
        visible: skillSecondaryAttribute > 0
        source: "qrc:///img/char_attributes/" + Utils.getAttributePicture(skillSecondaryAttribute) + ".png"
        width: attributeIconSize
        height: attributeIconSize
    }

    Rectangle {
        id: ladderRect
        visible: modeSkillQueue
        height: ladderRectHeight
        x: parent.x + parent.width * ladderPercentStart
        anchors.bottom: parent.bottom
        width: parent.width * (ladderPercentEnd - ladderPercentStart)
        color: textQueuedColor
    }
}
