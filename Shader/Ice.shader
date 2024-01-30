Shader "Unlit/Ice"
{
    Properties
    {
        [Header(FogColor)]
        [Toggle]_UseFogExp2("UseFogExp2", Float) = 0
        _FogColor("FogColor", Color) = (0.16, 0.42, 0.47, 0.0)
        _FogBase("FogBase", Float) = 0.3
        _FogDensity("FogDensity", Float) = 0.33
        _ShapeSphereRadius("ShapeSphereRadius", Float) = 0.5
        
        [Header(Dust)]
        _DustColor("DustColor", Color) = (1,1,1,1)
        _DustTexture("DustTexture", 2D) = "white" {}
        _DustTextureUVAnim("DustTextureUVAnim", Vector) = (0,0,0,0)
        _DustDepthShift("DustDepthShift", Float) = 0.5
        _DustLayerBetween("DustLayerBetween", Float) = 0.5
        
        [Header(Cracks)]
        _CracksColor("Cracks Color", Color) = (0.1, 0.6, 1.0, 0.7)
        _CracksSDFTexture("Cracks SDF Texture", 2D) = "black" {}
        [IntRange]_CracksDepthIterations("Cracks Depth Iterations", Range(0,10)) = 5
        _CracksDepthScale("Cracks Depth Scale", Float) = 0.09
        _CracksDepthStepSize("Cracks Depth StepSize", Float) = 0.1
        _CracksDistortion("Cracks Distortion", Float) = 0.02
        _CracksHeight("Cracks Height", Float) = 0.8
        _CracksWidth("Cracks Width", Float) = 0.1
        
        [Header(Glass)]
        _GlassColor ("Glass Color", Color) = (1, 1, 1, 0.7)
        _GlassTexture("Glass Tex", 2D) = "black" {}
        _GlassNormal("Glass Normal", 2D) = "bump" {}
        _GlassNormalScale ("Glass Normal Scale", Float) = 1.0
        [noscaleoffset]_DetailNormal("Detail Normal", 2D) = "bump" {}
        _GlassDetailUVScale ("Glass Detail UVScale", Float) = 1.0
        [Toggle(_USEGLASSNORMAL)]_UseGlassNormal ("Use Glass Normal", Float) = 1.0
        [Toggle(_USEDETAILNORMAL)]_UseDetailNormal ("Use Detail Normal", Float) = 1.0
        
        
        
        [Header(Reflection)]
        _ReflectionColor("Reflection Color", Color) = (1,1,1,1)
        [noscaleoffset]_ReflectionTexture("Reflection Texture", Cube) = "black" {}
        
        [Header(Refraction)]
        _RefractionColor("Refraction Color", Color) = (1,1,1,1)
        [Toggle]_UseAberration("UseAberration", Float) = 1.0
    }

    SubShader
    {
        Tags {"RenderType" = "Opaque" "RenderPipeline" = "UniversalPipeline" "Queue"="Geometry"}

        Pass
        {
            Name "Unlit"

            HLSLPROGRAM
            #pragma exclude_renderers gles gles3 glcore
            #pragma target 4.5
            
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _USEGLASSNORMAL
            #pragma shader_feature_local_fragment _USEDETAILNORMAL
            
            // -------------------------------------

            #pragma vertex UnlitPassVertex
            #pragma fragment UnlitPassFragment

            #include "IceInput.hlsl"
            #include "IceForwardPass.hlsl"
            ENDHLSL
        }
    }
}
