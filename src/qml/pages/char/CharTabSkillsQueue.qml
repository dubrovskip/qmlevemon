import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "../../"
import "../../custom_controls"

Rectangle {
    id: container
    border { width: 1; color: AppStyle.mainColor }
    color: AppStyle.bgColor
    clip: true

    ListView {
        id: lvSkillQueue
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            bottomMargin: bottomStatusItem.height
            margins: 1
        }
        model: curChar.skillQueueModel
        currentIndex: -1
        interactive: true
        clip: true

        delegate: SkillProgressBar {
            id: skillPB
            modeSkillQueue: true
            skillQueueNum: model.positionInQueue + 1 // 0
            skillName: model.skillName
            skillId: model.skillId
            skillRank: model.skillTimeConstant
            skillLevelActive: model.activeLevel
            skillLevelTrained: model.trainedLevel
            skillLevelTraining: model.trainingLevel
            skillSpCurrent: model.skillPointsInSkill
            skillSpTotal: model.skillPointsForNextLevel
            skillSpPerHour: model.skillPointsPerHour
            isInProgress: (model.positionInQueue === 0)
            isQueued: model.isInQueue
            skillTrainingTimeLeft: model.trainingTimeLeft
            skillPrimaryAttribute: model.primaryAttribute
            skillSecondaryAttribute: model.secondaryAttribute
            trainPercent: model.trainPercent
            ladderPercentStart: model.ladderPercentStart
            ladderPercentEnd: model.ladderPercentEnd

            width: lvSkillQueue.width
            useAltBackColor: (model.positionInQueue % 2 == 1)
            alphaColor: curChar.isAlphaClone ? AppStyle.textAlphaSkillColor : AppStyle.textQueuedSkillColor

            lvlIndSmallRectSize: evemonapp.isDesktopPlatform ? 15 : 10
            lvlIndSmallSpacing: evemonapp.isDesktopPlatform ? 3 : 1
            lvlIndProgressHeight: evemonapp.isDesktopPlatform ? 10: 7
            ladderRectHeight: evemonapp.isDesktopPlatform ? 7 : 5
            attributeIconSize: evemonapp.isDesktopPlatform ? 32 : 20
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }

    Item {
        id: bottomStatusItem
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        height: lblTotalSkillQueueStats.implicitHeight + AppStyle.marginSmall*2
        Label {
            id: lblTotalSkillQueueStats
            anchors {
                bottom: parent.bottom
                bottomMargin: AppStyle.marginSmall
                left: parent.left
                leftMargin: AppStyle.marginNormal
            }
            color: AppStyle.textLightColor
            font.family: AppStyle.fontFamily
            font.pointSize: AppStyle.textSizeH4
            font.italic: true
            text: qsTr("Total time: ") + curChar.skillQueueTimeLeft()
                  + "  (" + Qt.formatDateTime(curChar.skillQueueFinishDateTime()) + ")"
        }
    }
}
