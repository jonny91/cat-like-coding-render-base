#pragma target 3.0

#include "UnityStandardBRDF.cginc"
#include "UnityPBSLighting.cginc"

float4 _SpecularTint;
float _Smoothness;
float _Metallic;
float4 _Tint;
sampler2D _MainTex;
float4 _MainTex_ST;

struct VertexData
{
    float4 position:POSITION;
    float3 normal :NORMAL;
    float2 uv:TEXCOORD0;
};

struct Interpolators
{
    float4 position:SV_POSITION;
    float3 localPosition:TEXCOORD0;
    float2 uv:TEXCOORD1;
    float3 normal:TEXCOORD2;
    float3 worldPos:TEXCOORD3;
};

Interpolators MyVertexProgram(VertexData v)
{
    Interpolators i;
    i.localPosition = v.position.xyz;
    // i.position = UnityObjectToClipPos(position);
    i.position = UnityObjectToClipPos(v.position);
    // i.uv = v.uv * _MainTex_ST.xy + _MainTex_ST.zw;
    i.uv = TRANSFORM_TEX(v.uv, _MainTex);
    // i.normal = mul((float3x3)unity_ObjectToWorld, v.normal);
    i.normal = UnityObjectToWorldNormal(v.normal);
    i.normal = normalize(i.normal);
    i.worldPos = mul(unity_ObjectToWorld, v.position);
    return i;
}

float4 MyFragmentProgram(Interpolators i) :SV_Target
{
    i.normal = normalize(i.normal);
    float3 lightDir = _WorldSpaceLightPos0.xyz;
    float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

    float3 lightColor = _LightColor0.rgb;
    float3 albedo = tex2D(_MainTex, i.uv).rgb * _Tint.rgb;

    float3 specularTint;
    float oneMinusReflectivity;
    albedo = DiffuseAndSpecularFromMetallic(
        albedo, _Metallic, specularTint, oneMinusReflectivity
    );
				
    UnityLight light;
    light.color = lightColor;
    light.dir = lightDir;
    light.ndotl = DotClamped(i.normal, lightDir);
    UnityIndirect indirectLight;
    indirectLight.diffuse = 0;
    indirectLight.specular = 0;

    return UNITY_BRDF_PBS(
        albedo, specularTint,
        oneMinusReflectivity, _Smoothness,
        i.normal, viewDir,
        light, indirectLight
    );
}
