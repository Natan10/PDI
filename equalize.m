#Equalização

function img = equalize(img)
  [r,c] = size(img);
  n = zeros(1,256);
  for i=0:255
    n(i+1) = sum(img(:)==i);
  endfor
  
  p = (n*255)/(r*c);
  s = round(cumsum(p));
  
  for i=1:r
    for j=1:c
      img(i,j) = s(1,img(i,j)); 
    endfor
  endfor
  
  
endfunction