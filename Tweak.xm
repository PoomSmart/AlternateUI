#import <substrate.h>

extern "C" BOOL CPIsInternalDevice();
extern "C" BOOL _UIApplicationUsesAlternateUI();

BOOL overrideInternal = NO;

MSHook(BOOL, CPIsInternalDevice)
{
	return overrideInternal ? YES : _CPIsInternalDevice();
}

MSHook(CFPropertyListRef, CFPreferencesCopyAppValue, CFStringRef key, CFStringRef applicationID)
{
	if (CFEqual(key, CFSTR("UIUseAlternateUI")))
		return (CFPropertyListRef)kCFBooleanTrue;
	return _CFPreferencesCopyAppValue(key, applicationID);
}

extern "C" void UIApplicationInitialize();

MSHook(void, UIApplicationInitialize)
{
	overrideInternal = YES;
	_UIApplicationInitialize();
	overrideInternal = NO;
}

%ctor
{
	MSHookFunction(CPIsInternalDevice, MSHake(CPIsInternalDevice));
	MSHookFunction(UIApplicationInitialize, MSHake(UIApplicationInitialize));
	MSHookFunction(CFPreferencesCopyAppValue, MSHake(CFPreferencesCopyAppValue));
}

// ಠ_ಠ