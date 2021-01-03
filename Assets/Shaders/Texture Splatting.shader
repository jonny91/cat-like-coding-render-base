Shader "Custom/Texture Spatting"
{
    Properties
    {
        _MainTex("Splat Map",2D) = "white"{}
        [NoScaleOffset]
        _Texture1("Texture 1",2D) = "white"{}
        [NoScaleOffset]
        _Texture2("Texture 2",2D) = "white"{}
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex MyVertexProgram
            #pragma fragment MyFragmentProgram

            #include "UnityCG.cginc"

            sampler2D _MainTex, _Texture1, _Texture2;
            float4 _MainTex_ST, _Texture1_ST, _Texture2_ST;

            struct VertexData
            {
                float4 position:POSITION;
                float2 uv:TEXCOORD0;
            };

            struct Interpolators
            {
                float4 position:SV_POSITION;
                float3 localPosition:TEXCOORD0;
                float2 uv:TEXCOORD1;
                float2 uvSplat:TEXCOORD2;
            };

            Interpolators MyVertexProgram(VertexData v)
            {
                Interpolators i;
                i.localPosition = v.position.xyz;
                // i.position = UnityObjectToClipPos(position);
                i.position = UnityObjectToClipPos(v.position);
                // i.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;
                i.uv = TRANSFORM_TEX(v.uv, _MainTex);
                i.uvSplat = v.uv;
                return i;
            }

            float4 MyFragmentProgram(Interpolators i) :SV_Target
            {
                float4 splat = tex2D(_MainTex, i.uvSplat);
                return tex2D(_Texture1, i.uv) * splat.r
                    + tex2D(_Texture2, i.uv) * (1 - splat.r);
            }
            ENDCG
        }
    }
}