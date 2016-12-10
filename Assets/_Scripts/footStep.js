var ground : AudioClip[];

private var step : boolean = true;
var audioStepLengthWalk : float = 0.45;

function OnControllerColliderHit (hit : ControllerColliderHit) {
var controller : CharacterController = GetComponent(CharacterController);

if (controller.isGrounded && controller.velocity.magnitude < 7 && controller.velocity.magnitude > 5 && hit.gameObject.tag == "Ground"  && step == true || 
controller.isGrounded && controller.velocity.magnitude < 7 && controller.velocity.magnitude > 5 && hit.gameObject.tag == "Untagged" && step == true ) {
		WalkOnGround();	
	}
}
/////////////////////////////////// Ground ////////////////////////////////////////
function WalkOnGround() {
	step = false;
	GetComponent.<AudioSource>().clip = ground[Random.Range(0, ground.length)];
	GetComponent.<AudioSource>().volume = .1;
	GetComponent.<AudioSource>().Play();
	yield WaitForSeconds (audioStepLengthWalk);
	step = true;
}
@script RequireComponent(AudioSource)