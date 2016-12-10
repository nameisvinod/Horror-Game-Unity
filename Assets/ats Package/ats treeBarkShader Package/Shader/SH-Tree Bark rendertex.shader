Shader "Hidden/TerrainEngine/Soft Occlusion Bark rendertex" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,0)
		_MainTex ("Main Texture", 2D) = "white" {  }
		_BaseLight ("BaseLight", range (0, 1)) = 0.35
		_AO ("Amb. Occlusion", range (0, 10)) = 2.4
		_Scale ("Scale", Vector) = (1,1,1,1)
		_SquashAmount ("Squash", Float) = 1
	}
	SubShader {
		Fog { Mode Off }
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#include "SH_Vertex.cginc"
			#pragma fragment frag 
			sampler2D _MainTex;
			uniform float _Cutoff;
			half4 frag(v2f input) : COLOR
			{
				half4 col = input.color;
				col.rgb *= 2.0f * tex2D( _MainTex, input.uv.xy).rgb;
				return col;
			}
			ENDCG
		}
	}
	SubShader {
		Fog { Mode Off }
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma exclude_renderers gles
			#include "SH_Vertex.cginc"
			ENDCG
			
			SetTexture [_MainTex] {
				combine primary * texture double, primary
			}
		}
	}
	
	Fallback Off
}