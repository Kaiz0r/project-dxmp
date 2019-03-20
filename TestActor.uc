class TestActor extends Actor;

function PostBeginPlay()
{
	local TcpLink DiscordRelay;
	local IpAddr discord;
	discord.Addr = "discordapp.com/api/webhooks/461858508237701120/jUIj3q0tb42XSDVEJnG2_7umXfRGJZZiablLN0oHcVkzfVj-ZJ4n201P-JGrgFCLb97c"
	discord.port = 80
	Log("Initiating discord relay test...");
	DiscordRelay = Spawn(class'TcpLink');
	DiscordRelay.Open(discord);
	DiscordRelay.SendText("{\"content\":This is a test.}");
}
