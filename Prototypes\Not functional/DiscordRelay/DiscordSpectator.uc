//=============================================================================
// Spectator.
//=============================================================================
class DiscordSpectator extends MessagingSpectator;

var DiscordRelay _IRC;

function string RCR(string in)
{
local string TempMessage, TempLeft, TempRight, OutMessage, _TmpString;
	OutMessage=in;
    while (instr(caps(outmessage), "|P") != -1)
    {
        tempRight=(right(OutMessage, (len(OutMessage)-instr(caps(OutMessage), "|P"))-3));
        tempLeft=(left(OutMessage, instr(caps(OutMessage), "|P")) );
        OutMessage=TempLeft$TempRight;
    }
		return OutMessage;
}

function string RCR2(string in)
{
local string TempMessage, TempLeft, TempRight, OutMessage, _TmpString;
	OutMessage=in;
    while (instr(caps(outmessage), "|C") != -1)
    {
        tempRight=(right(OutMessage, (len(OutMessage)-instr(caps(OutMessage), "|C"))-8));
        tempLeft=(left(OutMessage, instr(caps(OutMessage), "|C")) );
        OutMessage=TempLeft$TempRight;
    }
			return OutMessage;
}

function ClientMessage(coerce string S, optional name Type, optional bool bBeep)
{
local int i;
local string output;
local string line, newnick,ss;

	ss = RCR(s);
	ss = RCR2(ss);
	
	if(Type == 'Say')
	{
    Line = Right(ss, Len(s)-instr(ss,"): ")-Len("): "));
	 newnick = Left(ss, InStr(ss,"("));
	  _IRC.postData(Line);
	  return;
	}
}

defaultproperties
{
}
