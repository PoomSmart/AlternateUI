SDKVERSION = 8.0
ARCHS = armv7 arm64

include theos/makefiles/common.mk
TWEAK_NAME = AlternateUI
AlternateUI_FILES = Tweak.xm
AlternateUI_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
