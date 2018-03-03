include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = TextToMailPrefs
TextToMailPrefs_FILES = TTMRootListController.m
TextToMailPrefs_INSTALL_PATH = /Library/PreferenceBundles
TextToMailPrefs_FRAMEWORKS = UIKit
TextToMailPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/TextToMailPrefs.plist$(ECHO_END)
