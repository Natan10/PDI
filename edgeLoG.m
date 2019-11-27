function bw = edgeLoG(im,thresh,std)
    ## Create the filter
    s = ceil(6*std);
    if(rem(s,2)==0)
        s = s + 1;
    end
    %[x y] = meshgrid(-s:s);
    %f = (x.^2 + y.^2 - std^2) .* exp(-(x.^2 + y.^2)/(2*std^2));
    %f = f/sum(f(:));
    f = fspecial("log", s, std);
    ## Perform convolution with the filter f
    g = conv2(im, f, "same");
    ## Find zero crossings
    zc = zerocrossings(g);
    bw = (abs(g) >= thresh) & zc;
 endfunction