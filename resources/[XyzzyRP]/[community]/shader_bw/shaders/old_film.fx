texture ScreenSource;
float Flickering;
float Blurring;
float Noise;
float time;
 

sampler TextureSampler = sampler_state
{
    Texture = <ScreenSource>;
};
 
float4 PixelShaderFunction(float2 TextureCoordinate : TEXCOORD0) : COLOR0
{
	float NoiseX = time * sin(TextureCoordinate.x * TextureCoordinate.y + time);
	NoiseX = fmod(NoiseX, 8) * fmod(NoiseX, 4); 
	float DistortX = fmod(NoiseX, Noise);
	float DistortY = fmod(NoiseX, Noise + 0.002);
	float2 DistortTex = float2(DistortX, DistortY);
	
	float4 color = tex2D(TextureSampler, float2(TextureCoordinate.x + Blurring, TextureCoordinate.y + Blurring) + DistortTex);
	color += tex2D(TextureSampler, float2(TextureCoordinate.x - Blurring, TextureCoordinate.y - Blurring));
	color += tex2D(TextureSampler, float2(TextureCoordinate.x + Blurring, TextureCoordinate.y - Blurring));
	color += tex2D(TextureSampler, float2(TextureCoordinate.x - Blurring, TextureCoordinate.y + Blurring));
 
    float value = (color.r + color.g + color.b)/3; 
    color.r = (value*Flickering)/2;
    color.g = (value*Flickering)/2;
    color.b = (value*Flickering)/2;
 
    return color;
}
 
technique OldFilm
{
    pass Pass1
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}