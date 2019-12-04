%IMG 2.21

figure()
subplot(2,4,1)
imshow(2*ceil(img/2));
subplot(2,4,2)
imshow(4*ceil(img/4));
subplot(2,4,3)
imshow(8*ceil(img/8));
subplot(2,4,4)
imshow(16*ceil(img/16));
subplot(2,4,5)
imshow(32*ceil(img/32));
subplot(2,4,6)
imshow(64*ceil(img/64));
subplot(2,4,7)
imshow(128*ceil(img/128));
subplot(2,4,8)
imshow(255*ceil(img/255));

=====================================================================
%IMG 2.26

img = imread('../../imagens-pdi/images_chapter_02/Fig0226(galaxy_pair_original).jpg');
k = [1 5 10 20 50 100];

for i=1:length(k)
  img_ruido = uint16(zeros(size(img)));
  for j=1:k(i)
    %Simula o ruído
    img_ruido = img_ruido + uint16(imnoise(img,'gaussian',0,(64/256)^2));
  endfor
  subplot(2,3,i)
  imshow(uint8(img_ruido/k(i)))
endfor

=====================================================================
%IMG 2.27

pkg load image
img27 = imread('../../imagens-pdi/images_chapter_02/Fig0227(a)(infra).jpg');

bit1 = bitget(img27,1);
img27b = img27;
%//img27b(:,:) = (img27(:,:) - bit1(:,:) );
img27b = imsubtract(img27,uint8(bit1));
img27c = imsubtract(img27,img27b);

subplot(1,3,1),imshow(img27);
subplot(1,3,2),imshow(i);
imshow(img27c,[]);


=====================================================================
%IMG 2.28

imgA = imread('Fig0228(a)(mask).jpg');
imgB = imread('Fig0228(b)(angiography_live_ image).jpg');

%Subtrai imagem da mascara
imgC = double(imsubtract(imgA,imgB));

%Deixa a imagem entre [0,1]
imgD = imgC/max(imgC(:));

subplot(2,2,1)
imshow(imgA)
subplot(2,2,2)
imshow(imgB)
subplot(2,2,3)
imshow(imgC)
subplot(2,2,4)

=====================================================================
%IMG 2.29

imgA = imread('Fig0229(a)(tungsten).jpg');
imgB = imread('Fig0229(b)(sensor).jpg');
img_aux_A = double(imgA)/255;
img_aux_B = double(imgB)/255;
imgC = img_aux_A.*img_aux_B;
imgC = uint8(imgC*255);

subplot(1,3,1),imshow(imgA);
subplot(1,3,2),imshow(imgB);
subplot(1,3,3),imshow(imgC);


=====================================================================
%IMG 2.32

imgA = imread('../../imagens-pdi/images_chapter_02/Fig0232(a)(partial_body_scan).jpg');

%Complemento de A
imgB = 255 - imgA;

% Media de intensidade da imagem original
%NO LIVRO, A UNIÃO DUAS IMAGENS É UM ARRANJO MATRICIAL FORMADO A PARTIR DA INTENSIDADE MÁXIMA 
%ENTRE OS PARES DE ELEMENTOS DE MESMA COODENADA ESPACIAL

%imagem constante
img_aux = uint8(ones(size(imgA))*(3*mean(imgA(:))));
imgC = max(imgA,img_aux);

subplot(1,3,1),imshow(imgA);
subplot(1,3,2),imshow(imgB);
subplot(1,3,3),imshow(imgC);



=====================================================================
%IMG 2.36
img = imread("../../imagens-pdi/images_chapter_02/Fig0236(a)(letter_T).jpg");
subplot(1,4,1)
imshow(img)
subplot(1,4,2)
%Interpolação por vizinho mais proximo
rotate_nearest = imrotate(img,-21,'nearest','crop');
imshow(rotate_nearest)
subplot(1,4,3)
%Interpolação Bilinear
rotate_bilinear = imrotate(img,-21,'bilinear','crop');
imshow(rotate_bilinear)
subplot(1,4,4)
%Interpolação Bicubica
rotate_bicubic = imrotate(img,-21,'bicubic','crop');
imshow(rotate_bicubic)



=====================================================================

%IMG 2.40
pkg load image
img40 = imread('Fig0240.jpg');
N = size(img40)(1);
M = size(img40)(2);
P = 2*N;
Q = 2*M;
f = zeros(P,Q);

#// item b)

% aqui foi feito a Transformada de Fourier(fft2) na imagem orignal, e deslocou sua energia para o centro(fftshift)
img40b = fft2(img40);
img40b = fftshift(img40b);
imshow(log(1+abs(img40b)),[])

#// item c)
% H é um filtro passa baixa gaussiano, para simular o filtro da imagem c)
H = fspecial ("gaussian", [P,Q], 50 );
imshow(H,[])

#// item d)
%% Este são os procedimentos feitos na seção 4.7.3, que está explicado na imagem 4.36
f(1:N,1:M) = img40(1:N,1:M);
for i = 1:P
    for j = 1:Q
        f(i,j) = f(i,j)*((-1)^(i+j));
    end
end
Fp = fft2(f);

G = H.*Fp;
gp = real(ifft2(G));
for i = 1:M
    for j = 1:M
        gp(i,j) = gp(i,j)*((-1)^(i+j));
    end
end
gp = gp(1:N,1:M);
imshow(gp, [])