function [imgout] = imglevelB(minlevel, maxlevel, realcelevel, imgin)
%IMGLEVEL Summary of this function goes here
%   Detailed explanation goes here

imgout = imgin;
imgsize = size(imgout); 

    for i = 1:imgsize(1)
        for j = 1:imgsize(2)
            pixel = imgout(i,j);
            if pixel >= minlevel &&  pixel <= maxlevel
                imgout(i,j) = realcelevel;
            else
                imgout(i,j) = 0;
            end
        end
    end
end
