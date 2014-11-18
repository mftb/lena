#!/usr/bin/octave -qf

pkg load image

arg_list = argv();

size = length(arg_list);

if size == 1
	img = imread(arg_list{1});
	padrao1 = [6, 8, 4; 1, 0, 3; 5, 2, 7];
	padrao2 = [0 12 3 15; 8 4 11 7; 2 14 1 13; 10 6 9 5];

	normaliza1 = round(img / 255 * 9);
	normaliza1 = kron(normaliza1,ones(3));
	mask1 = repmat(padrao1,rows(img), columns(img));
	result1 = (normaliza1 > mask1)*255;

	normaliza2 = round(img / 255 * 9);
	normaliza2 = kron(normaliza2,ones(4));
	mask2 = repmat(padrao2,rows(img), columns(img));
	result2 = (normaliza2 > mask2)*255;

	imwrite(result1, strcat(arg_list{1}(1 : end-4), "-half.pbm"))

end
