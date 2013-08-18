texture GrayscaleTexture;	

sampler screenSampler = sampler_state
{
	Texture = <GrayscaleTexture>;
};

float4 main(float2 uv : TEXCOORD0) : COLOR0 
{ 
    float4 Color; 
    Color = tex2D( screenSampler , uv); 
	Color.rgb = round((Color.r+Color.g+Color.b)*10.0f)/30.0f;
	Color.r=Color.rgb;
	Color.g=Color.rgb;
	Color.b=Color.rgb;
    return Color; 
};

technique Grayscale
{
	pass P1
	{
		PixelShader = compile ps_2_0 main();
	}
}