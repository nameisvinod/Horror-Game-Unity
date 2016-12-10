Shader "Nature/ats Soft Occlusion Bark" {
	Properties {
		_Color ("Main Color", Color) = (1,1,1,0)
		_MainTex ("Main Texture", 2D) = "white" {  }
		_BumpMap ("Bump Map", 2D) = "white" {  }
		
		_Scale ("Scale", Vector) = (1,1,1,1)
		_SquashAmount ("Squash", Float) = 0.5
	}
	SubShader {
		Tags {
			"RenderType"="Opaque"
		}
		CGPROGRAM
		#pragma surface surf Lambert vertex:treevertex addshadow nolightmap
		#include "TerrainEngine.cginc"
		void treevertex (inout appdata_full v) {
			TerrainAnimateTree(v.vertex, v.color.w);
		
			/* Code provided by Chris Morris of Six Times Nothing (http://www.sixtimesnothing.com) */

			// A general tangent estimation	
			float3 T1 = float3(1, 0, 1);
			float3 Bi = cross(T1, v.normal);
			float3 newTangent = cross(v.normal, Bi);
			normalize(newTangent);
			v.tangent.xyz = newTangent.xyz;
			if (dot(cross(v.normal,newTangent),Bi) < 0)
			v.tangent.w = -1.0f;
			else
			v.tangent.w = 1.0f;
			//
		
		}
		
		sampler2D _MainTex;
		sampler2D _BumpMap;

		float4 _Color;
		
		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
		};
		
		void surf (Input IN, inout SurfaceOutput o) {
			half4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Alpha = c.a;
		}
		ENDCG
	}
	
	SubShader {
		Tags {
			"RenderType"="Opaque"
		}

		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma exclude_renderers gles
			#include "SH_Vertex.cginc"
			ENDCG
						
			SetTexture [_MainTex] { combine primary * texture DOUBLE, constant }
		}
	}
	SubShader {
		Tags {
			"RenderType" = "Opaque"
		}
		Pass {
			Tags { "LightMode" = "Vertex" }
			Lighting On
			Material {
				Diffuse [_Color]
				Ambient [_Color]
			}
			SetTexture [_MainTex] { combine primary * texture DOUBLE, constant }
		}		
	}
	
	
	
	Dependency "BillboardShader" = "Hidden/TerrainEngine/Soft Occlusion Bark rendertex"
	Fallback Off
}