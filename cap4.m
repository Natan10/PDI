IMG 4.25

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

IMG 4.26


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

IMG 4.27

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

IMG 4.31

imgA = imread('Fig0431.jpg');
%filtro gaussiano
filtro_gaussiano = fspecial('gaussian',1026,10);
t_imgA = fft2(imgA);
t_imgA = fftshift(t_imgA);

%filtro gaussiano modificado para 0 ou  1
aux = mat2gray(filtro_gaussiano);

%  g(x,y) = F^-1[F(x,y)*H(x,y)]
img_result_A = t_imgA.*aux;
img_result_A = ifft2(img_result_A);
imshow(mat2gray(abs(img_result_A)))



[r c] = size(imgA);
[x y] = meshgrid(1:r,1:c);
d = sqrt((x-r/2)^2 + (y-c/2)^2);
sigma = 8;
mu = 0;
lo = exp(-((d-mu)**2/(2*sigma^2)));

Hi = 1-lo;

img_aux = t_imgA.*lo;
img_result = ifftshift(img_aux);
img_result_B = ifft2(img_result);
imshow(abs(img_result_B))

==============================================================================================
IMG 4.32

imgA = imread('Fig0432.jpg');

filtro_gaussiano = fspecial('gaussian',768,25);
t_imgB = fftshift(fft2(imgA));
aux = mat2gray(filtro_gaussiano);

img_result_B = t_imgB.*aux;
img_result_B = ifft2(img_result_B);



[r,c] = size(imgA);

imgC = padarray(imgA,[r/2 c/2]);

[r1 c1] = size(imgC);
t_imgC = fft2(imgC,r,c);


filtro_gaussiano2 = fspecial('gaussian',[r1 c1],25);
aux = mat2gray(filtro_gaussiano2);

img_result_C = t_imgC.*aux;

img_result_C = ifft2(img_result_C);
img_result_C = img_result_C(1:r,1:c);
imshow(mat2gray(abs(img_result_C)))

































