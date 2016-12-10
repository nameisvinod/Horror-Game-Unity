#pragma strict

var flashlightLightSource : Light;
var lightOn : boolean = true;
var lightDrain : float = 0.1;
private static var batteryLife : float = 0.0;
var maxBatteryLife : float = 3.0;

private static var batteryPower : float = 1;

var barDisplay : float = 0;
var pos : Vector2 = new Vector2(20,40);
var size : Vector2 = new Vector2(60,20);
var progressBarEmpty : Texture2D;
var progressBarFull : Texture2D;

var soundTurnOn : AudioClip;
var soundTurnOff : AudioClip;


function Start()
{
	batteryLife = maxBatteryLife;
	flashlightLightSource = GetComponent(Light);
}


static function AlterEnergy (amount : int)
{
	batteryLife = Mathf.Clamp(batteryLife+batteryPower, 0, 100);

}



function Update()
{

//BATTERY LIFE BRIGHTNESS//////////
	if(lightOn && batteryLife >= 0)
	{
		batteryLife -= Time.deltaTime * lightDrain;
	}
		if(lightOn && batteryLife <= 0.4)
	{
		flashlightLightSource.GetComponent.<Light>().intensity = 5;
	}
		if(lightOn && batteryLife <= 0.3)
	{
		flashlightLightSource.GetComponent.<Light>().intensity = 4;
	}
	if(lightOn && batteryLife <= 0.2)
	{
		flashlightLightSource.GetComponent.<Light>().intensity = 3;
	}
		if(lightOn && batteryLife <= 0.1)
	{
		flashlightLightSource.GetComponent.<Light>().intensity = 2;
	}
			if(lightOn && batteryLife <= 0)
	{
		flashlightLightSource.GetComponent.<Light>().intensity = 0;
	}
	

	
	barDisplay = batteryLife;
	
	if(batteryLife <= 0)
	{
		batteryLife = 0;
		lightOn = false;
	}
	
	if(Input.GetKeyUp(KeyCode.F))
	{
		toggleFlashlight();
		toggleFlashlightSFX();
		
		if(lightOn)
		{
			lightOn = false;
		}
		else if (!lightOn && batteryLife >= 0)
		{
			lightOn = true;
		}
	}
}
	
	/////// PIC  ///////////
function OnGUI()
{
 
    // draw the background:
    GUI.BeginGroup (new Rect (pos.x, pos.y, size.x, size.y));
        GUI.Box (Rect (0,0, size.x, size.y),progressBarEmpty);
 		GUI.color = Color.green;
        // draw the filled-in part:
        GUI.BeginGroup (new Rect (0, 0, size.x * barDisplay, size.y));
            GUI.Box (Rect (0,0, size.x, size.y),progressBarFull);
        GUI.EndGroup ();
 
    GUI.EndGroup ();
 
} 
 	
function toggleFlashlight()
{
	if(lightOn)
	{
		flashlightLightSource.enabled = false;
	}
	else
	{
		flashlightLightSource.enabled = true;
	}
}
function toggleFlashlightSFX()
{
	if(flashlightLightSource.enabled)
	{
		GetComponent.<AudioSource>().clip = soundTurnOn;
	}
	else
	{
		GetComponent.<AudioSource>().clip = soundTurnOff;
	}
	GetComponent.<AudioSource>().Play();
	
}

	@script RequireComponent(AudioSource)
	
		
				
	
	