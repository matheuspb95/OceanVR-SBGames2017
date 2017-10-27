Shader "Unlit/CubeMapShader"
{
   Properties {
      //Ao inves de usarmos um _MainTex, usamos um Cubemap
      [NoScaleOffset]_Cube("cube map", Cube) = "" {}
   }
   SubShader {
      Pass {
         //Renderiza o objeto por dentro
         cull front
         CGPROGRAM
         #pragma vertex vert
         #pragma fragment frag
                      
         #include "UnityCG.cginc"
        //Cubemap
         uniform samplerCUBE _Cube;

        //Appdata do mesh apenas com o vertex
         struct appdata {
            float4 vertex : POSITION;
         };

        //uv do cubemap é um float3
         struct v2f {
            float3 uv : TEXCOORD0;
            float4 vertex : SV_POSITION;
         };            
        
         v2f vert (appdata v) {
            v2f o;
            o.uv = v.vertex;
            o.vertex = UnityObjectToClipPos(v.vertex);
            return o;
         }

         //Renderiza o cubemap como textura do material
         fixed4 frag (v2f i) : COLOR {
            float4 result = texCUBE(_Cube, i.uv);
            return result;
         }
         ENDCG
      }
   }
}
