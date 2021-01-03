Shader "Custom/Multi Lighting Shader"
{
    Properties
    {
        _Tint("Tint",Color) = (1,1,1,1)
        _MainTex("Albedo",2D) = "white"{}
        _SpecularTint ("Specular", Color) = (0.5, 0.5, 0.5)
        _Smoothness("Smoothness",range(0,1)) = 0.5
        [Gamma] _Metallic ("Metallic", Range(0, 1)) = 0
    }
    SubShader
    {
        Pass
        {
            Tags
            {
                "LightMode"="ForwardBase"
            }
            CGPROGRAM
            #pragma vertex MyVertexProgram
            #pragma fragment MyFragmentProgram

            #if    !defined(MY_LIGHTING_INCLUDED)
            #define MY_LIGHTING_INCLUDED
            #include "My Lighting.cginc"
            #endif
            ENDCG
        }

        Pass
        {
            Tags
            {
                "LightMode"="ForwardAdd"
            }
            blend one one
            zwrite off
            CGPROGRAM
            #pragma vertex MyVertexProgram
            #pragma fragment MyFragmentProgram

            #if    !defined(MY_LIGHTING_INCLUDED)
            #define MY_LIGHTING_INCLUDED
            #include "My Lighting.cginc"
            #endif
            ENDCG
        }
    }
}