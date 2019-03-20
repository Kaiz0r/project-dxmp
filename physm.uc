class physm extends Mutator config (TCPhysics);

var() config bool Enabled, Debug, Debris, Explosion, Repel;
var() config float Limit, ExplosionLifespan;

//damagetype fell
//actualdamage > 10
function PostBeginPlay ()
{
	Level.Game.BaseMutator.AddMutator (Self);
	Level.Game.RegisterDamageMutator (Self);
}

function SpawnExplosion(vector Loc)
{
local ShockRing s1, s2, s3;
local SphereEffect se;

    s1 = spawn(class'ShockRing',,,Loc,rot(16384,0,0));
	s1.Lifespan = ExplosionLifespan;
    s2 = spawn(class'ShockRing',,,Loc,rot(0,16384,0));
	s2.Lifespan = ExplosionLifespan;
    s3 = spawn(class'ShockRing',,,Loc,rot(0,0,16384));
	S3.Lifespan = ExplosionLifespan;
	se = spawn(class'SphereEffect',,,Loc,rot(16384,0,0));
	se.Lifespan = ExplosionLifespan;
}

function MutatorTakeDamage (out Int ActualDamage, Pawn Victim, Pawn InstigatedBy, out Vector HitLocation, out Vector Momentum, Name DamageType) {
	local rockchip chip;
	local int i;
	local Repel rp;
	
	if (Debug) {
	Log("PRE");
	Log("Actual Damage: "$ActualDamage);
	Log("Victim: "$Victim);
	log("InstigatedBy: "$InstigatedBy);
	log("Hit Location: "$HitLocation);
	Log("Momentum: "$Momentum);
	Log("DamageType: "$DamageType);	}
	
	if (Enabled && DamageType == 'fell' && ActualDamage >= Limit) {
		if (Explosion) {SpawnExplosion(HitLocation);}
		if (Repel) {rp = spawn(class'Repel',,, HitLocation); rp.Activate();}
		if (Debris)	{
			for (i=0; i<ActualDamage; i++){
				if (Debug) Log("Checking debris spawn chance...");
				if (FRand() < 0.8)
				{
					//chip = 
					spawn(class'Rockchip',,,Victim.Location);
					if (Debug) Log("Spawned debris...");
					//if (chip != None)            
						//chip.RemoteRole = ROLE_None;
				}
			}
		}
	}
	
	super.MutatorTakeDamage (ActualDamage, Victim, InstigatedBy, HitLocation, Momentum, DamageType);
	
	
	//if (Debug) {
	//Log("POST");
	//Log("Actual Damage: "$ActualDamage);
	//Log("Victim: "$Victim);
	//log("InstigatedBy: "$InstigatedBy);
	//log("Hit Location: "$HitLocation);
	//Log("Momentum: "$Momentum);
	//("DamageType: "$DamageType);}

}

defaultproperties
{
ExplosionLifespan=0.5;
Debris=True;
Explosion=True;
}
