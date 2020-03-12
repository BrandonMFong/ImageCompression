% Taking some lines from our homework 1
function Output = GetCbCrSubSample()
    const = Constants();
    rgbImage = imread('Flooded_house.jpg','jpg'); 
    ycbcr=rgb2ycbcr(rgbImage);
    Output(:,:,const.Y) = ycbcr(:,:,const.Y);     
end