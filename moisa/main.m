#!/usr/bin/octave -qf

pkg load image

arg_list = argv();

size = length(arg_list);

if size == 1
	img = imread(arg_list{1});
	padrao1 = [6 8 4; 1 0 3; 5 2 7];
	padrao2 = [0, 12, 3, 15; 8, 4, 11, 7; 2, 14, 1, 13; 10, 6, 9, 5];

	normaliza1 = floor((im2double(img))*((3*3) + 1));
	normaliza1 = kron(normaliza1,ones(size(padrao1)));
	mask1 = repmat(padrao1,size(img));
	result1 = (normaliza > mask)*255;

	normaliza1 = floor((im2double(img))*((4*4) + 1));
	normaliza1 = kron(normaliza,ones(size(padrao1)));
	mask1 = repmat(padrao1,size(img));
	result1 = (normaliza > mask)*255;


	imshow(img1);
	pause(5);
end
