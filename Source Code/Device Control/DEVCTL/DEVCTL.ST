//DEVCTL - Device Control Block
//Functionally similar to the Honeywell Control Execution Environment (CEE) DEVCTL block.
//----------------------------------------------------------------------------------------------
//IMPORTANT:	This block must have the same variable connected to GOP and GOP_LOOP, if this is not done the block will throw an initialisation error and disable itself.
//				This ensures that after an interlock has been triggered the GOP (Generic Output), is reset back to a no command.
//				The block cannot change the value of an input variable so it has to be changed as an output var.
//
//
//Usage:
//		*	Commands are issued by the GOP input variable, 0=No Command, 4 = Request State 0, 5 = Request State 1.
//		*	Boolean inputs are provided for permissive interlocks on each state as well as state overrides (lowest override has priority).
//		*	1 Digital input is provided for state tracking.
//		*	Alarm processing is disabled by default but you can specify alarm settings in the Local Variables section of the DEVCTL block.

GOP_NOCMD := FALSE;	//Reset GOP_NOCMD for current cycle.

//Setup GOP rising edge triggers to ensure the commands are only processed once.
IF GOP = 4 THEN		GOP_EQ4 := TRUE;	ELSE	GOP_EQ4 := FALSE;	END_IF;
IF GOP = 5 THEN		GOP_EQ5 := TRUE;	ELSE	GOP_EQ5 := FALSE;	END_IF;
GOP_4(CLK := GOP_EQ4);
GOP_5(CLK := GOP_EQ5);


//**********************
//**Timer Definitions.**
//**********************
CMDDIS_TON0(CMDDIS_IN0, CMDDIS_TM0);
CMDDIS_TON1(CMDDIS_IN1, CMDDIS_TM1);


//Jump to block initiasation.
IF INIT_PASSED THEN




//Process PV Status
//---------------------------------------------------
	//Single Input
	IF NOT ENABLE_INBET THEN
		IF DI_1 THEN	PV := 5;	ELSE	PV := 4;	END_IF;
	END_IF;
	
	//Dual Input with Inbet processing.
	IF ENABLE_INBET THEN
		IF DI_1 AND NOT DI_2 THEN		PV := 4;	END_IF;		//Close
		IF NOT DI_1 AND NOT DI_2 THEN	PV := 1;	END_IF;		//Travel
		IF NOT DI_1 AND DI_2 THEN		PV := 5;	END_IF;		//Open
		IF DI_1 AND DI_2 THEN			PV := 0;	END_IF;		//Bad
	END_IF;
//---------------------------------------------------



//Process Output Command
//---------------------------------------------------
//Processing order is: Permissive Interlocks, Override Interlocks.
//The last items processed have the final say on the output state.


	//Permissives.
	//..........................
	IF GOP_4.Q AND  PI_0 THEN	GOP_TEMP := 4;	END_IF;			//State 0 Requested & Permissive is on.
	IF GOP_5.Q AND	PI_1 THEN	GOP_TEMP := 5;	END_IF;			//State 1 Requested & Permissive is on.
	
		

	//Overrides.
	//Note: the lowest active override interlock will be the one that is used.
	//..........................
	IF OI_0 AND NOT INTLK_BYPASS THEN
		IF OI_0 AND OP <> 4 THEN	GOP_TEMP := 4;	END_IF;
	ELSE
		IF OI_1 AND OP <> 5 THEN	GOP_TEMP := 5;	END_IF;
	END_IF;
	//Use external block to set the GOP variable to 0, this must be done externally because input params cannot be modified.
	IF NOT INTLK_BYPASS THEN
		IF OI_0 OR OI_1 THEN			GOP_NOCMD := TRUE;	END_IF;
		IF GOP_4.Q AND NOT PI_0 THEN	GOP_NOCMD := TRUE;	END_IF;
		IF GOP_5.Q AND NOT PI_1 THEN	GOP_NOCMD := TRUE;	END_IF;
	ELSE
		//Override bypass enabled.
		IF GOP_4.Q THEN GOP_TEMP := 4;	END_IF;
		IF GOP_5.Q THEN GOP_TEMP := 5;	END_IF;
	END_IF;
	

	//Apply Output
	//..........................
	IF GOP_TEMP = 5 THEN	DO_1 := TRUE;	OP := GOP_TEMP;		CMDDIS_IN1 := TRUE;		CMDDIS_IN0 := FALSE;	END_IF;
	IF GOP_TEMP = 4 THEN	DO_1 := FALSE;	OP := GOP_TEMP;		CMDDIS_IN0 := TRUE;		CMDDIS_IN1 := FALSE;	END_IF;
	
	
	
	//State Ready Status
	//.........................
	IF PI_0 AND NOT OI_1 THEN S0_RDY := TRUE;	ELSE	S0_RDY := FALSE;	END_IF;
	IF PI_1 AND NOT OI_0 THEN S1_RDY := TRUE;	ELSE	S1_RDY := FALSE;	END_IF;
	

//---------------------------------------------------



//Update Status Strings.
//---------------------------------------------------
	IF OP = 4 THEN		OP_DESC := S0_TEXT;		END_IF;
	IF OP = 5 THEN		OP_DESC := S1_TEXT;		END_IF;
	
	IF PV = 4 THEN		PV_DESC := S0_TEXT;		END_IF;
	IF PV = 5 THEN		PV_DESC := S1_TEXT;		END_IF;
	IF PV = 1 THEN		PV_DESC := SINBET_TEXT;	END_IF;
	IF PV = 0 THEN		PV_DESC := SBAD_TEXT;	END_IF;
	
	

//Alarm Processing
	IF CMDDIS_TM0 <> T#0s THEN
		IF CMDDIS_TON0.Q AND PV <> OP THEN	CMDDIS_FL0 := TRUE;		END_IF;
	END_IF;
	IF PV = OP THEN		CMDDIS_FL0 := FALSE;	END_IF;
	
	IF CMDDIS_TM1 <> T#0s THEN
		IF CMDDIS_TON1.Q AND PV <> OP THEN	CMDDIS_FL1 := TRUE;		END_IF;
	END_IF;
	IF PV = OP THEN		CMDDIS_FL1 := FALSE;	END_IF;


	//Turn off timers.
	IF CMDDIS_TON0.Q THEN	CMDDIS_IN0 := FALSE;	END_IF;
	IF CMDDIS_TON1.Q THEN	CMDDIS_IN1 := FALSE;	END_IF;


	//Uncommanded Change Alarm.
	IF PV = 4 OR PV = 5 THEN
		IF LastPV = 4 OR LastPV = 5 THEN
			IF LastPV = LastOP AND LastPV <> PV THEN	UNCMD_FL := TRUE;	END_IF;
		END_IF;
	END_IF;
	IF PV = OP THEN		UNCMD_FL := FALSE;		END_IF;
	
	
	
	//Reset GOP - GOP and GOP_LOOP must always be connected to the same variable.
	IF GOP_NOCMD THEN
		GOP_LOOP := 0;
	ELSE
		GOP_LOOP := GOP;
	END_IF;

	
ELSE
	
	//Block initialisation.	
	GOP_LOOP := 99;					//Write to the GOP_LOOP output and check for a change on the Input.
	IF GOP = 99 THEN
		INIT_PASSED := TRUE;
		ERROR := FALSE;
		ERROR_DESC := '';
		GOP_LOOP := 0;
	ELSE
		ERROR := TRUE;
		ERROR_DESC := 'GOP not connected to GOP_LOOP';
	END_IF;
	
END_IF;

LastPV := PV;
LastOP := OP;
GOP_TEMP := 0;
