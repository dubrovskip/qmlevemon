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
        id: listViewSkills
        anchors.fill: parent
        anchors.margins: 1
        model: curChar.skillGroupsModel
        currentIndex: -1
        interactive: true

        delegate: Item {
            id: skillListItem
            implicitWidth: listViewSkills.width
            implicitHeight: ListView.isCurrentItem
                    ? txtSkillGroupName.height + skillGroupSkillsRect.height
                    : txtSkillGroupName.height

            Rectangle {
                id: skillListTitleRect
                implicitWidth: listViewSkills.width
                implicitHeight: txtSkillGroupName.height
                color: skillListItem.ListView.isCurrentItem ? AppStyle.rectBgHighlightColor : AppStyle.textLightColor
                border { width: 1; color: "white" }

                Text {
                    id: txtSkillGroupName
                    text: model.groupName
                    maximumLineCount: 1
                    font.pointSize: AppStyle.textSizeH3
                    font.bold: true
                    anchors {
                        top: parent.top
                        left: parent.left
                        leftMargin: AppStyle.marginNormal
                    }
                    // height is bigger on android
                    height: evemonapp.isDesktopPlatform ? implicitHeight + 2*AppStyle.marginSmall : implicitHeight + 2*AppStyle.marginNormal
                    // height: implicitHeight + 2*AppStyle.marginNormal // for testing
                    width: 160
                    verticalAlignment: Text.AlignVCenter
                    color: skillListItem.ListView.isCurrentItem ? AppStyle.textDefaultColor : AppStyle.textInvertedColor
                }

                Text {
                    id: txtSkillsInGroupCounters
                    text: model.skillsInGroupTrained + qsTr(" of ") + model.skillsInGroupTotal + qsTr(" skills") // "11 of 13 skills"
                    maximumLineCount: 1
                    font.pointSize: AppStyle.textSizeH4
                    font.bold: false
                    anchors {
                        left: txtSkillGroupName.right
                        leftMargin: evemonapp.isDesktopPlatform ? AppStyle.marginBig : AppStyle.marginSmall
                        top: parent.top
                    }
                    height: txtSkillGroupName.height
                    width: evemonapp.isDesktopPlatform ? 110 : 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    color: skillListItem.ListView.isCurrentItem ? AppStyle.textDefaultColor : AppStyle.textInvertedColor
                }

                Text {
                    id: txtSkillPointsInGroup
                    text: Number(model.skillPointsInGroup).toLocaleString(Qt.locale(), 'f', 0) + " SP"
                    maximumLineCount: 1
                    font.pointSize: AppStyle.textSizeH4
                    font.bold: false
                    anchors {
                        left: txtSkillsInGroupCounters.right
                        leftMargin: evemonapp.isDesktopPlatform ? AppStyle.marginBig*2 : AppStyle.marginSmall
                        top: parent.top
                    }
                    height: txtSkillGroupName.height
                    width: 80
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    color: skillListItem.ListView.isCurrentItem ? AppStyle.textDefaultColor : AppStyle.textInvertedColor
                }

                Text {
                    id: txtQueueInfoForGroup
                    text: model.numSkillsInQueue > 0
                          ? ( "(" + model.numSkillsInQueue + " " + qsTr("in queue") +
                             (model.numSkillsInTraining > 0 ? (", " + model.numSkillsInTraining + qsTr(" training")) : "") + ")")
                          : ""
                    maximumLineCount: 1
                    font.pointSize: AppStyle.textSizeH4
                    font.bold: false
                    anchors {
                        left: txtSkillPointsInGroup.right
                        leftMargin: AppStyle.marginBig
                        top: parent.top
                    }
                    height: txtSkillGroupName.height
                    // width: 80
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    color: skillListItem.ListView.isCurrentItem ? AppStyle.textDefaultColor : AppStyle.textInvertedColor
                }

                MouseArea {
                    id: ma1
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor

                    onClicked: {
                        var curIdx = listViewSkills.currentIndex
                        // var clickedIndex = listViewSkills.indexAt(mouse.x, skillListItem.y + mouse.y);
                        var clickedIndex = index;
                        if (clickedIndex === curIdx) {
                            // the same item is clicked twice, collapse all
                            listViewSkills.currentIndex = -1;
                        } else {
                            // activate different item
                            skillsInGroupRepeater.model = curChar.getSkillsForGroupId(model.groupId);
                            listViewSkills.currentIndex = clickedIndex;
                        }
                    }
                }
            }

            Rectangle {
                id: skillGroupSkillsRect
                visible: skillListItem.ListView.isCurrentItem
                width: listViewSkills.width
                height: skillsInGroupColumn.height
                anchors.top: skillListTitleRect.bottom
                color: AppStyle.bgColor

                Column {
                    id: skillsInGroupColumn
                    width: parent.width

                    Repeater {
                        id: skillsInGroupRepeater
                        model: null
                        delegate: SkillProgressBar {
                            modeSkillQueue: false
                            skillQueueNum: modelData.positionInQueue + 1 // 0
                            skillName: modelData.skillName
                            skillId: modelData.skillId
                            skillRank: modelData.skillTimeConstant
                            skillLevelActive: modelData.activeLevel
                            skillLevelTrained: modelData.trainedLevel
                            skillLevelTraining: modelData.trainingLevel
                            skillSpCurrent: modelData.skillPointsInSkill
                            skillSpTotal: modelData.skillPointsForNextLevel
                            skillSpPerHour: modelData.skillPointsPerHour
                            isInProgress: modelData.isInQueue ? (modelData.positionInQueue === 0) : false
                            isQueued: modelData.isInQueue
                            skillTrainingTimeLeft: modelData.trainingTimeLeft
                            skillPrimaryAttribute: modelData.primaryAttribute
                            skillSecondaryAttribute: modelData.secondaryAttribute
                            trainPercent: modelData.trainPercent

                            width: skillsInGroupColumn.width
                            useAltBackColor: (index % 2 == 1)
                            alphaColor: curChar.isAlphaClone ? AppStyle.textAlphaSkillColor : AppStyle.textQueuedSkillColor

                            lvlIndSmallRectSize: evemonapp.isDesktopPlatform ? 15 : 10
                            lvlIndSmallSpacing: evemonapp.isDesktopPlatform ? 3 : 1
                            lvlIndProgressHeight: evemonapp.isDesktopPlatform ? 10: 7
                            ladderRectHeight: evemonapp.isDesktopPlatform ? 7 : 5
                            attributeIconSize: evemonapp.isDesktopPlatform ? 32 : 20
                        }

                        onItemAdded: {
                            item.index = index;
                        }
                    }
                }
            }
        } // List item

        ScrollIndicator.vertical: ScrollIndicator { }
    } // ListView
}
