#fatiamento

function img = fatiamento(img,l_inferior,l_superior,valor)
  [r,c] = size(img);
 for linha=1:r
    for coluna=1:c
      if(img(linha,coluna)>l_inferior && img(linha,coluna)<l_superior)
        img(linha,coluna) = valor;
      endif
    endfor
  endfor
 
endfunction
