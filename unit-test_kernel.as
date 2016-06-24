// -----------------------------------------------------------------------------
// unit-test_kernel.as
// nandOS
// Created by Stjepan Stamenkovic.
// -----------------------------------------------------------------------------

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// 
// This file serves as a substitute for a proper API documentation for the time
// being. It is supposed to properly interact with the binary kernel and system
// API and should be using the correct firmware control/interrupt codes.
//
// THE SPECIFICATION OF nandOS IS IN FLUX, JOIN THE CONVERSATION AT:
//
//     https://3001sq.net/forums/#/categories/nandos-design
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

void unittest()
{
	printk("===== STARTING KERNEL UNITTEST =====\n");

	// --------------------------------------------------------
	// Types and constants
	// --------------------------------------------------------
	
	{
		DeviceClassId id;
	}
	
	{
		file f;
		f.mode = O_RDONLY;
		f.pid = 10;
		printk("File: " + f.mode + " " + f.pid + "\n");
	}
	
	// --------------------------------------------------------
	
	printk("Error codes\n");
	printk(" - ENOENT " + ENOENT + "\n");
	printk(" - ESRCH " + ESRCH + "\n");
	printk(" - EBADF " + EBADF + "\n");
	printk(" - EBUSY " + EBUSY + "\n");
	
	// --------------------------------------------------------
	
	printk("Device classes:\n");
	// ---
	printk(Device_Class_Undefined + "\n");
	printk(Device_Class_BIOS + "\n");
	printk(Device_Class_Virtual + "\n");
	// ---
	printk(Device_Class_DataLink + "\n");
	printk(Device_Class_Camera + "\n");
	printk(Device_Class_Light + "\n");
	printk(Device_Class_Display + "\n");
	printk(Device_Class_Engine + "\n");
	// ---
	printk(Device_Class_Sidestick + "\n");
	printk(Device_Class_Keyboard + "\n");
	// ---
	printk(Device_Class_Accelerometer + "\n");
	printk(Device_Class_Navigation + "\n");
	// ---
	printk(Device_Class_Thruster + "\n");
	
	// --------------------------------------------------------
	// System calls and subsystem constants
	// --------------------------------------------------------

	// printk
	printk("Kernel test message\n");
	
	// sched
	printk("        TASK_RUNNING: " + TASK_RUNNING + "\n");
	printk("  TASK_INTERRUPTIBLE: " + TASK_INTERRUPTIBLE + "\n");
	printk("TASK_UNINTERRUPTIBLE: " + TASK_UNINTERRUPTIBLE + "\n");

	// --------------------------------------------------------
	// Firmware constants, used for construction/interpretation
	// of control and interrupt messages
	// --------------------------------------------------------

	printk("Device - Control\n");
	printk(Control_Device_Power + "\n");

	printk("Device - PowerMode\n");
	printk(Device_PowerMode_On + "\n");
	printk(Device_PowerMode_Off + "\n");
	printk(Device_PowerMode_Sleep + "\n");
	
	printk("Accelerometer - Interrupt\n");
	printk(Interrupt_Accelerometer_Update + "\n");

	printk("Camera - Control\n");
	printk(Control_Camera_Capture + "\n");
	printk(Control_Camera_SetProperties + "\n");
	
	printk("DataLink - Control\n");
	printk(Control_DataLink_Mode + "\n");
	printk(Control_DataLink_Data + "\n");
	
	printk("DataLink - Interrupt\n");
	printk(Interrupt_DataLink_ConnectionAvailable + "\n");
	printk(Interrupt_DataLink_ConnectionLost + "\n");
	printk(Interrupt_DataLink_Data + "\n");
	
	printk("Display - Control\n");
	// TODO Firmware implementation

	printk("Engine - Control\n");
	printk(Control_Engine_Power + "\n");
	
	printk("Keyboard - Control\n");
	// TODO Firmware implementation

	printk("LifeSupport - Model\n");
	printk(Model_LifeSupport_ActiveThermalControl + "\n");
	printk(Model_LifeSupport_WaterCoolantLoop + "\n");
	printk(Model_LifeSupport_AirRevitalization + "\n");

	printk("Navigation - Interrupt\n");
	printk(Interrupt_Navigation_Update + "\n");
	
	printk("Navigation - Control\n");
	printk(Control_Navigation_Interval + "\n");
	
	printk("Sidestick - Interrupt\n");
	printk(Interrupt_Sidestick_Update + "\n");
	
	printk("Thruster - Control\n");
	printk(Control_Thruster_Power + "\n");

	printk("Video - Interrupt\n");
	printk(Interrupt_Video_DisplayConnected + "\n");
	
	printk("Video - Control\n");
	// Control the display mode
	printk(Control_Video_DisplayMode + "\n");
	printk(Control_Video_Clear + "\n");
	printk(Control_Video_BackgroundDMA + "\n");
	// Text mode controls
	printk(Control_Video_Font + "\n");
	printk(Control_Video_ClearCharacters + "\n");
	printk(Control_Video_AppendCharacters + "\n");
	printk(Control_Video_Newline + "\n");
	printk(Control_Video_SetCharacter + "\n");
	// Bitmap mode controls
	printk(Control_Video_DrawTexture + "\n");
	// printk(Control_Video_DrawString + "\n");		// TODO
	printk(Control_Video_SwapBuffers + "\n");

	printk("Video - DisplayMode\n");
	printk(Display_Mode_None + "\n");
	printk(Display_Mode_Text + "\n");
	printk(Display_Mode_Bitmap + "\n");
	
	printk("Video - TextAttribute\n");
	printk(Display_TextAttribute_Normal + "\n");
	printk(Display_TextAttribute_Bold + "\n");
	printk(Display_TextAttribute_Dim + "\n");
	printk(Display_TextAttribute_Underlined + "\n");
	printk(Display_TextAttribute_Blink + "\n");
	printk(Display_TextAttribute_Reverse + "\n");
	printk(Display_TextAttribute_Hidden + "\n");
	
	printk("Video - TextForeground\n");
	printk(Display_TextForeground_Default + "\n");
	printk(Display_TextForeground_Black + "\n");
	printk(Display_TextForeground_Red + "\n");
	printk(Display_TextForeground_Green + "\n");
	printk(Display_TextForeground_Yellow + "\n");
	printk(Display_TextForeground_Blue + "\n");
	printk(Display_TextForeground_Magenta + "\n");
	printk(Display_TextForeground_Cyan + "\n");
	printk(Display_TextForeground_LightGray + "\n");
	printk(Display_TextForeground_DarkGray + "\n");
	printk(Display_TextForeground_LightRed + "\n");
	printk(Display_TextForeground_LightGreen + "\n");
	printk(Display_TextForeground_LightYellow + "\n");
	printk(Display_TextForeground_LightBlue + "\n");
	printk(Display_TextForeground_LightMagenta + "\n");
	printk(Display_TextForeground_LightCyan + "\n");
	printk(Display_TextForeground_White + "\n");

	printk("Video - TextBackground\n");
	printk(Display_TextBackground_Default + "\n");
	printk(Display_TextBackground_Black + "\n");
	printk(Display_TextBackground_Red + "\n");
	printk(Display_TextBackground_Green + "\n");
	printk(Display_TextBackground_Yellow + "\n");
	printk(Display_TextBackground_Blue + "\n");
	printk(Display_TextBackground_Magenta + "\n");
	printk(Display_TextBackground_Cyan + "\n");
	printk(Display_TextBackground_LightGray + "\n");
	printk(Display_TextBackground_DarkGray + "\n");
	printk(Display_TextBackground_LightRed + "\n");
	printk(Display_TextBackground_LightGreen + "\n");
	printk(Display_TextBackground_LightYellow + "\n");
	printk(Display_TextBackground_LightBlue + "\n");
	printk(Display_TextBackground_LightMagenta + "\n");
	printk(Display_TextBackground_LightCyan + "\n");
	printk(Display_TextBackground_White + "\n");
	
	printk("Button - Interrupt\n");
	printk(Interrupt_Button_Down + "\n");
	printk(Interrupt_Button_Up + "\n");
	
	printk("Navigation - Control\n");
	printk(Control_Button_IndicateState + "\n");
	
	// --------------------------------------------------------
	
	printk("=====  ENDING KERNEL UNITTEST  =====\n");
}
