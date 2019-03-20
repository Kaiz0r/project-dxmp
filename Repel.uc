class Repel extends Actor;

var int velz, CheckRadius;

function Activate() {
	local vector loc;
	local actor a;
	local ScriptedPawn     hitPawn;
	local PlayerPawn       hitPlayer;
	local DeusExMover      hitMover;
	local DeusExDecoration hitDecoration;
	
	loc = Location;
	loc.Z -= 32;
	
	foreach VisibleActors(class'Actor', A, CheckRadius) {
		if (a != None) {
			hitPawn = ScriptedPawn(a);
			hitDecoration = DeusExDecoration(a);
			hitPlayer = PlayerPawn(a);
			hitMover = DeusExMover(a);
			if (hitPawn != None) {
				hitPawn.SetPhysics(Phys_Falling);
				hitPawn.Velocity = (normal(loc - hitPawn.Location) * velz);	
			}
			else if (hitDecoration != None)	{
				hitDecoration.SetPhysics(Phys_Falling);
				hitDecoration.Velocity = (normal(loc - hitDecoration.Location) * velz);		
			}
			else if (hitPlayer != None)	{
				hitPlayer.SetPhysics(Phys_Falling);
				hitPlayer.Velocity = (normal(loc - hitPlayer.Location) * velz);	
			}
			if (hitMover != None) {
					hitMover.bDrawExplosion = True;
			}
		}		
	}
	Destroy();
}

defaultproperties
{
	bHidden=True
	CheckRadius=256
	velz=-750
}
