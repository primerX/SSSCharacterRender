float _DepthTest;
float ProfileColorTest;
float ProfileRadiusTest;
float _NormalTest;
float _FixPixelLeak;

float DepthTest(float d0, float d1, float d2, float d3, float d4)
{
    _DepthTest = max(.00001, _DepthTest); //so that the screen won't turn black
    
    float zdiff = abs(d0 - d1 - d2 - d3 - d4) < _DepthTest;
    
    return zdiff;
}

float DepthTest(float d0, float d1)
{
    _DepthTest = max(.00001, _DepthTest); //so that the screen won't turn black
    
    float zdiff = abs(d0 - d1) < _DepthTest;
    
    return zdiff;
}

float3 Pow2(float3 x)
{
    return x * x;
}

float2 RandN2(float2 pos, float2 random)
{
    return frac(sin(dot(pos.xy + random, float2(12.9898, 78.233))) * float2(43758.5453, 28001.8384));
}



float ProfileTest(float4 p, float4 pp)
{
    ProfileColorTest = max(.00001, ProfileColorTest); //so that the screen won't turn black
    ProfileRadiusTest = max(.00001, ProfileRadiusTest); //so that the screen won't turn black

    float colorDiffR = saturate(abs(pp.r - p.r) < ProfileColorTest);
    float colorDiffG = saturate(abs(pp.g - p.g) < ProfileColorTest);
    float colorDiffB = saturate(abs(pp.b - p.b) < ProfileColorTest);
    float RadiusDiff = saturate(abs(pp.a - p.a) < ProfileRadiusTest);
    
    return RadiusDiff * colorDiffR * colorDiffG * colorDiffB;
}

float3 DecodeNormal(float4 enc)
{
    float kScale = 1.7777;
    float3 nn = enc.xyz * float3(2 * kScale, 2 * kScale, 0) + float3(-kScale, -kScale, 1);
    float g = 2.0 / dot(nn.xyz, nn.xyz);
    float3 n;
    n.xy = g * nn.xy;
    n.z = g - 1;
    return n;
}

float NormalTest(float4 p, float4 pp)
{
    _NormalTest = max(.00001, _NormalTest); //so that the screen won't turn black
    float3 n = DecodeNormal(p);
    float3 nn = DecodeNormal(pp);
    float colorDiffR = abs(nn.r - n.r) < _NormalTest;
    float colorDiffG = abs(nn.g - n.g) < _NormalTest;
    float colorDiffB = abs(nn.b - n.b) < _NormalTest;
    
    return colorDiffR * colorDiffG /** colorDiffB*/;
}

