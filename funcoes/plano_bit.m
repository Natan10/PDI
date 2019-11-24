##Plano de Bits

function aux = plano(img,n)
  aux = img;
  for i=1:size(img)(1)
    for j=1:size(img)(2)
      if(bitand(aux(i,j),2**n)>0)
        aux(i,j) = 255;
      else
        aux(i,j) = 0;
      endif
    endfor
  endfor
  
endfunction