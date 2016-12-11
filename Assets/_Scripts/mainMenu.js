var quit=false;
var switchAudio : AudioClip ;
function OnMouseEnter()
{
	
	GetComponent.<Renderer>().material.color = Color.red;		//Change Color to red!
	GetComponent.<AudioSource>().PlayOneShot(switchAudio);
}

function OnMouseExit()
{

	GetComponent.<Renderer>().material.color = Color.white;		//Change Color to white!

}

function OnMouseUp()
{

	if (quit == true)
	{
		Application.Quit();					    //If you click on quit aplication quits.
	}
	else
	{
		Application.LoadLevel("_Scenes/MiniGame");				//If you click on other button it loads game!
	}

}

function Update()
{
if (Input.GetKey(KeyCode.Escape)) 				//If you press (escape) game force closes!
	{
		Application.Quit();
	}

}