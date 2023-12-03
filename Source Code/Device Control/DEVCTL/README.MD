# IMPORTANT!
When using thsi block you must have the same variable connected to both the Input Var 'GOP' and the output Var 'GOP_LOOP'.
As the GOP is used for requesting the state of the block, these need to be connected so that the block can shed the state change request on an interlock condition.
As a ST UDF cannot write to an input parameter, it was required that an identical output var be created.

The block will also check that the input and output vars are connected by writing to the variable, if it doesn't see the change the block will not initialise,
it will throw an error, and all logic processing will not function.
