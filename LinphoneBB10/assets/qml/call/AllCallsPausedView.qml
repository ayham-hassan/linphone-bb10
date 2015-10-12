/*
 * AllCallsPausedView.qml
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

Container {
    layout: StackLayout {
        orientation: LayoutOrientation.TopToBottom
    }
    verticalAlignment: VerticalAlignment.Fill
    horizontalAlignment: HorizontalAlignment.Fill
    background: colors.colorC

    Container {
        layout: DockLayout {
            
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        horizontalAlignment: HorizontalAlignment.Center

        ImageView {
            verticalAlignment: VerticalAlignment.Bottom
            horizontalAlignment: HorizontalAlignment.Center
            imageSource: "asset:///images/call/waiting_time.png"
        }
    }

    Container {
        layout: DockLayout {
        
        }
        layoutProperties: StackLayoutProperties {
            spaceQuota: 1
        }
        horizontalAlignment: HorizontalAlignment.Center

        Label {
            verticalAlignment: VerticalAlignment.Top
            horizontalAlignment: HorizontalAlignment.Center
            text: qsTr("No current call") + Retranslate.onLanguageChanged
            textStyle.color: colors.colorH
            textStyle.base: titilliumWeb.style
            textStyle.fontSize: FontSize.Large
        }
    }
}
