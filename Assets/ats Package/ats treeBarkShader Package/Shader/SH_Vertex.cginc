#include "UnityCG.cginc"
#include "TerrainEngine.cginc"


uniform float _Occlusion, _AO, _BaseLight;
uniform float4 _Color;
uniform float3 _TerrainTreeLightDirections[4];
uniform float4 _TerrainTreeLightColors[4];

struct v2f {
	float4 pos : POSITION;
	float fog : FOGC;
	float4 uv : TEXCOORD0;
	float4 color : COLOR0;
};

v2f vert(appdata_tree v)
{
	v2f o;
	
	TerrainAnimateTree(v.vertex, v.color.w);
	
	float3 viewpos = mul(UNITY_MATRIX_MV, v.vertex);
	o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
	o.fog = o.pos.z;
	o.uv = v.texcoord;
	
	float4 lightDir;
	lightDir.w = _AO;

	float4 lightColor = UNITY_LIGHTMODEL_AMBIENT;
	for (int i = 0; i < 4; i++) {
		lightDir.xyz = _TerrainTreeLightDirections[i];
		float atten = 1.0;

		float occ = dot (lightDir.xyz, v.normal);
		occ = max(0, occ);
		occ *= atten;
		lightColor += _TerrainTreeLightColors[i] * occ;
	}

	lightColor.a = 1;
	o.color = lightColor * _Color;
	o.color.a = 1;
	return o; 
}
