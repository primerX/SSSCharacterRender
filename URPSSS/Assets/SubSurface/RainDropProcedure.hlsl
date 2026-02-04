#ifndef _RAIN_DROP_ORIGNAL_HLSL_
#define _RAIN_DROP_ORIGNAL_HLSL_

#define S(a, b, t) smoothstep(a, b, t)

half _RainAmount;

half _DynamicRainDropSpeed;

half _DynamiceLayer1Tiling;
half _DynamiceLayer2Tiling;

half4 _UVGridSize;

float3 N13(float p) 
{
    //  from DAVE HOSKINS
    float3 p3 = frac(float3(p, p, p) * float3(.1031, .11369, .13787));
    p3 += dot(p3, p3.yzx + 19.19);
    return frac(float3((p3.x + p3.y)*p3.z, (p3.x + p3.z)*p3.y, (p3.y + p3.z)*p3.x));
}

float4 N14(float t) 
{
    return frac(sin(t*float4(123., 1024., 1456., 264.))*float4(6547., 345., 8799., 1564.));
}

float N(float t) 
{
    return frac(sin(t*12345.564)*7658.76);
}

float Saw(float b, float t) {
    return S(0., b, t)*S(1., b, t);
}

float2 DropLayer2(float2 uv, float t)
{
    float2 UV = uv;

    uv.y += t*0.75;

    // float2 a = float2(6., 1.);
    float2 a = _UVGridSize.xy;
    float2 grid = a*2.;
    float2 id = floor(uv*grid);

    float colShift = N(id.x);
    uv.y += colShift;

    id = floor(uv*grid);
    float3 n = N13(id.x*35.2 + id.y*2376.1);
    float2 st = frac(uv*grid) - float2(.5, 0);

    float x = n.x - .5;

    float y = UV.y*20.;
    float wiggle = sin(y + sin(y));
    x += wiggle*(.5 - abs(x))*(n.z - .5);
    x *= .7;
    float ti = frac(t + n.z);
    y = (Saw(.85, ti) - .5)*.9 + .5;
    float2 p = float2(x, y);

    float d = length((st - p)*a.yx);

    float mainDrop = S(.4, .0, d);

    // return float2(mainDrop, 1);

    // 拖尾
    float r = sqrt(S(1., y, st.y));
    float cd = abs(st.x - x);
    float trail = S(.23*r, .15*r*r, cd);
    float trailFront = S(-.02, .02, st.y - y);
    trail *= trailFront*r*r;

    // return float2(mainDrop, trail);

    y = UV.y;
    float trail2 = S(.2*r, .0, cd);
    float droplets = max(0., (sin(y*(1. - y)*120.) - st.y))*trail2*trailFront*n.z;
    y = frac(y*10.) + (st.y - .5);
    float dd = length(st - float2(x, y));
    // droplets = S(.3, 0., dd);
    droplets = S(.3, 0., dd * 4);

    float m = mainDrop + droplets*r*trailFront;

    //m += st.x>a.y*.45 || st.y>a.x*.165 ? 1.2 : 0.;
    return float2(m, trail);
}

float StaticDrops(float2 uv, float t) {
    uv *= 40.;

    float2 id = floor(uv);
    uv = frac(uv) - .5;
    float3 n = N13(id.x*107.45 + id.y*3543.654);
    float2 p = (n.xy - .5)*.7;
    float d = length(uv - p);

    float fade = Saw(.025, frac(t + n.z));
    float c = S(.3, 0., d)*frac(n.z*10.)*fade;
    return c;
}

float2 Drops(float2 uv, float t, float l0, float l1, float l2) 
{
    // float s = StaticDrops(uv, t)*l0;
    // float2 m1 = DropLayer2(uv, t)*l1;
    // float2 m2 = DropLayer2(uv*1.85, t)*l2;

    float s = StaticDrops(uv, t) * l0;
    float2 m1 = DropLayer2(uv * _DynamiceLayer1Tiling, t * _DynamicRainDropSpeed) * l1;
    float2 m2 = DropLayer2(uv * _DynamiceLayer2Tiling, t * _DynamicRainDropSpeed) * l2;

    float c = s + m1.x + m2.x;
    c = S(.3, 1., c);

    return float2(c, max(m1.y*l0, m2.y*l1));
}


half4 RainDropFunction(Varyings i)
{
    // float2 uv = ((i.uv * _ScreenParams.xy) - .5*_ScreenParams.xy) / _ScreenParams.y;
    float2 uv = ((i.uv * _ScreenParams.yx) - .5*_ScreenParams.xy) / _ScreenParams.y;
    float2 UV = i.uv.xy;

    float t = _Time.y * 0.2;

    float rainAmount = _RainAmount;

    float staticDrops = S(-.5, 1., rainAmount) * 0;
    float layer1 = S(.25, .75, rainAmount) * 0;
    float layer2 = S(.0, .5, rainAmount) * 1;

    float2 c = Drops(uv, t, staticDrops, layer1, layer2);

    float2 e = float2(.001, 0.);
    float cx = Drops(uv + e, t, staticDrops, layer1, layer2).x;
    float cy = Drops(uv + e.yx, t, staticDrops, layer1, layer2).x;
    float2 n = float2(cx - c.x, cy - c.x);

    // return half4(n.x, n.y, 0, 1);

    float2 texCoord = float2(UV.x + n.x, UV.y + n.y);
    half4 col =  SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, texCoord);

    return col;
}


//--------------------------------------------------------------------
// float2 DebugDropLayer(float2 uv, float t)
// {
//     float2 UV = uv;

//     uv.y += t*0.75;

//     // float2 a = float2(6., 1.);
//     float2 a = _UVGridSize.xy;
//     float2 grid = a*2.;
//     float2 id = floor(uv*grid);

//     float colShift = N(id.x);
//     uv.y += colShift;

//     id = floor(uv*grid);
//     float3 n = N13(id.x*35.2 + id.y*2376.1);
//     float2 st = frac(uv*grid) - float2(.5, 0);

//     float x = n.x - .5;

//     float y = UV.y*20.;
//     float wiggle = sin(y + sin(y));
//     x += wiggle*(.5 - abs(x))*(n.z - .5);
//     x *= .7;
//     float ti = frac(t + n.z);
//     y = (Saw(.85, ti) - .5)*.9 + .5;
//     float2 p = float2(x, y);

//     float d = length((st - p)*a.yx);

//     float mainDrop = S(.4, .0, d);

//     return float2(mainDrop, 1);
// }


// float2 DebugDrops(float2 uv, float t, float layer) 
// {
//     float2 m2 = DebugDropLayer(uv * _DynamiceLayer2Tiling, t * _DynamicRainDropSpeed) * layer;

//     float c = m2.x;
//     c = S(.3, 1., c);

//     return float2(c, 0);
// }

// half4 DebugWaterDop(Varyings i)
// {
//     float2 texCoordUV = i.uv.xy;

//     float2 uv = ((i.uv * _ScreenParams.xy) - .5*_ScreenParams.xy) / _ScreenParams.y;
    
//     float t = _Time.y * 0.2;

//     float rainAmount = _RainAmount;

//     float waterdopLayer = smoothstep(0.0, 0.5, rainAmount);

//     float2 c = DebugDrops(uv, t, waterdopLayer);

//     // 使用程序计算出雨珠的法线效果,使水珠呈现出凹凸效果
//     float2 e = float2(0.001, 0.0);
//     float cx = DebugDrops(uv + e, t, waterdopLayer).x;
//     float cy = DebugDrops(uv + e.yx, t, waterdopLayer).x;
//     float2 n = float2(cx - c.x, cy - c.x);

//     float2 texCoord = float2(texCoordUV.x + n.x, texCoordUV.y + n.y);
//     half4 color =  SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, texCoord);

//     return color;
// }

#endif