/*
 * SettingsModel.h
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
 *
 *  Created on: 24 août 2015
 *      Author: Sylvain Berfini
 */

#ifndef SETTINGSMODEL_H_
#define SETTINGSMODEL_H_

#include <QObject>

#include "src/linphone/LinphoneManager.h"

class SettingsModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool debugEnabled READ debugEnabled WRITE setDebugEnabled NOTIFY settingsUpdated);

    Q_PROPERTY(QVariantMap audioCodecs READ audioCodecs NOTIFY settingsUpdated);

    Q_PROPERTY(bool videoSupported READ videoSupported NOTIFY settingsUpdated);
    Q_PROPERTY(bool videoEnabled READ videoEnabled WRITE setVideoEnabled NOTIFY settingsUpdated);
    Q_PROPERTY(bool previewVisible READ previewVisible WRITE setPreviewVisible NOTIFY settingsUpdated);
    Q_PROPERTY(bool outgoingVideoCalls READ outgoingVideoCalls WRITE setOutgoingVideoCalls NOTIFY settingsUpdated);
    Q_PROPERTY(bool incomingVideoCalls READ incomingVideoCalls WRITE setIncomingVideoCalls NOTIFY settingsUpdated);
    Q_PROPERTY(int preferredVideoSize READ preferredVideoSizeIndex NOTIFY settingsUpdated);
    Q_PROPERTY(QVariantMap videoCodecs READ videoCodecs NOTIFY settingsUpdated);

    Q_PROPERTY(bool isSrtpSupported READ isSrtpSupported NOTIFY settingsUpdated);
    Q_PROPERTY(bool isZrtpSupported READ isZrtpSupported NOTIFY settingsUpdated);
    Q_PROPERTY(bool isDtlsSupported READ isDtlsSupported NOTIFY settingsUpdated);
    Q_PROPERTY(int mediaEncryption READ mediaEncryption WRITE setMediaEncryption NOTIFY settingsUpdated);
    Q_PROPERTY(bool mediaEncryptionMandatory READ mediaEncryptionMandatory WRITE setMediaEncryptionMandatory NOTIFY settingsUpdated);

    Q_PROPERTY(QString stunServer READ stunServer WRITE setStunServer NOTIFY settingsUpdated);
    Q_PROPERTY(bool iceEnabled READ iceEnabled WRITE setIceEnabled NOTIFY settingsUpdated);
    Q_PROPERTY(bool randomPorts READ randomPorts WRITE setRandomPorts NOTIFY settingsUpdated);

public:
    SettingsModel(QObject *parent = NULL);

public Q_SLOTS:
    void setPreferredVideoSize(const QString& videoSize);
    void setPayloadEnable(QString mime, int bitrate, bool enable);

Q_SIGNALS:
    void settingsUpdated();

private:
    LinphoneManager *_manager;

    bool debugEnabled() const;
    void setDebugEnabled(const bool& enabled);

    QVariantMap audioCodecs() const;

    bool videoSupported() const;
    bool videoEnabled() const;
    void setVideoEnabled(const bool& enabled);
    bool previewVisible() const;
    void setPreviewVisible(const bool& visible);
    bool outgoingVideoCalls() const;
    void setOutgoingVideoCalls(const bool& enabled);
    bool incomingVideoCalls() const;
    void setIncomingVideoCalls(const bool& enabled);
    int preferredVideoSizeIndex() const;
    QVariantMap videoCodecs() const;

    bool isSrtpSupported() const {
        return _isSrtpSupported;
    }
    bool _isSrtpSupported;

    bool isZrtpSupported() const {
        return _isZrtpSupported;
    }
    bool _isZrtpSupported;

    bool isDtlsSupported() const {
        return _isDtlsSupported;
    }
    bool _isDtlsSupported;

    int mediaEncryption() const;
    void setMediaEncryption(const int& mediaEncryption);
    bool mediaEncryptionMandatory() const;
    void setMediaEncryptionMandatory(const bool& enabled);

    QString stunServer() const;
    void setStunServer(const QString& stunServer);
    bool iceEnabled() const;
    void setIceEnabled(const bool& enabled);
    bool randomPorts() const;
    void setRandomPorts(const bool& enabled);
};

#endif /* SETTINGSMODEL_H_ */
