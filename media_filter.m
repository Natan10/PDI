#Media

function aux = media_filter(img,tam)
  [r,c] = size(img);
  mask = ones(3);
  soma = sum(reshape(mask,1,[]));
  [rm,cm] = size(mask);
  aux = zeros(r,c);
  
  for i=1:r
    for j=1:c
      for s=1:rm
        for t=1:cm
          aux(i,j) = img(i,j) + mask(s,t)*img(i+s,c+j);
        endfor
      endfor
      aux(i,j) = img(i,j)/soma;
    endfor
  endfor
  
endfunction