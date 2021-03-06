/*
 * HistoryListView.qml
 * Copyright (C) 2015  Belledonne Communications, Grenoble, France
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

import bb.cascades 1.4

import "../custom_controls"

Container {
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    
    onCreationCompleted: {
        // This is a needed hack since listeItemComponents are created in a different context,
        // so colors and fonts aren't available
        Qt.colors = colors;
        Qt.titilliumWeb = titilliumWeb
        
        historyList.scrollToItem(historyListModel.lastSelectedItemIndexPath, ScrollAnimation.None)
        historyListModel.resetLastSelectedItemPath()
        
        historyListModel.editor.isEditMode = false
        Qt.editor = historyListModel.editor
    }
    
    Container {
        layout: StackLayout {
            orientation: LayoutOrientation.LeftToRight
        }
        minHeight: ui.sdu(15)
        background: colors.colorF
        
        CustomToggleButton {
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            imageSource: "asset:///images/history/history_all_default.png"
            selectedImageSource: "asset:///images/history/history_all_selected.png"
            selected: !historyListModel.missedFilterEnabled
            background: colors.colorF
            visible: !historyListModel.editor.isEditMode
            
            onTouch: {
                if (event.isDown() || event.isMove()) {
                    background = colors.colorE
                } else if (event.isUp() || event.isCancel()) {
                    background = colors.colorF
                }
            }
            
            onTouchExit: {
                background = colors.colorF
            }
            
            gestureHandlers: TapHandler {
                onTapped: {
                    historyListModel.setMissedFilter(false)
                }
            }
        }
        
        CustomToggleButton {
            layoutProperties: StackLayoutProperties {
                spaceQuota: 1
            }
            selected: historyListModel.missedFilterEnabled
            imageSource: "asset:///images/history/history_missed_default.png"
            selectedImageSource: "asset:///images/history/history_missed_selected.png"
            background: colors.colorF
            visible: !historyListModel.editor.isEditMode
            
            onTouch: {
                if (event.isDown() || event.isMove()) {
                    background = colors.colorE
                } else if (event.isUp() || event.isCancel()) {
                    background = colors.colorF
                }
            }
            
            onTouchExit: {
                background = colors.colorF
            }
            
            gestureHandlers: TapHandler {
                onTapped: {
                    historyListModel.setMissedFilter(true)
                }
            }
        }
        
        Container {
            visible: !historyListModel.editor.isEditMode
            layoutProperties: StackLayoutProperties {
                spaceQuota: 2
            }
        }
        
        TopBarButton {
            imageSource: "asset:///images/edit_list.png"
            visible: !historyListModel.editor.isEditMode
            
            gestureHandlers: TapHandler {
                onTapped: {
                    historyListModel.editor.isEditMode = true
                }
            }
        }
        
        TopBarEditListControls {
            visible: historyListModel.editor.isEditMode
            selectionSize: historyListModel.editor.selectionSize
            itemsCount: historyListModel.editor.itemsCount
            onCancelEdit: {
                historyListModel.editor.isEditMode = false;
            }
            onSelectAll: {
                historyListModel.editor.selectAll(true);
            }
            onDeselectAll: {
                historyListModel.editor.selectAll(false);
            }
            onDeleteSelected: {
                actionConfirmationScreen.visible = true;
                actionConfirmationScreen.text = qsTr("Do you want to delete selected logs?") + Retranslate.onLanguageChanged;
                actionConfirmationScreen.confirmActionClicked.connect(onDelete);
                actionConfirmationScreen.cancelActionClicked.connect(onCancel);
            }
        }
    }

    Container {
        layout: DockLayout {
        
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        horizontalAlignment: HorizontalAlignment.Fill

        ListView {
            id: historyList
            dataModel: historyListModel.dataModel
            visible: historyListModel.dataModel.size() > 0
    
            listItemComponents: [
                ListItemComponent {
                    type: "header"
    
                    Container {
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        background: Qt.colors.colorH
                        horizontalAlignment: HorizontalAlignment.Fill
    
                        Label {
                            text: ListItemData
                            horizontalAlignment: HorizontalAlignment.Center
                            textStyle.color: Qt.colors.colorA
                            textStyle.fontWeight: FontWeight.Bold
                            textStyle.base: Qt.titilliumWeb.style
                            textStyle.fontSize: FontSize.Large
                        }
                        
                        CustomListDivider {
                            
                        }
                    }
                },
    
                ListItemComponent {
                    type: "item"
    
                    Container {
                        id: itemRoot
                        layout: StackLayout {
                            orientation: LayoutOrientation.TopToBottom
                        }
                        
                        Container {
                            layout: StackLayout {
                                orientation: LayoutOrientation.LeftToRight
                            }
                            background: Qt.colors.colorH
                            topPadding: ui.sdu(1)
                            bottomPadding: ui.sdu(1)
                            leftPadding: ui.sdu(2)
                            rightPadding: ui.sdu(2)
                            horizontalAlignment: HorizontalAlignment.Fill
                            
                            ContactAvatar {
                                maxHeight: ui.sdu(13)
                                maxWidth: ui.sdu(13)
                                minHeight: ui.sdu(13)
                                minWidth: ui.sdu(13)
                                imageSource: ListItemData.contactPhoto
                                verticalAlignment: VerticalAlignment.Center
                                rightMargin: ui.sdu(2)
                            }
                            
                            ImageView {
                                minWidth: ui.sdu(6.5)
                                minHeight: ui.sdu(6.5)
                                imageSource: ListItemData.directionPicture
                                verticalAlignment: VerticalAlignment.Center
                                scalingMethod: ScalingMethod.AspectFit
                                rightMargin: ui.sdu(2)
                            }
                            
                            Label {
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                text: ListItemData.displayName
                                textStyle.color: Qt.colors.colorC
                                textStyle.base: Qt.titilliumWeb.style
                                textStyle.fontSize: FontSize.Large
                                verticalAlignment: VerticalAlignment.Center
                            }
                            
                            ImageButton {
                                verticalAlignment: VerticalAlignment.Center
                                rightMargin: ui.sdu(2)
                                defaultImageSource: "asset:///images/history/list_details_default.png"
                                pressedImageSource: "asset:///images/history/list_details_over.png"
                                visible: !Qt.editor.isEditMode
                                
                                onClicked: {
                                    itemRoot.ListItem.view.viewHistory(itemRoot.ListItem.indexPath, ListItemData.log);
                                }
                            }
                            
                            CustomCheckBox {
                                verticalAlignment: VerticalAlignment.Center
                                enabled: false // This is because clicking on it will also trigger a click on the row, that will do the checkbox toggle
                            }
                        }
                        
                        CustomListDivider {
                            
                        }
                    }
                }
            ]
    
            onTriggered: {
                if (indexPath.length > 1) {
                    var selectedItem = dataModel.data(indexPath);
                    if (historyListModel.editor.isEditMode) {
                        Qt.editor.updateSelection(indexPath, !selectedItem.selected);
                    } else {
                        newOutgoingCallOrCallTransfer(selectedItem.linphoneAddress);
                    }
                }
            }
            
            function viewHistory(indexPath, log) {
                historyListModel.viewHistory(indexPath, log);
                tabDelegate.source = "HistoryDetailsView.qml"
            }
    
            function itemType(data, indexPath) {
                if (indexPath.length == 1) {
                    return "header";
                } else {
                    return "item";
                }
            }
        }
        
        Label {
            visible: historyListModel.dataModel.size() == 0
            text: qsTr("No call in your history") + Retranslate.onLanguageChanged
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            textStyle.fontSize: FontSize.XLarge
            textStyle.color: colors.colorC
            textStyle.base: titilliumWeb.style
        }
    }
    
    function onDelete() {
        historyListModel.editor.deleteSelection()
        historyListModel.editor.isEditMode = false
    }
    
    function onCancel() {
        historyListModel.editor.isEditMode = false
    }
}
