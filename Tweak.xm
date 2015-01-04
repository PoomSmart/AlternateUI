#import <substrate.h>

extern "C" BOOL _UIApplicationUsesAlternateUI();

MSHook(BOOL, _UIApplicationUsesAlternateUI)
{
	return YES;
}

%ctor
{
	MSHookFunction(_UIApplicationUsesAlternateUI, MSHake(_UIApplicationUsesAlternateUI));
}