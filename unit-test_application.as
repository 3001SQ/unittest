// -----------------------------------------------------------------------------
// unit-test_application.as
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

// -----------------------------------------------------------------------------
// Display and Camera test
// -----------------------------------------------------------------------------

class TextFormat
{
	int fg;
	int bg;
	int attr;
	
	TextFormat() {}
	
	TextFormat(int _fg, int _bg, int _attr)
	{
		fg = _fg;
		bg = _bg;
		attr = _attr;
	}
}

// Display Ids of the MPS
enum DisplayId
{
	DisplayId_Terminal = 0,
	DisplayId_Arm = 1,
	DisplayId_DashboardLeft = 2,
	DisplayId_DashboardCenter = 3,
	DisplayId_DashboardRight = 4,
	DisplayId_Container = 5,
	DisplayId_Log = 6,
	DisplayId_Overhead = 7,
	DisplayId_Wall = 8
}
	
class VideoTest
{
	// -----------------------------------------------------
	// PRIVATE
	// -----------------------------------------------------
	
	private int fdVideo = 0;
	
	private vector<TextFormat> formats = 
	{
		TextFormat(
			Display_TextForeground_Default,	// White
			Display_TextBackground_Default,	// Black
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Yellow,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_LightYellow,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		// ---
		TextFormat(
			Display_TextForeground_Red,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_LightRed,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Magenta,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_LightMagenta,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		// ---
		TextFormat(
			Display_TextForeground_Green,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_LightGreen,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Cyan,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_LightCyan,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		// ---
		TextFormat(
			Display_TextForeground_Blue,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_LightBlue,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_LightGray,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_DarkGray,
			Display_TextBackground_Default,
			Display_TextAttribute_Normal),
		// -------------------------------------------------
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Default,	// Black
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_White,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Yellow,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_LightYellow,
			Display_TextAttribute_Normal),
		// ---
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Red,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_LightRed,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Magenta,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_LightMagenta,
			Display_TextAttribute_Normal),
		// ---
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Green,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_LightGreen,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Cyan,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_LightCyan,
			Display_TextAttribute_Normal),
		// ---
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_Blue,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_LightBlue,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_DarkGray,
			Display_TextAttribute_Normal),
		TextFormat(
			Display_TextForeground_Black,
			Display_TextBackground_LightGray,
			Display_TextAttribute_Normal)
	};

	// -----------------------------------------------------
	
	// General helper functions
	
	private void setMode(int displayId, int mode)
	{
		vector<var> control = 
		{
			Control_Video_DisplayMode,
			displayId,
			mode
		};
		write(fdVideo, control);
	}
	
	private void clear(int displayId, int bg = Display_TextBackground_Black)
	{
		vector<var> control = 
		{
			Control_Video_Clear,
			displayId,
			bg
		};
		write(fdVideo, control);
	}
	
	// -----------------------------------------------------
	
	// Text mode
	
	private void dumpScreen(int id, int loop)
	{
		{
			for (int i = 0; i < 4; i++)
			{
				int f = 4 * loop + i;
			
				vector<var> control = {
				Control_Video_AppendCharacters,
				id,
				"#----------# " + id + " ", 
				formats[f].fg,
				formats[f].bg,
				formats[f].attr
			};
			write(fdVideo, control);
			}
		}
			
		{
			vector<var> control = 
			{
				Control_Video_Newline, 
				id
			};
			write(fdVideo, control);
		}
	}	
	
	private void printLine(string message,
		int displayId = 0,
		int fg = Display_TextForeground_Default,
		int bg = Display_TextBackground_Default,
		int attr = Display_TextAttribute_Normal)
	{
		{
			vector<var> control = 
			{
				Control_Video_AppendCharacters,
				displayId,
				message, 
				fg,
				bg,
				attr
			};
			write(fdVideo, control);
		}

		{
			vector<var> control = 
			{
				Control_Video_Newline, 
				displayId
			};
			write(fdVideo, control);
		}
	}
	
	private void clearText(int displayId)
	{
		vector<var> control = 
		{
			Control_Video_ClearCharacters,
			displayId
		};
		write(fdVideo, control);
	}
	
	// -----------------------------------------------------
	
	// Bitmap mode
	
	private void drawTexture(int displayId, int textureHandle)
	{
		vector<var> control = 
		{
			Control_Video_DrawTexture,
			displayId,
			textureHandle,
			vec4(0, 0, 1, 1)
		};
		write(fdVideo, control);
	}
	
	private void swapBuffers(int displayId)
	{
		vector<var> control = 
		{
			Control_Video_SwapBuffers,
			displayId
		};
		write(fdVideo, control);
	}
	
	// -----------------------------------------------------
	
	// Camera helper functions
	
	private void enableCameraCapture(int fd, bool bEnable)
	{
		vector<var> control = 
		{
			Control_Camera_Capture,
			bEnable,
		};
		write(fd, control);
	}
	
	// -----------------------------------------------------
	// PUBLIC
	// -----------------------------------------------------
	
	VideoTest()
	{
		fdVideo = open("/dev/iq0", O_WRONLY);
	}
	
	~VideoTest()
	{
		// WARNING Never perform system calls in a destructor since
		// it can't be predicted when it will actually be called.
		// Do cleanup operations in the last called function instead.
		// See also http://www.angelcode.com/angelscript/sdk/docs/manual/doc_script_class_desc.html
	}
	
	// -----------------------------------------------------
	
	void Run()
	{
		int nDisplays = 9;
	
		// -------------------------------------------------
		
		// TEXT MODE
		
		// if (false)
		{
			for (int d = 0; d < nDisplays; d++)
			{
				setMode(d, Display_Mode_Text);
			}
		}
	
		// Print some lines

		// if (false)
		{
			int nIterations = formats.size() / 4;
			for (int i = 0; i < nIterations; i++)
			{
				for (int d = 0; d < nDisplays; d++)
				{
					dumpScreen(d, i);
				}
				
				sleep(1);
			}
		}
		
		// Clear screen background
		
		if (false)
		{
			for (int d = 0; d < nDisplays; d++)
			{
				clear(d, Display_TextBackground_Red);
			}
			
			sleep(3);
			
			for (int d = 0; d < nDisplays; d++)
			{
				clear(d, Display_TextBackground_Green);
			}
			
			sleep(3);
			
			for (int d = 0; d < nDisplays; d++)
			{
				clear(d, Display_TextBackground_Blue);
			}
			
			sleep(3);
			
			for (int d = 0; d < nDisplays; d++)
			{
				clear(d, Display_TextBackground_Black);
			}
		}
		
		// Clear text buffer
		
		if (false)
		{
			for (int d = 0; d < nDisplays; d++)
			{
				clearText(d);
				dumpScreen(d, 1);
			}
		}
		
		// Camera DMA
		
		if (false)
		{
			int fdCamera = open("/dev/camera0", O_WRONLY);
			
			clearText(DisplayId_Terminal);
			
			// Copy image
		
			{
				vector<var> control = 
				{
					Control_Video_BackgroundDMA,
					0,		// Display 0
					0		// DMA Device 0
				};
				write(fdVideo, control);
			}
			
			sleep(3);
			
			// Print some overlay text

			for (int i = 0; i < 4; i++)			
			{
				printLine("Camera Overlay Text " + i, DisplayId_Terminal);
				sleep(1);
			}
			
					
			// Turn camera on and off
			
			{
				vector<var> control = 
				{
					Control_Camera_Capture,
					true,
				};
				write(fdCamera, control);
			}
			
			sleep(10);
			
			{
				vector<var> control = 
				{
					Control_Camera_Capture,
					false,
				};
				write(fdCamera, control);
			}
			
			sleep(3);
			
			{
				vector<var> control = 
				{
					Control_Camera_Capture,
					true,
				};
				write(fdCamera, control);
			}
			
			sleep(10);
			
			{
				vector<var> control = 
				{
					Control_Video_BackgroundDMA,
					0,		// Display 0
					-1		// No device
				};
				write(fdVideo, control);
			}
			
			// Turn camera off
			
			{
				vector<var> control = 
				{
					Control_Camera_Capture,
					false,
				};
				write(fdCamera, control);
			}
			
			close(fdCamera);
		}
		
		// Change font
		
		// TODO Support for font loading
		
		// -------------------------------------------------
		
		// BITMAP MODE
		
		// if (false)
		{
			for (int displayId = DisplayId_Arm; displayId < DisplayId_Wall; displayId++)
			{
				setMode(displayId, Display_Mode_Bitmap);
				clear(displayId, Display_TextBackground_LightGray);
			}
			
			sleep(3);

			for (int displayId = DisplayId_Arm; displayId < DisplayId_Wall; displayId++)
			{
				drawTexture(displayId, displayId);
				swapBuffers(displayId);
			}
			
			sleep(3);
			
			for (int displayId = DisplayId_Arm; displayId < DisplayId_Wall; displayId++)
			{
				setMode(displayId, Display_Mode_Text);
				clear(displayId);
			}
		}
		
		// -------------------------------------------------
		
		// WARNING Never perform system calls in a destructor; do it in the
		// last called function instead
		// See also http://www.angelcode.com/angelscript/sdk/docs/manual/doc_script_class_desc.html
		close(fdVideo);
	}
}

// -----------------------------------------------------------------------------
// Entry point (regular application)
// -----------------------------------------------------------------------------

int main(uint argc, vector<var> &in argv)
{
	// --------------------------------------------------------
	// Execute
	// --------------------------------------------------------
	
	log("Spawned unit test, PID=" + getpid() + " argc=" + argc);
			
	if (argc > 0)
	{
		log("Start applications on end:");
		for (uint iArg = 0; iArg < argv.size(); iArg++)
		{
			log(" > " + argv[iArg].dump());
		}
	}
	
	log("===== STARTING APPLICATION UNITTEST =====");

	log(" ");
	log("< process >");
	
	log("PID=" + getpid());
	log("PPID=" + getppid());
	log("PGRP=" + getpgrp());
	log("UID=" + getuid());
	log("GID=" + getgid());
	
	log("CWD=" + getcwd());
	chdir("..");
	log("CWD=" + getcwd());

	// --------------------------------------------------------
	// Types and constants
	// --------------------------------------------------------

	log(" ");
	log("< types and constants >");
	
	{
		pid_t pid = 0;
		uid_t uid = 0;
	}
	
	log("Error codes");
	log(" - ENOENT " + ENOENT);
	log(" - ESRCH " + ESRCH);
	log(" - EBADF " + EBADF);
	log(" - EBUSY " + EBUSY);
	
	log("Signal numbers");
	log(" - SIGABRT " + SIGABRT);
	log(" - SIGALRM " + SIGALRM);
	log(" - SIGHUP " + SIGHUP);
	log(" - SIGINT " + SIGINT);
	log(" - SIGKILL " + SIGKILL);
	log(" - SIGQUIT " + SIGQUIT);
	log(" - SIGTERM " + SIGTERM);
	log(" - SIGCONT " + SIGCONT);
	log(" - SIGCHLD " + SIGCHLD);
	
	// --------------------------------------------------------
	// System calls
	// --------------------------------------------------------
	
	log(" ");
	log("< file management >");
	
	// fcntl
	
	log("File descriptor flags");
	log(" - O_RDONLY " + O_RDONLY);
	log(" - O_RDWR " + O_RDWR);
	log(" - O_WRONLY " + O_WRONLY);
	log(" - O_APPEND " + O_APPEND);
	log(" - O_CREAT " + O_CREAT);
	log(" - O_TRUNC " + O_TRUNC);
	
	// stat
	
	log("File modes");
	log(" - S_IFIFO " + S_IFIFO);
	log(" - S_IFCHR " + S_IFCHR);
	log(" - S_IFDIR " + S_IFDIR);
	log(" - S_IFBLK " + S_IFBLK);
	log(" - S_IFREG " + S_IFREG);
	
	// directory management

	rmdir("/tmp/invalidPath");	
	rmdir("/tmp/removalTest");
	
	mkdir("/tmp/a", 0);
	mkdir("/tmp/b", 0);
	mkdir("../../tmp/c", 0);
	
	rmdir("../../tmp/b");
	
	// node management
	
	// mknod("/dev/input/touchscreen0", S_IFCHR, 101);
	// mknod("/dev/input/touchscreen1", S_IFCHR, 102);
	// int nodeFd = 10;
	// mknodat(nodeFd, "/dev/input/touchscreen2", S_IFCHR, 103);

	mknod("/tmp/stamp", S_IFREG, 0);
	unlink("/tmp/stamp");
	
	// file I/O (mixed headers)
	
	log(" ");
	log("< file I/O >");
	
	{
		int fd = open("/dev/unittest", O_RDWR);
	
		if (fd > 0)
		{
			log("Open okay: " + fd);
				
			{
				// Read data from driver
			
				vector<var> dataRead;
				ssize_t nRead = read(fd, dataRead, 32);
				
				log("Read: " + nRead);
				
				if (nRead > 0)
				{
					log(" Read has data: " + dataRead.size());
					for (uint iVar = 0; iVar < dataRead.size(); iVar++)
					{
						log(" " + iVar + " " + dataRead[iVar].dump());
					}
				}
				else if (nRead == 0)
				{
					log(" Read empty");
				}
				else
				{
					log(" Read failed!");
				}
			}
			
			{
				// Write data to driver
			
				vector<var> data;
				data.push_back(false);
				data.push_back(123);
				data.push_back(uint64(456));
				data.push_back(789.1);
				data.push_back(vec2(1.1, 2.2));
				data.push_back(vec3(3.3, 4.4, 5.5));
				data.push_back(vec4(6.6, 7.7, 8.8, 9.9));
				data.push_back(quat(1.1, 2.2, 3.3, 4.4));
				data.push_back("some string");

				ssize_t nWritten = write(fd, data);

				log("Written: " + nWritten);

				if (nWritten >= 0)
				{
					log(" Write succeeded");
				}
				else
				{
					log(" Write failed!");
				}
			}
			
			if (close(fd) == 0)
			{
				log("Close okay");
			}
			else
			{
				log("Close failed!");
			}
		}
		else
		{
			log("Open failed!");
		}
	}
	
	{
		uint n = 3;
		vector<int> nullFds;
		
		for (uint i = 0; i < n; i++)
		{
			nullFds.push_back(open("/dev/unittest", O_RDWR));
		}
		
		for (uint i = 0; i < n; i++)
		{
			close(nullFds[i]);
		}
	}
	
	// TODO _sys_select
	
	log(" ");
	log("< select >");
	
	{
		log("> FD_* operations");
	
		fd_set fds;
		
		FD_ZERO(fds);
		
		log(FD_ISSET(5, fds) + " (0)");
		
		FD_SET(5, fds);
		
		log(FD_ISSET(5, fds) + " (1)");
		
		FD_CLR(5, fds);
		
		log(FD_ISSET(5, fds) + " (0)");
	}
	
	{
		log("> select");
		
		int selectResult;
		
		timeval selectTimeout;
		selectTimeout.tv_sec = 0;
		selectTimeout.tv_usec = 750;
		
		fd_set fdsRead, fdsWrite, fdsError;
		
		int fdNull = open("/dev/null", O_RDWR);
		
		FD_ZERO(fdsRead);
		FD_ZERO(fdsWrite);
		FD_ZERO(fdsError);

		// Dry run, don't do anything
		selectResult = select(fdNull + 1, null, null, null, null);
		
		FD_SET(fdNull, fdsRead);
		FD_SET(fdNull, fdsWrite);
		FD_SET(fdNull, fdsError);
		
		// Examine /dev/null
		selectResult = select(fdNull + 1, fdsRead, fdsWrite, fdsError, selectTimeout);
		
		log("select: " + selectResult + 
			" read " + FD_ISSET(fdNull, fdsRead) +
			" write " + FD_ISSET(fdNull, fdsWrite) +
			" error " + FD_ISSET(fdNull, fdsError));
		
		// ---
		
		//selectTimeout.tv_sec = 0;
		//selectTimeout.tv_usec = 0;
		
		close(fdNull);
	}

	// sleeping and signals
	
	log(" ");
	log("< signals >");
	
	{
		uint remainingTime = sleep(1);
		log("1: Remaining time " + remainingTime);
	}
	
	{
		uint remainingTime = sleep(3);
		log("2: Remaining time " + remainingTime);
	}
	
	// --------------------------------------------------------
	
	log(" ");
	log("=====  ENDING LOW-LEVEL UNITTEST  =====");
	
	// _unistd

	// WARNING fork() ... execv() workaround

	{
		int pid = fork();
		
		// WORKAROUND Normally we would only call execv() in the forked process where fork() returned 0
		vector<var> args;
		execv("/usr/bin/unittest2", args);	// This doesn't actually replace 
		// Wake up the other process after a while that is on sigwait()
		sleep(3);
		kill(pid, SIGCONT);
		
		// TODO Use system() probably?
	}
	
	// --------------------------------------------------------
	
	{
		log("===== STARTING VIDEO UNITTEST =====");
	
		VideoTest test();
		test.Run();
		
		log("=====  ENDING VIDEO UNITTEST  =====");
	}
	
	// --------------------------------------------------------
	
	log(">>> Finish unit test " + getpid());
	
	// --------------------------------------------------------
	
	{
		int pid = fork();
		if (pid > 0)
		{
			for (uint iArg = 0; iArg < argv.size(); iArg++)
			{
				vector<var> args;
				string path = argv[iArg];
				
				log("Starting " + path);
	
				// WARNING fork() ... execv() workaround
				if (execv(path, args) == 0)
				{
					log(" + Unittest Started '" + path + "' " + pid);
				}
				else
				{
					log(" ! Unittest Failed to start '" + path + "'");
				}
			}
		}
	}
	
	return 0;
}
