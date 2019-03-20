class GoreMut extends Mutator config (SuperGore);

var() config bool Enabled, Debug;
var() config float HealthRemainCap, DamageCap;
var() config int FleshFragments;

function PostBeginPlay () {
	Level.Game.BaseMutator.AddMutator (Self);
	Level.Game.RegisterDamageMutator (Self);
}

function ApplySkin(actor Model) {
	switch (Model.default.mesh) {
		case LodMesh'MPCharacters.mp_jumpsuit':
			Model.multiskins[3] = Texture'pinkmasktex';
			Model.multiskins[4] = Texture'pinkmasktex';
			Model.multiskins[6] = Texture'pinkmasktex';
		case LodMesh'DeusExCharacters.gm_trench':
			Model.multiskins[0] = Texture'pinkmasktex';
	}
}

function MutatorTakeDamage (out Int ActualDamage, Pawn Victim, Pawn InstigatedBy, out Vector HitLocation, out Vector Momentum, Name DamageType) {
	local int i;
	
	if (Debug) BroadcastMessage(Victim.mesh);
	
	if (Enabled) {
		if ( DeusExPlayer(Victim).GetMPHitLocation(HitLocation) == 1 ) {
			if (Debug) BroadcastMessage("Head hit! ("$ActualDamage$"DMG)");
			
			if (DeusExPlayer(Victim).HealthHead <= HealthRemainCap && ActualDamage >= DamageCap) {
				ApplySkin(DeusExPlayer(Victim));
				for (i=0; i<FleshFragments; i++) {
					if (FRand() < 0.8) spawn(class'FleshFragment',,,Victim.Location);
				}	
			}
		}
	}
	
	super.MutatorTakeDamage (ActualDamage, Victim, InstigatedBy, HitLocation, Momentum, DamageType);
}

defaultproperties
{
Enabled=True
Debug=True
HealthRemainCap=0
DamageCap=0
FleshFragments=5
}
