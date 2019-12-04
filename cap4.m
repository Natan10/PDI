%% Figura 4.17 - Ilustração do aliasing em imagens reamostradas.

a = imread('../pics/chapter_4/Fig0417(a)(barbara).tif');

[rows, columns] = size(a);

b = imresize(a,[0.5*rows 0.5*columns], 'bilinear');

[row, col] = size(b);
r2 = row*2;
c2 = col*2;
I2 = zeros(r2,c2);
I2(1:2:r2, 1:2:c2) = b;
for i = 1:2:r2
    for j = 1:2:c2
        I2(i,j+1) = I2(i,j);
        I2(i+1,j) = I2(i,j);
        I2(i+1,j+1) = I2(i,j);
    end
end

b = I2;

n = 3;
c = conv2(a, ones(n)/n^2,'same');
c = imresize(c,[0.5*rows 0.5*columns], 'bilinear');


[row, col] = size(c);
r2 = row*2;
c2 = col*2;
I2 = zeros(r2,c2);
I2(1:2:r2, 1:2:c2) = c;
for i = 1:2:r2
    for j = 1:2:c2;
        I2(i,j+1) = I2(i,j);
        I2(i+1,j) = I2(i,j);
        I2(i+1,j+1) = I2(i,j);
    end
end

c = I2;

figure; 
subplot(1,3,1);
imshow(a, []);
subplot(1,3,2);
imshow(b, []);
subplot(1,3,3);
imshow(c, []);

=======================================================================
%IMG 4.25

imgA = imread('Fig0425.jpg');
imgC = imread('Fig0426.jpg');

%transformada de fourier da imagem
espectro = fft2(imgA);

%separando o espectro da imagem com abs()
mag = abs(espectro);

%shiftar a imagem para centralizar as bordas
mag = fftshift(mag);

%realçar a imagem usando log
imgB = log(mag+1);


%rotacionar a imagem
imgC = imrotate(imgC,-45);
espectro = fft2(imgC);
mag = abs(espectro);
mag = fftshift(mag);
imgD = log(mag+1);


subplot(2,2,1)
imshow(imgA)
subplot(2,2,2)
imshow(mat2gray(imgB));
subplot(2,2,3)
imshow(imgC)
subplot(2,2,4)
imshow(mat2gray(imgD));


===================================================================

%IMG 4.26


img1 = imread('Fig0426.jpg');
img2 = imread('Fig0425.jpg');
img3 = imrotate(img1,-45);

subplot(2,3,1)
imshow(img1)
subplot(2,3,2)
imshow(img2)
subplot(2,3,3)
imshow(img3)
subplot(2,3,4)
imshow(mat2gray(angle(fft2(img1))));
subplot(2,3,5)
imshow(mat2gray(angle(fft2(img2))));
subplot(2,3,6)
imshow(mat2gray(angle(fft2(img3))));

================================================================

%IMG 4.27

%Aquisiçao da imagens
imgA = imread('Fig0427.jpg');

%Angulo da imagem A
imgB = angle(fft2(imgA));

%Phase, magnitude e espectro da imagem B utilizados na reconstrução 
img_phase = imgB;
img_mag = abs(fft2(imgA));
img_espectro = exp(i*img_phase);

%imagem reconstruida utilizando a transformada inversa
imgC = abs(ifft2(img_espectro));

%calcular a inversa somente com o espectro, usando o logaritimo para realçar a imagem
imgD = log(abs(fftshift(ifft2(img_mag.*exp(i*0))))+1);

%imagem do retangulo e seu espectro
img_ret = imresize(imread('Fig0426.jpg'),[512 512]);
t_ret = fft2(img_ret);
mag_ret = abs(t_ret);
espec_ret = exp(i*angle(t_ret));

%calcular a inversa usando o espectro do retangulo e o angulo de fase da mulher
imgE = ifft2(mag_ret.*img_espectro);

%calcular a inversa usando o espectro da imagem da mulher e o angulo de fase do retangulo
imgF = ifft2(img_mag.*espec_ret);

subplot(2,3,1),imshow(imgA);
subplot(2,3,2),imshow(imgB);
subplot(2,3,3),imshow(mat2gray(imgC));
subplot(2,3,4),imshow(mat2gray(imgD));
subplot(2,3,5),imshow(mat2gray(abs(imgE)));
subplot(2,3,6),imshow(mat2gray(abs(imgF)));

=====================================================================================================

%% Figura 4.31 - Ilustração do aliasing em imagens reamostradas.
pkg load image

src = double(imread('Fig0431.jpg'));

[rows, cols] = size(src);

H = lpfilter('gaussian', rows, cols, 8);
H2 = hpfilter('gaussian', rows, cols, 8);
H3 = hpfilter('gaussian', rows, cols, 8)+0.85;

F = fft2(src);

G = H.*F;
G2 = H2.*F;
G3 = H3.*F;

d = real(ifft2(G));
e = real(ifft2(G2));
f = real(ifft2(G3));

figure; 
subplot(1,3,1);
imshow(d, [])
subplot(1,3,2);
imshow(e, []);
subplot(1,3,3);
imshow(f, []);

=================================================================

%% Figura 4.32 - Ilustração do aliasing em imagens reamostradas.

src = imread('Fig0432.jpg');

[rows, cols] = size(src);

PQ=paddedsize(size(src));

H = lpfilter('gaussian', rows, cols, 8);
H2 = lpfilter('gaussian', PQ(1),PQ(2) , 8);

F = fft2(src);
F2 = fft2(src,PQ(1),PQ(2));

G = H.*F;
G2 = H2.*F2;

b = mat2gray(real(ifft2(G)));
c = mat2gray(real(ifft2(G2)));
c=c(1:size(src,1),1:size(src,2));

figure; 
subplot(1,3,1);
imshow(src, [])
subplot(1,3,2);
imshow(b);
subplot(1,3,3);
imshow(c);


============================================================================

%IMG 4.36

img36 = imread('Fig0431.jpg');
#imshow(img36,[0,255]);
% item b) preencher a imagem  / Passos 1  e 2       %%%%%%%%
N = size(img36)(1);
M = size(img36)(2);
% P e Q são as medidas para o padding, necessário para as operações no domínio da frequência
P = 2*N;
Q = 2*M;
fp = zeros(P,Q);


f = img36;
#imshow(f,[0,255])


% item c)  multiplicar por (-1)^(x+y) / Passo 3 %%%%%%%%
% Este passo serve para centralizar a Transformada de F no domínio da frequência
fp(1:N,1:M) = f(:,:);         
for i = 1:P
  for j = 1:Q
        fp(i,j) = fp(i,j)*((-1)^(i+j));
  endfor
endfor
#imshow(fp, [0,255])


% item d) Espectro de c)     / Passo 4        %%%%%%%%
% Calculo da DFT de fp(a imagem original com padding)                                        
Fp = fft2(fp);
#imshow(log(1+abs(Fp)), [])

% item e)        Filtro real H    / Passo 5.1   %%%%%%%%
% Criação do Filtro Passa Baixa Gaussiano                                        
sigma = 20;
H = fspecial ("gaussian", [P,Q],sigma);
#imshow(H,[])


% item f)          / Passo 5.2                  %%%%%%%%
% Aplicação do Filtro H na imagem Fp , que está no domínio da frequência, para a criação da nova imagem, Gp                                      

Gp = H.*Fp;
#imshow(log(1+abs(Gp)),[])

% item g)           / Passo 6                   %%%%%%%%
% Retorno para o domínio do tempo, sendo extraido apenas a parte real da Transformada Inversa da Gp, para gerar gp
% Não sei o por que de multiplicar por (-1)^(x+y) aqui ...                                   
gp = real(ifft2(Gp));
for i = 1:P
  for j = 1:Q
    gp(i,j) = gp(i,j)*((-1)^(i+j));
  endfor
endfor

#imshow(gp, [])

% item h)          / Passo 7                   %%%%%%%%
% Extração da parte esquerda superior da imagem, para retornar ao seu tamanho s                                         
g = gp(1:M,1:N);
#imshow(g, [])


subplot(3,3,1),imshow(img36,[0,255]);
subplot(3,3,2),imshow(f,[0,255]);
subplot(3,3,3),imshow(fp,[0,255]);
subplot(3,3,4),imshow(log(1+abs(Fp)), []);
subplot(3,3,5),imshow(H,[]);
subplot(3,3,6),imshow(log(1+abs(Gp)),[]);
subplot(3,3,7),imshow(gp, []);
subplot(3,3,8),imshow(g, []);


============================================================================

%IMG 4.38

img38 = imread('../../imagens-pdi/images_chapter_03/jpg\Fig0438.jpg');
aux = abs(fftshift(fft2(img38)));
imgB = log(aux+1);

subplot(1,2,1),imshow(img38);
subplot(1,2,2),imshow(mat2gray(imgB));


imshow(img38,[])
#{
    img38b = img38;
    for i = 1:600
        for j = 1:600
            img38b(i,j) = img38b(i,j)*((-1)^(i+j));
        end
    end
    %pode ser usado para substituir: img38b = real(fftshift(img38b));
}#
img38b = fft2(img38b);
%img38b = real(fftshift(img38b));

imshow(log(1+img38b),[])

============================================================================

%IMG 4.39

src = imread('../../imagens-pdi/images_chapter_04/Fig0438.jpg');
h = [[-1 0 -1], [ -2 0 2], [-1 0 1]];

PQ = paddedsize(size(src));

[rows, cols] = size(src);
f = double(padarray(src,[(PQ(1)-rows)/2 (PQ(2)-cols)/2]));

[rows, cols] = size(h);
h = padarray(h,[floor((PQ(1)-rows)/2) floor((PQ(2)-cols)/2)]);
h = padarray(h,[1 1],0,'post');

F = fft2(f);
H = fft2(h);

G = H.*F;
    
H = fftshift(H);

imshow(abs(H), [])

=====================================================================

%% Figura 4.41 - Espectro de Fourier

src = imread('../../imagens-pdi/images_chapter_04/Fig0441.jpg');

F = fft2(double(src));
F = fftshift(F);

espectro=log(1+abs(F)); 

subplot(1,2,1);
imshow(src, [])
subplot(1,2,2);
imshow(espectro, []);


==============================================================

%% Figura 4.42 - ILPF
home;
clear;
src = imread('../../imagens-pdi/images_chapter_04/Fig0442.jpg');

[rows, cols] = size(src);

H1 = lpfilter('ideal', rows, cols, 10);
H2 = lpfilter('ideal', rows, cols, 30);
H3 = lpfilter('ideal', rows, cols, 60);
H4 = lpfilter('ideal', rows, cols, 160);
H5 = lpfilter('ideal', rows, cols, 460);

F = fft2(double(src), size(H1,1), size(H1,2));

G1 = H1.*F;
G2 = H2.*F;
G3 = H3.*F;
G4 = H4.*F;
G5 = H5.*F;

b = mat2gray(real(ifft2(G1)));
c = mat2gray(real(ifft2(G2)));
d = mat2gray(real(ifft2(G2)));
e = mat2gray(real(ifft2(G2)));
f = mat2gray(real(ifft2(G2)));

b = b(1:size(src,1),1:size(src,2));
c = c(1:size(src,1),1:size(src,2));
d = d(1:size(src,1),1:size(src,2));
e = e(1:size(src,1),1:size(src,2));
f = f(1:size(src,1),1:size(src,2));

figure; 
subplot(3,2,1);
imshow(src)
subplot(3,2,2);
imshow(b)
subplot(3,2,3);
imshow(c)
subplot(3,2,4);
imshow(d)
subplot(3,2,5);
imshow(e)
subplot(3,2,6);
imshow(f)

====================================================================

%% Figura 4.45 - BLPF 

src = imread('../../imagens-pdi/images_chapter_04/Fig0445.jpg');

[rows, cols] = size(src);

H1 = lpfilter('btw', rows, cols, 10, 2);
H2 = lpfilter('btw', rows, cols, 30, 2);
H3 = lpfilter('btw', rows, cols, 60, 2);
H4 = lpfilter('btw', rows, cols, 160, 2);
H5 = lpfilter('btw', rows, cols, 460, 2);

F = fft2(double(src), size(H1,1), size(H1,2));

G1 = H1.*F;
G2 = H2.*F;
G3 = H3.*F;
G4 = H4.*F;
G5 = H5.*F;

b = mat2gray(real(ifft2(G1)));
c = mat2gray(real(ifft2(G2)));
d = mat2gray(real(ifft2(G2)));
e = mat2gray(real(ifft2(G2)));
f = mat2gray(real(ifft2(G2)));

b = b(1:size(src,1),1:size(src,2));
c = c(1:size(src,1),1:size(src,2));
d = d(1:size(src,1),1:size(src,2));
e = e(1:size(src,1),1:size(src,2));
f = f(1:size(src,1),1:size(src,2));

figure; 
subplot(3,2,1);
imshow(src)
subplot(3,2,2);
imshow(b)
subplot(3,2,3);
imshow(c)
subplot(3,2,4);
imshow(d)
subplot(3,2,5);
imshow(e)
subplot(3,2,6);
imshow(f)

%%

H1 = fftshift(lpfilter('btw', 500, 500, 50, 1));
H2 = fftshift(lpfilter('btw', 500, 500, 50, 2));
H3 = fftshift(lpfilter('btw', 500, 500, 50, 5));
H4 = fftshift(lpfilter('btw', 500, 500, 50, 20));

figure; 
subplot(1,4,1);
imshow(abs(H1))
subplot(1,4,2);
imshow(abs(H2))
subplot(1,4,3);
imshow(abs(H3))
subplot(1,4,4);
imshow(abs(H4))


=====================================================================================

%% Figura 4.48 - GLPFs  
home;
clear;
src = imread('../pics/chapter_4/Fig0441(a)(characters_test_pattern).tif');

[rows, cols] = size(src);

H1 = lpfilter('gaussian', rows, cols, 10);
H2 = lpfilter('gaussian', rows, cols, 30);
H3 = lpfilter('gaussian', rows, cols, 60);
H4 = lpfilter('gaussian', rows, cols, 160);
H5 = lpfilter('gaussian', rows, cols, 460);

F = fft2(double(src), size(H1,1), size(H1,2));

G1 = H1.*F;
G2 = H2.*F;
G3 = H3.*F;
G4 = H4.*F;
G5 = H5.*F;

b = mat2gray(real(ifft2(G1)));
c = mat2gray(real(ifft2(G2)));
d = mat2gray(real(ifft2(G2)));
e = mat2gray(real(ifft2(G2)));
f = mat2gray(real(ifft2(G2)));

b = b(1:size(src,1),1:size(src,2));
c = c(1:size(src,1),1:size(src,2));
d = d(1:size(src,1),1:size(src,2));
e = e(1:size(src,1),1:size(src,2));
f = f(1:size(src,1),1:size(src,2));

figure; 
subplot(3,2,1);
imshow(src)
subplot(3,2,2);
imshow(b)
subplot(3,2,3);
imshow(c)
subplot(3,2,4);
imshow(d)
subplot(3,2,5);
imshow(e)
subplot(3,2,6);
imshow(f)















