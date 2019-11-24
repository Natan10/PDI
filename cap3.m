%IMG 3.8

img = imread('Fig0308(a)(fractured_spine).jpg');
subplot(2,2,1)
imshow(img)
title('Sem correção')
subplot(2,2,2)
g6 = imadjust(img,[],[],0.6);
imshow(g6)
title('gamma 0.6')
subplot(2,2,3)
g4 = imadjust(img,[],[],0.4);
imshow(g4)
title('gamma 0.4')
subplot(2,2,4)
g3 = imadjust(img,[],[],0.3);
imshow(g3)
title('gamma 0.3')


==========================================================

%IMG 3.12
subplot(1,3,1)
imshow(img)
subplot(1,3,2)
t1 = fatiamento(img,140,250,255);
imshow(t1)
subplot(1,3,3)
t2 = binariza(img,140,250,255);
imshow(t2)

#binariza

function img = binariza(img,l_inferior,l_superior,valor)
  [r,c] = size(img);
 for linha=1:r
    for coluna=1:c
      if(img(linha,coluna)>l_inferior && img(linha,coluna)<l_superior)
      img(linha,coluna) = valor;
      else
      img(linha,coluna)= 0;
      endif
    endfor
  endfor
 
endfunction

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


=======================================================================


%IMG 3.14

plano = imread("Fig0314(a)(100-dollars).jpg");
subplot(3,3,1)
imshow(plano)
k = [1 2 3 4 5 6 7 8];
for i=1:length(k)
  aux = plano_bit(plano,i);
  subplot(3,3,i+1)
  imshow(aux)
endfor

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



============================================================================

%IMG 3.20

img1 = imread('Fig0320(1)(top_left).jpg');
img2 = imread('Fig0320(2)(2nd_from_top).jpg');
img3 = imread('Fig0320(3)(third_from_top).jpg');
img4 = imread('Fig0320(4)(bottom_left).jpg');
subplot(4,3,1)
imshow(img1)
img1_eq = histeq(img1);
subplot(4,3,2)
imshow(img1_eq)
subplot(4,3,3)
imhist(img1_eq)
subplot(4,3,4)
imshow(img2)
img2_eq = histeq(img2);
subplot(4,3,5)
imshow(img2_eq)
subplot(4,3,6)
imhist(img2_eq)
subplot(4,3,7)
imshow(img3)
img3_eq = histeq(img3);
subplot(4,3,8)
imshow(img3_eq)
subplot(4,3,9)
imhist(img3_eq)
subplot(4,3,10)
imshow(img4)
img4_eq = histeq(img4);
subplot(4,3,11)
imshow(img4_eq)
subplot(4,3,12)
imhist(img4_eq)


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



=============================================================================

%IMG 3.25


=============================================================================
%IMG 3.26

=============================================================================

%IMG 3.33 

img = imread('Fig0333(a)(test_pattern_blurring_orig).jpg');
subplot(3,2,1)
imshow(img)
subplot(3,2,2)
mask3 = imfilter(img, ones(3)/9, 'symmetric');
imshow(mask3)
subplot(3,2,3)
mask5 = imfilter(img, ones(5)/25, 'symmetric');
imshow(mask5)
subplot(3,2,4)
mask9 = imfilter(img, ones(9)/9, 'symmetric');
imshow(mask5)
subplot(3,2,5)
mask15 = imfilter(img, ones(15)/225, 'symmetric');
imshow(mask15)
subplot(3,2,6)
mask35 = imfilter(img, ones(35)/1225, 'symmetric');
imshow(mask35)

================================================================================
%IMG 3.34

img = imread('Fig0334(a)(hubble-original).jpg');
subplot(1,3,1)
imshow(img)
subplot(1,3,2)
media = imfilter(img,ones(15)/1225,'symmetric');
imshow(media)
subplot(1,3,3)
bin = binariza(img,140,200,255);
imshow(bin)

================================================================================

%IMG 3.35

img = imread('Fig0335(a)(ckt_board_saltpep_prob_pt05).jpg');
subplot(1,3,1)
imshow(img)
subplot(1,3,2)
media = imfilter(img, ones(3)/9, 'symmetric');
imshow(media)
subplot(1,3,3)
mediana = medfilt2(img,[3 3]);
imshow(mediana)


===================================================================================

%IMG 3.38

%Cria a matriz do Laplaciano, como da Fig 3.37 do livro
lap = [0, 1, 0; 1, -4, 1; 0, 1, 0];
lap8 = [1, 1, 1; 1, -8, 1; 1, 1, 1];

%Pega o valor mínimo da imagem para usar no ajuste do laplaciano
minimo_matrix = filter2(lap, img);
minimo_matrix = minimo_matrix(:);
valor_minimo = min(minimo_matrix);

%Pega o valor mínimo da imagem para usar no ajuste do laplaciano
minimo_matrix_8 = filter2(lap8, img);
minimo_matrix_8 = minimo_matrix_8(:);
valor_minimo_8 = min(minimo_matrix_8);



%Aplica o filtro Laplaciano
IMAGE_LAPLACIANO = uint8(filter2(lap,img));
%Soma a imagem com filtro laplaciano com seu menor valor para ajustar
IMAGE_LAPLACIANO_AJUSTADO = IMAGE_LAPLACIANO + abs(valor_minimo);
%Aguça a imagem com o filtro Laplaciano
IMAGE_AGUCADA = imsubtract(img, IMAGE_LAPLACIANO);
%Aguça a imagem com o filtro Laplaciano com diagonal
IMAGE_LAPLACIANO_8 = uint8(filter2(lap8,img));
IMAGE_AGUCADA_8 = imsubtract(img, IMAGE_LAPLACIANO_8);


%Subplot para a visualização
subplot(2,3,1);
imshow(img)
subplot(2,3,2);
imshow(IMAGE_LAPLACIANO)
subplot(2,3,3);
imshow(IMAGE_LAPLACIANO_AJUSTADO)
subplot(2,3,4);
imshow(IMAGE_AGUCADA)
subplot(2,3,5);
imshow(IMAGE_AGUCADA_8)

==========================================================================================
%IMG 3.42

==========================================================================================

%IMG 3.43

img = imread('Fig0343(a)(skeleton_orig).tif');
subplot(2,4,1);
imshow(img);
title('(a)Imagem Original');

% Mascara Laplaciano item 3.37 (d)
mask = [1 1 1; 1 -8 1; 1 1 1];
% Aplica a mascara a imagem
imgL = filter2(mask, img);
% Faz o ajuste na imagem
imgLA = imgL+abs(min(imgL(:)));
subplot(2,4,2);
imshow(uint8(imgLA));
title('(b)Laplaciano(a)+Ajuste');

% Agucamento a + b
subplot(2,4,3);
imgAB = img + uint8(imgL);
imshow(imgAB);
title('(c)Agucamento a + b ');

% Gradiente de Sobel fig 3.41(d)
maskx = [-1 -2 -1;0 0 0;1 2 1];
% calcula |Gx|
Gx = abs(filter2(mask, img));
% Gradiente de Sobel fig 3.41(e)
mask = [-1,0,1;-2,0,2;-1,0,1];
% calcula |Gy|
Gy = abs(filter2(mask, img));
% Gradiente de Sobel: |Gx|+|Gy|
imgS = uint8(Gx+Gy);
subplot(2,4,4);
imshow(imgS);
title('(d)Gradiente de Sobel');

% Imagem de Sobel suavizada com um filtro de média 5x5
imgFm = filter2(fspecial('average', [5,5]),imgS)/255;
subplot(2,4,5);
imshow(imgFm);
title('(e)Sobel Suavizado');

% Imagem obtida pelo produto (Sobel+Fmedia)*(Agucamento a + b)
imgProd = uint8(double(imgAB).*(imgFm));
subplot(2,4,6);
imshow(imgProd);
title('(f)Imagem c * Imagem e');

% Imagem realcada obtida pela soma a+f
imgAF = img + imgProd;
subplot(2,4,7);
imshow(imgAF);
title('(g)Imagem a + Imagem f');
% Resultado final obtido pela aplicação da transformação de potência
% da equacao 3.2-3 (gamma) em g
img = imadjust(imgAF,[],[],0.5);
subplot(2,4,8);
imshow(img);
title('(h)Transf. Potencia y = 0,5');

 
#  %% Figura 3.43
#  img = imread('Fig0343(a)(skeleton_orig).tif');
#  % Imagem original
#  subplot(2,4,1);
#  imshow(img);
#  title('(a)Imagem Original');
#  % Mascara Laplaciano item 3.37 (d)
#  mask = [1 1 1; 1 -8 1; 1 1 1];
#  % Aplica a mascara a imagem
#  imgL = filter2(mask, img);
#  % Faz o ajuste na imagem
#  imgLA = imgL+abs(min(imgL(:)));
#  subplot(2,4,2);
#  imshow(uint8(imgLA));
#  title('(b)Laplaciano(a)+Ajuste');
#  % Agucamento a + b
#  subplot(2,4,3);
#  imgAB = img + uint8(imgL);
#  imshow(imgAB);
#  title('(c)Agucamento a + b ');
#  % Gradiente de Sobel fig 3.41(d)
#  maskx = [-1 -2 -1;0 0 0;1 2 1];
#  % calcula |Gx|
#  Gx = abs(filter2(mask, img));
#  % Gradiente de Sobel fig 3.41(e)
#  mask = [-1,0,1;-2,0,2;-1,0,1];
#  % calcula |Gy|
#  Gy = abs(filter2(mask, img));
#  % Gradiente de Sobel: |Gx|+|Gy|
#  imgS = uint8(Gx+Gy);
#  subplot(2,4,4);
#  imshow(imgS);
