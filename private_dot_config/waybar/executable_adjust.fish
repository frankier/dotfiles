#!/bin/fish

switch $argv[1]
    case 2
        # Color: sRGB
        # Full backlight
        ddcutil setvcp 0x14 0x01 &&
            ddcutil setvcp 0x6b 100
    case 1
        # Color: User
        # Half backlight
        # Red
        # Green
        # Blue
        ddcutil setvcp 0x14 0x0b &&
            ddcutil setvcp 0x6b 50 &&
            ddcutil setvcp 0x16 100 &&
            ddcutil setvcp 0x18 95 &&
            ddcutil setvcp 0x1a 80
    case 0
        # Color: User
        # No backlight
        # Red
        # Green
        # Blue
        ddcutil setvcp 0x14 0x0b &&
            ddcutil setvcp 0x6b 0 &&
            ddcutil setvcp 0x16 100 &&
            ddcutil setvcp 0x18 95 &&
            ddcutil setvcp 0x1a 80
end
