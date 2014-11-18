#!/usr/bin/octave -qf

pkg load image
##########################################################################################
# MC940 Laboratoio 03
# Henrique Kenji Umezaki RA 102598
# 19/11/2014

##########################################################################################
# 1.1 Pontilhado ordenado
function result = ordenado(img, n)
	if (n == 3)
		# Dez Padroes
		matriz = [6, 8, 4; 1, 0, 3; 5, 2, 7]
	elseif (n == 4)
		# Bayer
		matriz = [0, 12, 3, 15; 8, 4, 11, 7; 2, 14, 1, 13; 10, 6, 9, 5]
	else
		error("Invalid value");
	end

	# Normaliza a imagem
	normaliza = floor((im2double(img))*((n*n) + 1))
	# Replica cada pixel para ficar do tamanho da matriz de padroes
	normaliza = kron(normaliza,ones(size(matriz)))
	# Replica a matriz de padroes para ficar do tamanho da imagem
	mask = repmat(matriz,size(img))
	result = (normaliza > mask)*255

endfunction

##########################################################################################
# 1.2 Pontilhado por difusão
function result = difusao(img)
	img = double(padarray(img, [1, 1], 'symmetric'))
	[x, y] = size(img)
	result = zeros(size(img))
	floyd = [0,0,0;0,0,7/16;3/16,5/16,1/16]

	for i = 2 : (x - 1)
		if (mod(i,2) == 0)
			for j = 2 : (y - 1)
				result(i,j) = (img(i,j) > 128)*255
				erro = double(img(i,j) - result(i, j))
				img(i-1:i+1, j-1:j+1) += floyd*erro
			end
		else
			j = (y - 1)
			while(j > 1)
				result(i,j) = (img(i,j) > 128)*255
				erro = double(img(i,j) - result(i,j))
				img(i-1:i+1, j-1:j+1) += floyd*erro
				j--	
			end
		end
	end

	result = result(2:x-1, 2:y-1)
endfunction

##########################################################################################

# Carrega os argumentos
args = argv()
img = imread(args{1})

result = ordenado(img, 3)
imwrite(result, strcat(args{1}(1 : end-4), "-dez.png"))

result = ordenado(img, 4)
imwrite(result, strcat(args{1}(1 : end-4), "-bayer.png"))

result = difusao(img)
imwrite(result, strcat(args{1}(1 : end-4), "-floyd.png"))
