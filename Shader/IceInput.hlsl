#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SurfaceInput.hlsl"

CBUFFER_START(UnityPerMaterial)
float4 _GlassTexture_ST;
float4 _GlassNormal_ST;
float4 _DustTexture_ST;
float4 _CracksSDFTexture_ST;

// FogColor
half _UseFogExp2;
half4 _FogColor;
half _FogBase;
half _FogDensity;
half _ShapeSphereRadius;

// Dust
half4 _DustColor;
half4 _DustTextureUVAnim;
half _DustDepthShift;
half _DustLayerBetween;

// Cracks
half4 _CracksColor;
half  _CracksDepthIterations;
half  _CracksDepthScale;
half  _CracksDepthStepSize;
half  _CracksDistortion;
half  _CracksHeight;
half  _CracksWidth;

// Glass
half4 _GlassColor;
half  _GlassNormalScale;
half  _GlassDetailUVScale;

// Refraction
half4 _RefractionColor;
half _UseAberration;

// Reflection
half4 _ReflectionColor;
CBUFFER_END

// Dust
sampler2D _DustTexture;

// Cracks
sampler2D _CracksSDFTexture;
sampler2D _DetailNormal;

// Glass
sampler2D _GlassNormal;
sampler2D _GlassTexture;

// Reflection
samplerCUBE _ReflectionTexture;