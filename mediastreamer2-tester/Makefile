############################################################################
# Makefile
# Copyright (C) 2014  Belledonne Communications, Grenoble France
#
############################################################################
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
############################################################################

DEVICE?=169.254.0.1
PASSWORD?=1234
DEBUG_TOKEN?=~/.rim/debugtoken1.bar

WORKING_DIR=$(shell pwd)

all: package

clean:
	rm -rf $(WORKING_DIR)/arm && rm -rf $(WORKING_DIR)/i486

package:
	mkdir -p $(WORKING_DIR)/arm && mkdir -p $(WORKING_DIR)/i486 && \
	cp $(WORKING_DIR)/../WORK/bb10-arm/Build/ms2/tester/mediastreamer2_tester $(WORKING_DIR)/arm/ && \
	cp $(WORKING_DIR)/../WORK/bb10-i486/Build/ms2/tester/mediastreamer2_tester $(WORKING_DIR)/i486/ && \
	blackberry-nativepackager -package -devMode -debugToken $(DEBUG_TOKEN) -configuration Device-Debug mediastreamer2-tester.bar bar-descriptor.xml

install: package
	blackberry-nativepackager -installApp -device $(DEVICE) -password $(PASSWORD) mediastreamer2-tester.bar

run: install
	blackberry-nativepackager -launchApp -device $(DEVICE) -password $(PASSWORD) mediastreamer2-tester.bar
	blackberry-deploy -terminateApp -device $(DEVICE) -password $(PASSWORD) mediastreamer2-tester.bar
	ssh bb10 'sh -c "cd /accounts/1000/appdata/com.belledonne_communications.ms2_tester* && LD_LIBRARY_PATH=app/native/lib app/native/mediastreamer2_tester --verbose"'

uninstall:
	blackberry-deploy -uninstallApp -device $(DEVICE) -password $(PASSWORD) mediastreamer2-tester.bar
