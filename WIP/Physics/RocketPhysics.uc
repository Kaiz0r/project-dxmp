class RocketPhysics extends Rocket;

simulated function DrawExplosionEffects(Vector HitLocation, Vector HitNormal) {
	local Repel rp;
	
	rp = spawn(class'Repel',,, HitLocation);
	rp.Activate();
	super.DrawExplosionEffects(HitLocation, hitNormal);
}

