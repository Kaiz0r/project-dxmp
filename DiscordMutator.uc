class DiscordMutator extends Mutator Config (DiscordDX);

//Storing a list of invites, format is just the alphanumeric invite string, NOT the full URL
var() config string InviteString[10];
var() config string OtherURL[10];

replication
{
	//Replicating the function so it executes on the client, not the server
   reliable if (Role == ROLE_Authority)
      ReplExec;
}

simulated function ReplExec(DeusExPlayer Player, string Command)
{
	SetOwner(Player);
	Player.ConsoleCommand(Command);
}


//Adding the mutator to the server
function PostBeginPlay ()
{
	Level.Game.BaseMutator.AddMutator (Self);
}

function Mutate (String S, PlayerPawn Sender)
{
    local int invindex;
	Super.Mutate (S, Sender);
	
	//Format: mutate discord (optional index number)
	
	//First, if the command is just detected as "mutate discord", automatically use index 0
	if (S ~= "discord")
	{
		if(InviteString[0] == "")
		{
			Sender.ClientMessage("|P2No invite found...");
			return;
		}
		SetOwner(Sender);
		BroadcastMessage(Sender.PlayerReplicationInfo.PlayerName$" opened the Discord invite using 'Mutate Discord'.");
		ReplExec(DeusExPlayer(Sender), "Open https://discord.gg/"$InviteString[0]);
	}
	//If they entered an index, use that instead
	else if(Left(S,8) ~= "discord ")
	{
		invindex = int(Right(S, Len(S) - 8));
		if(InviteString[invindex] == "")
		{
			Sender.ClientMessage("|P2No invite found...");
			return;
		}
		SetOwner(Sender);
		BroadcastMessage(Sender.PlayerReplicationInfo.PlayerName$" opened the Discord invite using 'Mutate Discord "$invindex$"'.");
		ReplExec(DeusExPlayer(Sender), "Open https://discord.gg/"$InviteString[invindex]);
	}	
	if (S ~= "url")
	{
		if(OtherURL[0] == "")
		{
			Sender.ClientMessage("|P2No invite found...");
			return;
		}
		SetOwner(Sender);
		BroadcastMessage(Sender.PlayerReplicationInfo.PlayerName$" opened the URL using 'Mutate url'.");
		ReplExec(DeusExPlayer(Sender), "Open "$OtherURL[0]);
	}
	//If they entered an index, use that instead
	else if(Left(S,4) ~= "url ")
	{
		invindex = int(Right(S, Len(S) - 8));
		if(OtherUR[invindex] == "")
		{
			Sender.ClientMessage("|P2No invite found...");
			return;
		}
		SetOwner(Sender);
		BroadcastMessage(Sender.PlayerReplicationInfo.PlayerName$" opened the URL using 'Mutate URL "$invindex$"'.");
		ReplExec(DeusExPlayer(Sender), "Open "$OtherURL[invindex]);
	}
	if (S ~= "rtest")
	{
		SetOwner(Sender);
		ReplExec(DeusExPlayer(Sender), "Exit");
	}
}

defaultproperties
{
	InviteString(0)="SET9mG3"
	InviteString(0)="KUA8acb"
	OtherURL(0)="http://gravity-world.com"
	OtherURL(1)="http://deusex.ucoz.net"
}
