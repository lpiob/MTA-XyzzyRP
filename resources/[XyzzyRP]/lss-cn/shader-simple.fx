///////////////////////////////////////////////////////////////////////////////
// Global variables
///////////////////////////////////////////////////////////////////////////////
texture gOrigTexure0 : TEXTURE0;
texture gCustomTex0 : CUSTOMTEX0;
float Time : TIME;


technique simple
{
    pass P0
    {
        Lighting = false;

        // Set the texture
        Texture[0] = gCustomTex0;       // Use custom texture
//        TextureTransform[0] = getTextureTransform();
//        TextureTransformFlags[0] = Count2;
    }
}
