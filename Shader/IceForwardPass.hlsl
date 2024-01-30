struct Attributes
{
    float4 positionOS : POSITION;
    float2 uv : TEXCOORD0;
    float3 normalOS : NORMAL;
    float4 tangentOS : TANGENT;
};

struct Varyings
{
    float4 positionCS  : SV_POSITION;
    float4 uv0         : TEXCOORD0; // xy:GlassTextureUV    zw:GlassNormalUV
    float4 uv1         : TEXCOORD1; // xy:DustTextureUV     zw:CracksSDFTextureUV
    float3 positionWS  : TEXCOORD2; // 世界空间的模型顶点位置
    float4 normalWS    : TEXCOORD4; // 世界空间的法线方向
    float4 tangentWS   : TEXCOORD5; // 世界空间的切线方向
    float4 bitangentWS : TEXCOORD6; // 垂直于法线与切线方向的第三个方向，这三个方向通常用来把法线贴图转换成世界空间
};

#include "IceFn.hlsl"

Varyings UnlitPassVertex(Attributes input)
{
    Varyings output = (Varyings)0;

    VertexPositionInputs vertexInput = GetVertexPositionInputs(input.positionOS.xyz);

    output.positionCS = vertexInput.positionCS;
    output.positionWS = vertexInput.positionWS;
    output.uv0.xy = TRANSFORM_TEX(input.uv, _GlassTexture);
    output.uv0.zw = TRANSFORM_TEX(input.uv, _GlassNormal);
    output.uv1.xy = TRANSFORM_TEX(input.uv, _DustTexture);
    output.uv1.zw = TRANSFORM_TEX(input.uv, _CracksSDFTexture);

    VertexNormalInputs normalInput = GetVertexNormalInputs(input.normalOS, input.tangentOS);
    half3 viewDirWS = GetWorldSpaceViewDir(vertexInput.positionWS);

    output.normalWS.xyz = normalInput.normalWS;
    output.tangentWS.xyz = normalInput.tangentWS;
    output.bitangentWS.xyz = normalInput.bitangentWS;
    output.normalWS.w = viewDirWS.x;
    output.tangentWS.w = viewDirWS.y;
    output.bitangentWS.w = viewDirWS.z;

    return output;
}

half4 UnlitPassFragment(Varyings input) : SV_Target
{
    IceInputData inputData;
    InitializeIceData(input, inputData);
    half4 finalColor = 1;

    CombinedEffects(input, inputData, finalColor.rgb);

    return finalColor;
}
