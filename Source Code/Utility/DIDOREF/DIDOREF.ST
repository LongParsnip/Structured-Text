IF Invert THEN
	Output := NOT Input;
	Inverted := True;
ELSE
	Output := Input;
	Inverted := False;
END_IF;