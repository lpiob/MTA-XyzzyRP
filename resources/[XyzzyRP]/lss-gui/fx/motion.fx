texture ScreenTexture;	


float Angle = 0;  // Defines the blurring direction
float BlurAmount = 0.0001;  // Defines the blurring magnitude
float Time : TIME;

int drunkLevel=2;
int colorLevel = 0;

sampler ImageSampler = sampler_state
{
	Texture = <ScreenTexture>;
};


float4 main( float2 uv : TEXCOORD) : COLOR
{
	float4 output = 0;  // Defines the output color of a pixel
	float2 offset;  // Defines the blurring direction as a direction vector
	int count = 4 ;
//;	int count = 2;
//;	count=GlobCount;  // Defines the number of blurring iterations

	//First compute a direction vector which defines the direction of blurring. 
	//	This is done using the sincos instruction and the Angle input parameter, 
	//	and the result is stored in the offset variable. This vector is of unit 
	//	length. Multiply this unit vector by BlurAmount to adjust its length to 
	//	reflect the blurring magnitude.
	sincos(Time, offset.y, offset.x);
	offset *= BlurAmount;

	// To generate the blurred image, we 
	//	generate multiple copies of the input image, shifted 
	//	according to the blurring direction vector, and then sum 
	//	them all up to get the final image.

	if (drunkLevel>0)
		output += tex2D(ImageSampler, uv - offset * 1*(drunkLevel*drunkLevel*drunkLevel));
	if (drunkLevel>1)
		output += tex2D(ImageSampler, uv - offset * 2*(drunkLevel*drunkLevel*drunkLevel));
	if (drunkLevel>2)
		output += tex2D(ImageSampler, uv - offset * 3*(drunkLevel*drunkLevel*drunkLevel));
	if (drunkLevel>3)
		output += tex2D(ImageSampler, uv - offset * 4*(drunkLevel*drunkLevel*drunkLevel));
	if (drunkLevel>4)
		output += tex2D(ImageSampler, uv - offset * 5*(drunkLevel*drunkLevel*drunkLevel));


	output /= (drunkLevel+colorLevel); // Normalize the color

	return output;
};

technique MotionBlur
{
	pass P1
	{
		PixelShader = compile ps_2_0 main();
	}
}