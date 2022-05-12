//Mimics the logic of Honeywell CEE 'LT' less than block.


//Check if IN_1 is greater than IN_2.
IF IN_1 < IN_2 THEN
	OUT := TRUE;
END_IF;


//Reset OUT if it was previously TRUE and if IN_1 is less than IN_2 minus the deadband.
IF OUT AND IN_1 > (IN_2 + DEADBAND) THEN
	OUT := FALSE;
END_IF;