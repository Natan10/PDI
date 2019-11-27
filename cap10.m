IMG 10.4

img = imread('Fig10.02(b).jpg');
mask = [1 1 1;1 -8 1;1 1 1];
img_conv = conv2(img,mask);

[r,c] = size(img_conv);
for i=1:r
  for j=1:c
    if (img_conv(i,j) >= 1823)
      img_conv(i,j) = 255;
    else
      img_conv(i,j) = 0;
    endif
  endfor
endfor

subplot(1,3,1)
imshow(img)
subplot(1,3,2)
imgb = conv2(img,mask);
imshow(imgb)
subplot(1,3,3)
imshow(img_conv)

=======================================================================

%IMG 10.5

imgA = imread('Fig10.04(a).jpg');
imgConv = conv2(imgA, mask);
%% b)
% Adicionando offset cujo valor é o mínimo da matriz
imgB = abs(min(min(imgConv))) + imgConv;
% Rescale da matriz
imgB = uint8(imgB/max(max(imgB)) * 255);
%% c)
% Aplicação do valor abs. e da rescale
imgC = abs(imgConv)/max(max(abs(imgConv))) * 255;
%% d)
% Leva todos os valores menores que 0 para 0
imgConv(imgConv < 0) = 0;
% Rescale
imgD = imgConv/max(max(imgConv)) * 255;
subplot(2, 2, 1);
imshow(imgA);
subplot(2, 2, 2);
imshow(imgB);
subplot(2, 2, 3);
imshow(imgC);
subplot(2, 2, 4);
imshow(imgD);

=====================================================

%IMG 10.7

imgA = imread('Fig10.04(a).jpg');
mask = [2 -1 -1;-1 2 -1;-1 -1 2];

imgconv = conv2(imgA,mask);
img = imgconv + abs(min(imgA(:)));

imgB = imgconv + abs(min(imgconv(:)));
imgB = uint8(imgB/max(imgB(:)) *255);

imgE = imgconv;
imgE(imgE<0)=0;

T = max(imgconv(:));
imgF = imgE;
imgF(imgF>=T)=255;
imgF(imgF<T) = 0;

subplot(2,2,1)
imshow(imgA)
subplot(2,2,2)
imshow(imgB)
subplot(2,2,3)
imshow(imgE)
subplot(2,2,4)
imshow(imgF)
========================================================

%IMG 10.16
%Objetivo: Detecção de bordas utilizando operadores do gradiente de sobel
%Operadores de sobel
pkg load image

imgA = imread('Fig10.10(a).jpg');
%Converte a imagem para o intervalo [0,1]
imgA = double(imgA)/255;
subplot(2,2,1)
imshow(imgA)
maskx = [-1 -2 -1;0 0 0;1 2 1];
masky = [-1 0 1;-2 0 2;-1 0 1];
subplot(2,2,2)
imgB = conv2(imgA,maskx,'same');
imshow(imgB)
subplot(2,2,3)
imgC = conv2(imgA,masky,'same');
imshow(imgC)
subplot(2,2,4)
grad = abs(imgB) + abs(imgC);
imshow(grad)

=======================================================
%IMG 10.16

imgA = imread('../../imagens-pdi/images_chapter_10/Fig1016.jpg');
%Imagem no intervalo de  [0 1]
imgA = double(imgA)/255;
%filtro de sobel para as componentes x e y
maskx = fspecial('sobel');
masky = maskx';

%aplicaçao do filtro de sobel nas imagens para saber o gradiente
imgB = imfilter(imgA,maskx);
imgC = imfilter(imgA,masky);
imgD = abs(imgB)+abs(imgC);


subplot(2,2,1),imshow(imgA);
subplot(2,2,2),imshow(abs(imgB));
subplot(2,2,3),imshow(abs(imgC));
subplot(2,2,4),imshow(imgD);


=========================================================

%IMG 10.17

%Calculo do angulo do gradiente 

angulo = atan(imgB./imgC);
imshow(angulo)

===========================================================
%IMG 10.18

imgA = imread('../../imagens-pdi/images_chapter_10/Fig1018.jpg');
%Imagem no intervalo de  [0 1]
imgA = double(imgA)/255;
%filtro de sobel para as componentes x e y
mask_media = fspecial('average',[5 5]);
maskx = fspecial('sobel');
masky = maskx';

%Aplicaçao do filtro de media 5x5
imgA = conv2(imgA,mask_media);

%aplicaçao do filtro de sobel nas imagens para saber o gradiente
imgB = imfilter(imgA,maskx);
imgC = imfilter(imgA,masky);
imgD = abs(imgB)+abs(imgC);


subplot(2,2,1),imshow(imgA);
subplot(2,2,2),imshow(abs(imgB));
subplot(2,2,3),imshow(abs(imgC));
subplot(2,2,4),imshow(imgD);
=========================================================

%IMG 10.19
%%ODetecção de bordas diagonais utilizando operadores do gradiente de sobel

imgA = imread('Fig10.10(a).jpg');
maskd1 = [0 1 2;-1 0 1;-2 -1 0];
maskd2 = [-2 -1 0;-1 0 1;0 1 2];
imgA = double(imgA)/255;
im1 = conv2(imgA,maskd1,'same');
im2 = conv2(imgA,maskd2,'same');
subplot(1,2,1)
imshow(im1)
subplot(1,2,2)
imshow(im2)

============================================================
%IMG 10.22
%Utilização do algoritmo Marr-Hildreth para
%segmentação por detecção de borda.


imgA = imread("../../imagens-pdi/images_chapter_10/Fig1022.jpg");
#LoG -> G
#//Item b)
std = 4;
n = 26;
G = fspecial('log',n,std );
imgB = conv2(G,imgA);
# item c)
threshC = 0;
imgC =edgeLoG(imgB, threshC, std);
# item d)
threshD = max(imgB(:))*0.04;
imgB = imgB*(255/max(imgB(:)));


imgD = edgeLoG(imgB, threshD, std);

subplot(2,2,1),imshow(imgA);
subplot(2,2,2),imshow(imgB,[]);
subplot(2,2,3),imshow(imgC,[]);
subplot(2,2,4),imshow(imgD,[]);


============================================================
%IMG 10.25
%Comparaçao do algoritmo de Canny com o de Marr-Hildreth e
%limiarização pelo gradiente.

imgA = imread('Fig1025(a)(building_original).jpg');
mask = fspecial('average',[5,5]);
img_aux = imfilter(imgA,mask,'same');

% Gradiente da imagem suavizada pelo filtro de Sobel limiarizada com 33% do maior
valor
[img_grad,~] = imgradient(img_aux,'sobel');
th = 0.12*max(img_grad(:));
imgB = (img_grad > th);

% Detecção de borda pelo método de Marr-Hildreth
%mascara laplaciano do gaussiano
mask2 = fspecial('log',25,4);
imgA = double(imgA)/255;
img_log = imfilter(imgA,mask2,'same');
th = 0.025*max(img_log(:));
[imgC,~] = edge(imgA,'zerocross',th,mask2);

% Detecção de borda pelo método de Canny
[imgD,~] = edge(imgA,'canny',[0.04,0.1],4);
subplot(2,2,1)
imshow(imgA)
subplot(2,2,2)
imshow(imgB)
subplot(2,2,3)
imshow(imgC)
subplot(2,2,4)
imshow(imgD)


===============================================================

%IMG 10.36
%Como o ruído afeta uma imagem.

imgA = imread('Fig10.27(a).jpg');
%Ruido Gaussiano aditivo com media 0 e desvio padrão 10 e 50.
imgB = uint8(imnoise(imgA,'gaussian',0,(10/256)^2));
imgC = uint8(imnoise(imgA,'gaussian',0,(50/256)^2));

%Histograma da imagens.
[histA,~] = imhist(imgA);
[histB,~] = imhist(imgB);
[histC,~] = imhist(imgC);

subplot(2,3,1)
imshow(imgA)
subplot(2,3,2)
imshow(imgB)
subplot(2,3,3)
imshow(imgC)
subplot(2,3,4)
area(histA),xlim([0 255])
subplot(2,3,5)
area(histB),xlim([0 255])
subplot(2,3,6)
area(histC),xlim([0 255])


===================================================================

%IMG 10.37

imgA = imread('Fig1037(a)(septagon_gaussian_noise_mean_0_std_10_added).jpg');
imgB = imread('Fig1037(b)(intensity_ramp).jpg');
imgC = imread('Fig10.30(a)(nonuniform_illumination).jpg');
[histA,L] = imhist(imgA);
[histB,L] = imhist(imgB);
[histC,L] = imhist(imgC);
subplot(2,3,1)
imshow(imgA)
subplot(2,3,2)
imshow(imgB)
subplot(2,3,3)
imshow(imgC)
subplot(2,3,4)
area(histA),xlim([0 255])
subplot(2,3,5)
area(histB),xlim([0 255])
subplot(2,3,6)
area(histC),xlim([0 255])

===================================================================

%IMG 10.39

imgA = imread('Fig1039(a)(polymersomes).jpg');
[histA,L] = imhist(imgA);

%Limiarização Global
[imgC,~] = limiarGlobal(imgA,170,1e-10);
%Limiarização utilizando o algoritmo OTSU
K = graythresh(imgA); 
imgD = imgA(imgA > K*255);

subplot(2,2,1)
imshow(imgA)
subplot(2,2,2)
area(histA),xlim([0 255])
subplot(2,2,3)
imshow(imgC)
subplot(2,2,4)
imshow(imgD)


==================================================================

%IMG 10.40
%Comparação de histogramas e imagens limiarizadas com o método de Otsu

imgA = imread('Fig1040(a)(large_septagon_gaussian_noise_mean_0_std_50_added).jpg');
[histA,L] = imhist(imgA);
K = graythresh(imgA);
imgC = (imgA > K*255);
%Mascara de média 5x5
mask = fspecial('average',[5 5]);
imgD = imfilter(imgA,mask,'same');
[histD,L] = imhist(imgD);
K2 = graythresh(imgD);
imgE = (imgD > K2*255);
subplot(2,3,1)
imshow(imgA)
subplot(2,3,2)
area(histA),xlim([0 255])
subplot(2,3,3)
imshow(imgC)
subplot(2,3,4)
imshow(imgD)
subplot(2,3,5)
area(histD),xlim([0 255])
subplot(2,3,6)
imshow(imgE)


==========================================================================

%10.41
%Como o método de Otsu falha em imagens unimodais.

imgA = imread('Fig1041(a)(septagon_small_noisy_mean_0_stdv_10).tif');
[histA,L] = imhist(imgA);
K = graythresh(imgA);
imgC = (imgA > K*255);
mask = fspecial('average',[5 5]);
imgD = imfilter(imgA,mask,'same');
[histD,L] = imhist(imgD);
K2 = graythresh(imgD);
imgE = (imgD > K2*255);
subplot(2,3,1)
imshow(imgA)
subplot(2,3,2)
area(histA),xlim([0 255])
subplot(2,3,3)
imshow(imgC)
subplot(2,3,4)
imshow(imgD)
subplot(2,3,5)
area(histD),xlim([0 255])
subplot(2,3,6)
imshow(imgE)


==================================================================================

%IMG 10.42

a = imread('../pics/chapter_10/Fig1042(a)(septagon_small_noisy_mean_0_stdv_10).tif');
a = rescale(a);

[Gmag,Gdir] = imgradient(a);

level = prctile(Gmag,[99.7],'all');

c = imbinarize(Gmag,level);

d = immultiply(c,a);
d = rescale(d);

[counts,binLocations] = imhist(d);

counts(1) = 0;

level = otsuthresh(counts);

e = imbinarize(a, level);

figure; 
subplot(2,3,1);
imshow(a, []);
subplot(2,3,2);
imhist(a)
subplot(2,3,3);
imshow(c, []);
subplot(2,3,4);
imshow(d, []);
subplot(2,3,5);
stem(binLocations,counts, 'Marker','none');
subplot(2,3,6);
imshow(e, []);


============================================================

%IMG 10.45

imgA = imread('../../imagens-pdi/images_chapter_10/Fig1045.jpg');
imgB = imhist(imgA);
imgC =imgA;

%Limiar de otsu para a areas
imgC(imgC <= 80) = 0;
imgC(imgC < 80 && imgC <= 177 ) = 127;
imgC(imgC > 177 ) = 255;

subplot(1,3,1),imshow(imgA);
subplot(1,3,2),area(imgB),xlim([0 255]);
subplot(1,3,3),imshow(imgC);



==========================================================

%IMG 10.46

a = imread('../pics/chapter_10/Fig1046(a)(septagon_noisy_shaded).tif');
a = rescale(a);

T = alg_thresh(a,10^-3);
c = imquantize(a,T);

level = graythresh(a);
d = imquantize(a,level);

[m,n] = size(a);

m = ceil(m/2);
n = ceil(n/3);

fun = @(block_struct) imquantize(block_struct.data,graythresh(block_struct.data));

f = blockproc(a,[m n],fun);

f = medfilt2(f);
f = rescale(f);
level = graythresh(f);
f = imquantize(f,level);


figure; 
subplot(2,3,1);
imshow(a, []);
subplot(2,3,2);
imhist(a)
subplot(2,3,3);
imshow(c, []);
subplot(2,3,4);
imshow(d, []);
subplot(2,3,5);
imshow(f, []);
% subplot(2,3,6);
% imshow(e, []);


===========================================================
%IMG 10.51

a = imread('../pics/chapter_10/Fig1051(a)(defective_weld).tif');

c = imquantize(a,254);
c = rescale(c);

c = 1 - c;
[x,y] = find(c==0);

[m,n] = size(c);

d = zeros(m,n);

for i = 1:size(x)
    BW = grayconnected(c,x(i),y(i));
    d = d + bwmorph(BW,'shrink',Inf);
end

d = imbinarize(d,0.1);

a = rescale(a);
c = rescale(c);
e = imabsdiff(a,c);
e = 1 - e;
c = 1 - c;
e = c + e;
e = 1 - e;
c = 1 - c;

level = multithresh(e,2);
g = imquantize(e,level);
h = imquantize(e,min(level));

[x,y] = find(d==1);

[m,n] = size(h);

i = zeros(m,n);
for j = 1:size(x)
    i = i + regiongrowing(1-h,x(j),y(j));
end

figure; 
subplot(3,3,1);
imshow(a, []);
subplot(3,3,2);
imhist(a)
subplot(3,3,3);
imshow(c, []);
subplot(3,3,4);
imshow(d);
subplot(3,3,5);
imshow(e, []);
subplot(3,3,6);
imhist(e);
subplot(3,3,7);
imshow(g,[]);
subplot(3,3,8);
imshow(h, []);
subplot(3,3,9);
imshow(i, []);

figure;
imshow(d);





