// -----------------------------------------------------------------------------
// unit-test_application2.as
// XrdC
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
// Entry point (regular application)
// -----------------------------------------------------------------------------

int main(uint argc, vector<var> &in argv)
{
	// --------------------------------------------------------
	// Execute
	// --------------------------------------------------------

	log("Spawned unit test 2, PID=" + getpid() + " argc=" + argc);

	if (argc > 0)
	{
		for (uint iArg = 0; iArg < argv.size(); iArg++)
		{
			log(iArg + ": " + argv[iArg].dump());
		}
	}
	
	// --------------------------------------------------------

	log("Wait for signal");
	
	vector<int> signals = {SIGCONT};

	// The signal that actually woke us up
	int signalWakeup;

	log("Going to wait for signal " + signals[0]);
	
	sigwait(signals, signalWakeup);

	log("Woken up by signal " + signalWakeup);
	
	// --------------------------------------------------------
	
	log(">>> Finish unit test 2 " + getpid());
	
	return 0;
}
