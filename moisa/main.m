#!/usr/bin/octave -qf

pkg load image

function result = parte1(img)
	
	padrao1 = [6, 8, 4; 1, 0, 3; 5, 2, 7];

	normaliza1 = floor((im2double(img))*((3*3) + 1));
	normaliza1 = kron(normaliza1,ones(3));
	mask1 = repmat(padrao1,rows(img), columns(img));
	result = (normaliza1 > mask1)*255;

endfunction

function result = parte2(img)

	padrao2 = [0 12 3 15; 8 4 11 7; 2 14 1 13; 10 6 9 5];

	normaliza2 = floor((im2double(img))*((4*4) + 1));
	normaliza2 = kron(normaliza2,ones(4));
	mask2 = repmat(padrao2,rows(img), columns(img));
	result = (normaliza2 > mask2)*255;

	
endfunction

function result = parte3(img)
	
	img = double(padarray(img, [1, 1], 'symmetric'));
	[x, y] = size(img);
	result = zeros(size(img));
	floyd = [0,0,0;0,0,7/16;3/16,5/16,1/16];

	for i = 2 : (x - 1)
		if (mod(i,2) == 0)
			for j = 2 : (y - 1)
				result(i,j) = (img(i,j) > 128)*255;
				erro = double(img(i,j) - result(i, j));
				img(i-1:i+1, j-1:j+1) += floyd*erro;
			end
		else
			j = (y - 1);
			while(j > 1)
				result(i,j) = (img(i,j) > 128)*255;
				erro = double(img(i,j) - result(i,j));
				img(i-1:i+1, j-1:j+1) += floyd*erro;
				j--	;
			end
		end
	end

	result = result(2:x-1, 2:y-1);
	
endfunction

arg_list = argv();

size = length(arg_list);

if size == 1
img = imread(arg_list{1});
;
parte2(img);

imwrite(parte1(img), strcat(arg_list{1}(1 : end-4), "-half.pbm"))
imwrite(parte2(img), strcat(arg_list{1}(1 : end-4), "-bayer.pbm"))
imwrite(parte3(img), strcat(arg_list{1}(1 : end-4), "-floyd.pbm"))
end

